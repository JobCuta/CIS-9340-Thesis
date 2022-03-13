// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/apis/dailyHive.dart';
import 'package:flutter_application_1/apis/dailyHive.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DailyController extends GetxController {

  var _isDailyEntryDone = false.obs;
  var _isDailyExerciseDone = false.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
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
      daily = DailyHive(currentWeekDay: DateTime.now().weekday, isDailyExerciseDone: false, isDailyEntryDone: false);
      daily.save();
    }
    _isDailyEntryDone.value = daily.isDailyEntryDone;
    _isDailyExerciseDone.value = daily.isDailyExerciseDone;

    update();
  }

  void setDailyTaskToDone(String task) {
    Box box = Hive.box<DailyHive>('daily');
    DailyHive daily = box.get('dailyStatus');

    if (task == 'entry') {
      daily.isDailyEntryDone = true;
      _isDailyEntryDone.value = true;
    }
    else {
      daily.isDailyExerciseDone = true;
      _isDailyExerciseDone.value = true;
    }

    daily.save();
    update();
  }

  bool getDailyEntryDone() {
    return _isDailyEntryDone.value;
  }

  bool getDailyExerciseDone() {
    return _isDailyExerciseDone.value;
  }

}
