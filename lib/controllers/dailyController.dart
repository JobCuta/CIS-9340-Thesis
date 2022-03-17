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
  final _emotionController = Get.put(EmotionController());

  void prepareTheObjects() {
    Box box = Hive.box<DailyHive>('daily');
    if (box.isEmpty) {
      DailyHive newDaily =
          DailyHive(currentWeekDay: DateTime.now().weekday, isDailyExerciseDone: false, isDailyEntryDone: false);
      box.put('dailyStatus', newDaily);
    }

    DailyHive daily = box.get('dailyStatus'); 
    int storedWeekDay = daily.currentWeekDay;
    int currentWeekDay = DateTime.now().weekday;

    if (storedWeekDay != currentWeekDay) {
      daily.currentWeekDay = DateTime.now().weekday;
      daily.isDailyExerciseDone = false;
      daily.isDailyEntryDone = false;
      daily.save();

      _emotionController.saveEntryToStorage();
    }
    isDailyEntryDone.value = daily.isDailyEntryDone;
    isDailyExerciseDone.value = daily.isDailyExerciseDone;

    EmotionEntryHive emotionEntry =  _emotionController.getTodaysEmotionEntry();

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
}
