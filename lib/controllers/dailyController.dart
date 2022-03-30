// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/apis/dailyHive.dart';
import 'package:flutter_application_1/apis/dailyHive.dart';
import 'package:flutter_application_1/apis/emotionEntryHive.dart';
import 'package:flutter_application_1/controllers/emotionController.dart';
import 'package:flutter_application_1/enums/DailyTask.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DailyController extends GetxController {
  var isDailyEntryDone = false.obs;
  var isDailyExerciseDone = false.obs;
  var showedAvailableTasks = false.obs;
  var isMorningEntryDone = false.obs;
  var isAfternoonEntryDone = false.obs;
  var isEveningEntryDone = false.obs;
  final _emotionController = Get.put(EmotionController());


  void prepareTheObjects() {
    Box box = Hive.box<DailyHive>('daily');
    if (box.isEmpty) {
      DailyHive newDaily = DailyHive(
        currentWeekDay: DateTime.now().weekday, currentDate: DateTime.now(),
        isDailyExerciseDone: false, isDailyEntryDone: false, showedAvailableTasks: false
      );
      box.put('dailyStatus', newDaily);

      _emotionController.createNewEntriesInStorage(0);
    }

    DailyHive daily = box.get('dailyStatus'); 
    DateTime storedDate = daily.currentDate;
    DateTime currentDate = DateTime.now();
    int differenceInDays = currentDate.difference(storedDate).inDays;
    print("DIFFERENCE IN DAYS = $differenceInDays");

    if (differenceInDays > 0) {
      daily.currentWeekDay = currentDate.weekday;
      daily.currentDate = currentDate;
      daily.isDailyExerciseDone = false;
      daily.isDailyEntryDone = false;
      daily.showedAvailableTasks = false;
      daily.save();

      _emotionController.createNewEntriesInStorage(differenceInDays);
    }
    isDailyEntryDone.value = daily.isDailyEntryDone;
    isDailyExerciseDone.value = daily.isDailyExerciseDone;
    showedAvailableTasks.value = daily.showedAvailableTasks;

    // EmotionEntryHive emotionEntry =  _emotionController.getTodaysEmotionEntry();

    update();
  }

  void setDailyTaskToDone(DailyTask task) {
    Box box = Hive.box<DailyHive>('daily');
    DailyHive daily = box.get('dailyStatus');

    if (DailyTask.values.contains(task)) {
      if (task == DailyTask.EmotionEntry) {
        daily.isDailyEntryDone = true;
        isDailyEntryDone.value = true;
      }
      else if (task == DailyTask.Exercise) {
        daily.isDailyExerciseDone = true;
        isDailyExerciseDone.value = true;
      }

      daily.save();
      update();
    }
  }

  void checkIfEntriesDone() {
    EmotionEntryHive emotionEntry =  _emotionController.getTodaysEmotionEntry();
    isMorningEntryDone.value = emotionEntry.morningCheck.mood != 'NoData';
    isAfternoonEntryDone.value = emotionEntry.afternoonCheck.mood != 'NoData';
    isEveningEntryDone.value = emotionEntry.eveningCheck.mood != 'NoData';

    update();
  }

  void updateShowedAvailableTasks(bool showedTasks) {
    showedAvailableTasks.value = showedTasks;
    update();

    Box box = Hive.box<DailyHive>('daily');
    DailyHive daily = box.get('dailyStatus');
    daily.showedAvailableTasks = showedTasks;
    daily.save();    
  }
}
