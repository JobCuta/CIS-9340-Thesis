// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DailyController extends GetxController {
  final GetStorage box = GetStorage("DailyStorage");

  var _isDailyEntryDone = false.obs;
  var _isDailyExerciseDone = false.obs;

  @override
  void onInit() {
    init();
    getDaily();
    checkCurrentDateTime();
    super.onInit();
  }

  void init() {
    box.writeIfNull("currentWeekDay", DateTime.now().weekday);
    box.writeIfNull("isDailyEntryDone", false);
    box.writeIfNull("isDailyExerciseDone", false);
    update();

  }

   Future<void> getDaily() async {
    _isDailyEntryDone.value = await box.read("isDailyEntryDone");
    _isDailyExerciseDone.value = await box.read("isDailyExerciseDone");
    update();
   } 


  Future<void> checkCurrentDateTime() async { 
    int value = await box.read("currentWeekDay");
    int currentWeekDay = DateTime.now().weekday;
    
    if (value != currentWeekDay) {
      await box.write("currentWeekDay", currentWeekDay);
      await box.write("isDailyEntryDone", false);
      await box.write("isDailyExerciseDone", false);

      _isDailyEntryDone.value = false;
      _isDailyExerciseDone.value = false;
      update();
    }
  }

  Future<void> setDailyEntryToDone() async {
    await box.write("isDailyEntryDone", true);
    _isDailyEntryDone.value = true;
    update();
  }

  Future<void> setDailyExerciseToDone() async {
    await box.write("isDailyExerciseDone", true);
    _isDailyExerciseDone.value = true;
    update();
  }

  bool getDailyEntryDone() {
    return _isDailyEntryDone.value;
  }

  bool getDailyExerciseDone() {
    return _isDailyExerciseDone.value;
  }

}
