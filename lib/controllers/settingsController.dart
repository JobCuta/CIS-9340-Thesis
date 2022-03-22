import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/timeController.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter_application_1/apis/settingsHive.dart';

import '../apis/userSecureStorage.dart';

class SettingsController extends GetxController {
  var notificationsEnabled = false.obs;
  var notificationsMorningTime = ['6', '30'].obs;
  var notificationsAfternoonTime = ['12', '30'].obs;
  var notificationsEveningTime = ['18', '30'].obs;
  var language = 'English'.obs;
  TimeController timeController = TimeController();

  Box box = Hive.box<SettingsHive>('settings');

  void prepareTheObjects() {
    if (box.isEmpty) {
      SettingsHive settings = SettingsHive(
          notificationsEnabled: false,
          notificationsMorningTime: ['9', '30'],
          notificationsAfternoonTime: ['12', '30'],
          notificationsEveningTime: ['18', '30'],
          language: 'English');
      box.put('settings', settings);
    }
    print('Settings');
    print(box.toMap().length);

    SettingsHive settings = box.get('settings');
    notificationsEnabled.value = settings.notificationsEnabled;
    notificationsMorningTime.value = settings.notificationsMorningTime;
    notificationsAfternoonTime.value = settings.notificationsAfternoonTime;
    notificationsEveningTime.value = settings.notificationsEveningTime;
    language.value = settings.language;
  }

  void updateNotificationSettings(
      {required newNotificationsEnabled,
      required newNotificationsMorningTime,
      required newNotificationsAfternoonTime,
      required newNotificationsEveningTime}) {
    SettingsHive newSettings = SettingsHive(
        notificationsEnabled: newNotificationsEnabled,
        notificationsMorningTime: newNotificationsMorningTime,
        notificationsAfternoonTime: newNotificationsAfternoonTime,
        notificationsEveningTime: newNotificationsEveningTime,
        language: language.value);
    box.putAt(0, newSettings);

    notificationsEnabled.value = newSettings.notificationsEnabled;
    notificationsMorningTime.value = newSettings.notificationsMorningTime;
    notificationsAfternoonTime.value = newSettings.notificationsAfternoonTime;
    notificationsEveningTime.value = newSettings.notificationsEveningTime;

    print('Settings in the controller');
    print('-------------------------------------------------');

    print(notificationsEnabled.value);
    print(notificationsMorningTime.value);
    print(notificationsAfternoonTime.value);
    print(notificationsEveningTime.value);
    print(language.value);

    SettingsHive settings = box.get('settings');
    print('Settings in the box');
    print('-------------------------------------------------');
    print(settings.notificationsEnabled);
    print(settings.notificationsMorningTime);
    print(settings.notificationsAfternoonTime);
    print(settings.notificationsEveningTime);
    print(settings.language);
  }

  void updateLanguageSettings({
    required newLanguage,
  }) {
    SettingsHive newSettings = SettingsHive(
        notificationsEnabled: notificationsEnabled.value,
        notificationsMorningTime: notificationsMorningTime.value,
        notificationsAfternoonTime: notificationsAfternoonTime.value,
        notificationsEveningTime: notificationsEveningTime.value,
        language: newLanguage);
    box.putAt(0, newSettings);

    language.value = newLanguage;

    print('Settings in the controller');
    print('-------------------------------------------------');

    print(notificationsEnabled.value);
    print(notificationsMorningTime.value);
    print(notificationsAfternoonTime.value);
    print(notificationsEveningTime.value);
    print(language.value);

    SettingsHive settings = box.get('settings');
    print('Settings in the box');
    print('-------------------------------------------------');
    print(settings.notificationsEnabled);
    print(settings.notificationsMorningTime);
    print(settings.notificationsAfternoonTime);
    print(settings.notificationsEveningTime);
    print(settings.language);
  }
}
