import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/Level.dart';
import 'package:flutter_application_1/widgets/LevelExperienceModal.dart';
import 'package:flutter_application_1/widgets/LevelTasksTodayModal.dart';
import 'package:flutter_application_1/widgets/LevelUpRewardsModal.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

/* CURRENT EXPERIENCE GAINS
      1. Daily Entry - 5xp            - EmotionalEvaluationEndScreen
      2. All 3 Entries - 20xp         - EmotionalEvaluationEndScreen
      3. Daily Exercise - 10xp        - ShakeScreen

      4. One Game - 50xp                - not yet added
      5. All Games in a Region - 250xp  - not yet added
      6. Mini Games - 10xp              - not yet added
*/

class LevelController extends GetxController {
  var currentLevel = 0.obs;
  var currentXp = 0.obs;
  var xpForNextLevel = 0.obs;

  var recentlyAddedXp = false.obs;
  var accomplishedWithXp = {}.obs;
  var totalXpToAdd = 0.obs;
  var levelUp = false.obs;

  var level2Rewards = {
      'Kalinga Badge' : 'assets/images/achievements/kalinga_adventure_achievements.svg',
      'Kalinga Region' : 'assets/images/kalinga_unlock.svg',
      'Kalinga Frames' : 'assets/images/frames/kalinga_v2.svg',
  };
  var level3Rewards = {
      'Abra Badge' : 'assets/images/achievements/abra_adventure_achievements.svg',
      'Abra Region' : '',
      'Abra Frames' : 'assets/images/frames/abra_v2.svg'
  };
  var level4Rewards = {
      'Mt. Province Badge' : 'assets/images/achievements/mtprovince_adventure_achievements.svg',
      'Mt. Province Region' : '',
      'Mt. Province Frames' : 'assets/images/frames/mtProvince_v2.svg'
  };
  var level5Rewards = {
      'Ifugao Badge' : 'assets/images/achievements/ifugao_adventure_achievements.svg',
      'Ifugao Region' : '',
      'Ifugao Frames' : 'assets/images/frames/ifugao_v2.svg'
  };
  var level6Rewards = {
      'Benguet Badge' : 'assets/images/achievements/benguet_adventure_achievements.svg',
      'Benguet Region' : '',
      'Benguet Frames' : 'assets/images/frames/benguet_v2.svg'
  };


  void prepareTheObjects() {
    Box box = Hive.box<Level>('level');
    if (box.get('userLevel') == null) {
      Level level = Level(currentLevel: 1, currentXp: 0, xpForNextLevel: 1000);
      box.put('userLevel', level);
    }

    Level level = box.get('userLevel');

    currentLevel.value = level.currentLevel;
    currentXp.value = level.currentXp;
    xpForNextLevel.value = level.xpForNextLevel;

    update();
  }

  void getLevelFromStorage() {
    Box box = Hive.box<Level>('level');
    Level level = box.get('userLevel');

    currentLevel.value = level.currentLevel;
    currentXp.value = level.currentXp;
    xpForNextLevel.value = level.xpForNextLevel;

    update();
  }

  // NOTE: if multiple tasks and xp gains, call multiple initializeTaskWithXp then finalizeAddingOfXp
  // NOTE: if single task and one gain of xp, call addXp(taskName, xp)

  // initialize first to add task and its xp to a map of task name -> xp
  void initializeTaskWithXp(String task, int xp) {
    accomplishedWithXp.putIfAbsent(task, () => xp);
    print("EXPERIENCES = " + accomplishedWithXp.toString());

    totalXpToAdd.value += xp;
    update();
  }

  // call this to add all the xp initialized above to the user's experience
  void finalizeAddingOfXp() {
    int xp = totalXpToAdd.value;
    Box box = Hive.box<Level>('level');
    Level level = box.get('userLevel');

    currentXp.value += xp;
    recentlyAddedXp.value = true;
    totalXpToAdd.value = 0;
    checkIfLevelUp();

    update();

    level.currentLevel = currentLevel.value;
    level.currentXp = currentXp.value;
    level.save();
  }

  void addXp(String task, int xp) {
    accomplishedWithXp.putIfAbsent(task, () => xp);
    Box box = Hive.box<Level>('level');
    Level level = box.get('userLevel');

    currentXp.value += xp;
    recentlyAddedXp.value = true;
    totalXpToAdd.value = 0;
    checkIfLevelUp();

    update();

    level.currentLevel = currentLevel.value;
    level.currentXp = currentXp.value;
    level.save();
  }

  void checkIfLevelUp() {
    if (currentXp.value >= xpForNextLevel.value) {
      currentLevel.value++;
      currentXp.value = currentXp.value % xpForNextLevel.value;
      levelUp.value = true;
    }

    if (currentXp.value > xpForNextLevel.value) checkIfLevelUp();
  }

  void updateRecentlyAddedXp(bool addedXp) {
    recentlyAddedXp.value = addedXp;
    update();
  }

  void clearMapOfAccomplishedWithXp() {
    accomplishedWithXp.value = {};
    update();
  }

  void displayLevelXpModal(BuildContext context) {
    
    if (levelUp.value && currentLevel.value < 7) {
      displayRewardsUponLevelUp(context);
    } else {
        Future.delayed(const Duration(seconds: 0)).then((_) {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4), topRight: Radius.circular(4)),
          ),
          useRootNavigator: true,
          isScrollControlled: true,
          builder: (context) {
            return SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: const LevelWidgets());
          });
      });
    }

    updateRecentlyAddedXp(false);
    clearMapOfAccomplishedWithXp();
  }

  void displayTodaysTaskWithXp(BuildContext context) {
    Future.delayed(const Duration(seconds: 0)).then((_) {
        showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4), topRight: Radius.circular(4)),
            ),
            useRootNavigator: true,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            builder: (context) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: const LevelWidgets());
            });
      });
      updateRecentlyAddedXp(false);
  }


  void displayRewardsUponLevelUp(BuildContext context) {
    Future.delayed(const Duration(seconds: 0)).then((_) {
      showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4), topRight: Radius.circular(4)),
          ),
          useRootNavigator: true,
          // isScrollControlled: true,
          backgroundColor: Colors.white,
          builder: (context) {
            return SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: const LevelUpRewardWidgets());
          });

      levelUp.value = false;
      update();
    });
  }

  // FOR ADMIN AND TESTING PURPOSES ONLY
  void setLevel(int lvl) {
    Box box = Hive.box<Level>('level');
    Level level = box.get('userLevel');

    currentLevel.value = lvl;
    update();

    level.currentLevel = currentLevel.value;
    level.save();
  }
}