
import 'package:flutter_application_1/apis/Level.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';


class LevelController extends GetxController {
  var currentLevel = 0.obs;
  var currentXp = 0.obs;
  var xpForNextLevel = 0.obs;
  var recentlyAddedXp = false.obs;

  void getLevelFromStorage() {
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

  void addXp(int xp) {
    Box box = Hive.box<Level>('level');
    Level level = box.get('userLevel');

    currentXp.value += xp;
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
      recentlyAddedXp.value = true;
    }

    if (currentXp.value > xpForNextLevel.value) checkIfLevelUp();
  }

  void updateRecentlyAddedXp(bool addedXp) {
    recentlyAddedXp.value = addedXp;
    update();
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