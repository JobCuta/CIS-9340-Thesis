import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter_application_1/apis/settingsHive.dart';

import '../apis/userSecureStorage.dart';

class SettingsController extends GetxController {
  var notificationsEnabled = false;
  var notificationsMorningTime = ['6', '30'];
  var notificationsAfternoonTime = ['12', '30'];
  var notificationsEveningTime = ['18', '30'];
  var language = 'English';

  void prepareTheObjects() {
    Box box = Hive.box<SettingsHive>('settings');
    if (box.isEmpty) {
      SettingsHive settings = SettingsHive(
          notificationsEnabled: false,
          notificationsMorningTime: ['9', '30'],
          notificationsAfternoonTime: ['12', '30'],
          notificationsEveningTime: ['18', '30'],
          language: 'English');
      box.put('settings', settings);
      print('Settings');
      print(box.toMap().length);
    }
    SettingsHive settings = box.get('settings');
  }
}
