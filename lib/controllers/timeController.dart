import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeController extends GetxController {
  var morningTime = const TimeOfDay(hour: 9, minute: 30).obs;
  var afternoonTime = const TimeOfDay(hour: 12, minute: 30).obs;
  var eveningTime = const TimeOfDay(hour: 18, minute: 30).obs;

  Future selectMorningTime(BuildContext context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: morningTime.value,
      initialEntryMode: TimePickerEntryMode.dial,
      confirmText: "CONFIRM",
      cancelText: "CANCEL",
      helpText: 'MORNING REMINDER',
    );
    morningTime.value = timeOfDay!;
    update();
  }

  Future selectAfternoonTime(BuildContext context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: afternoonTime.value,
      initialEntryMode: TimePickerEntryMode.dial,
      confirmText: "CONFIRM",
      cancelText: "CANCEL",
      helpText: 'AFTERNOON REMINDER',
    );
    afternoonTime.value = timeOfDay!;
    update();
  }

  Future selectEveningTime(BuildContext context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: eveningTime.value,
      initialEntryMode: TimePickerEntryMode.dial,
      confirmText: "CONFIRM",
      cancelText: "CANCEL",
      helpText: 'EVENING REMINDER',
    );
    eveningTime.value = timeOfDay!;
    update();
  }
}
