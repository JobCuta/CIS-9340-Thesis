// import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyController extends GetxController {
  // not final, will edit further later
  // var _dateNow = DateTime.now().obs;
  var _isDailyEntryDone = false.obs;
  var _isDailyExerciseDone = false.obs;

  // void checkCurrentDateTime() { 
  //   if (_dateNow.value.weekday != DateTime.now().weekday) {
  //     _dateNow.value = DateTime.now();
  //     _isDailyEntryDone.value = false;
  //     _isDailyExerciseDone.value = false;
  //     update();
  //   }
  // }

  void setDailyEntryToDone() {
    _isDailyEntryDone.value = true;
    update();
  }

  void setDailyExerciseToDone() {
    _isDailyExerciseDone.value = true;
    update();
  }

}
