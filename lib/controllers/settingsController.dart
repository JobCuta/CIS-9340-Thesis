import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/apis/userSecureStorage.dart';
import 'package:flutter_application_1/controllers/timeController.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter_application_1/apis/settingsHive.dart';

class SettingsController extends GetxController {
  var notificationsEnabled = false.obs;
  var notificationsMorningTime = ['9', '30'].obs;
  var notificationsAfternoonTime = ['12', '30'].obs;
  var notificationsEveningTime = ['18', '30'].obs;
  var language = 'English'.obs;
  var imagePath = ''.obs;
  var framePath = ''.obs;
  var phqNotificationsEnabled = false.obs;
  var sidasNotificationsEnabled = false.obs;

  TimeController timeController = TimeController();

  Box box = Hive.box<SettingsHive>('settings');

  void prepareTheObjects() {
    if (box.isEmpty) {
      SettingsHive settings = SettingsHive(
        notificationsEnabled: false,
        notificationsMorningTime: ['9', '30'],
        notificationsAfternoonTime: ['12', '30'],
        notificationsEveningTime: ['18', '30'],
        language: 'English',
        imagePath: '',
        framePath: '',
        phqNotificationsEnabled: false,
        sidasNotificationsEnabled: false,
      );
      box.put('settings', settings);
    }

    SettingsHive settings = box.get('settings');
    notificationsEnabled.value = settings.notificationsEnabled;
    notificationsMorningTime.value = settings.notificationsMorningTime;
    notificationsAfternoonTime.value = settings.notificationsAfternoonTime;
    notificationsEveningTime.value = settings.notificationsEveningTime;
    language.value = settings.language;
    imagePath.value = settings.imagePath;
    framePath.value = settings.framePath;
    // checkValues();
  }

  Future<void> updateNotificationSettings({
    required newNotificationsEnabled,
    required newNotificationsMorningTime,
    required newNotificationsAfternoonTime,
    required newNotificationsEveningTime,
    required newPHQNotificationsEnabled,
    required newSIDASNotificationsEnabled,
  }) async {
    SettingsHive newSettings = SettingsHive(
      notificationsEnabled: newNotificationsEnabled,
      notificationsMorningTime: newNotificationsMorningTime,
      notificationsAfternoonTime: newNotificationsAfternoonTime,
      notificationsEveningTime: newNotificationsEveningTime,
      language: language.value,
      imagePath: imagePath.value,
      framePath: framePath.value,
      phqNotificationsEnabled: newPHQNotificationsEnabled,
      sidasNotificationsEnabled: newSIDASNotificationsEnabled,
    );
    await box.putAt(0, newSettings);

    Map result = await UserProvider().createNotifs(newSettings);
    if (result.isNotEmpty) {
      if (result['id'] == -1) {
        log('user notif settings already exist, updating instead..');
        String notifID = '';
        await UserSecureStorage.getNotifID().then((value) => notifID = value.toString());
        if (notifID.isEmpty || notifID == 'null') {
          log('notifID non existent.');
          Map result = await UserProvider().savedNotifs();
          if (result.isNotEmpty) {
            UserSecureStorage.setNotifID(result['id'].toString());
            log('notifID now updated.');
          }
        } else {
          Map result = await UserProvider().updateNotifs(newSettings, notifID);
          if (result.isNotEmpty) log('notif backend updated');
        }
      } else {
        UserSecureStorage.setNotifID(result['id']);
        log('notif ID saved. ${result['id']}');
        Get.snackbar('Notification Saved', 'Your notification settings were saved in the backend!',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white60, colorText: Colors.black87);
      }
    } else {
      Get.snackbar(
          'There was a problem saving your settings', 'Your notification settings were not saved in the backend',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white60, colorText: Colors.black87);
    }

    notificationsEnabled.value = newSettings.notificationsEnabled;
    notificationsMorningTime.value = newSettings.notificationsMorningTime;
    notificationsAfternoonTime.value = newSettings.notificationsAfternoonTime;
    notificationsEveningTime.value = newSettings.notificationsEveningTime;
    // checkValues();
  }

  Future<void> updateLanguageSettings({
    required newLanguage,
  }) async {
    SettingsHive newSettings = SettingsHive(
      notificationsEnabled: notificationsEnabled.value,
      notificationsMorningTime: notificationsMorningTime.value,
      notificationsAfternoonTime: notificationsAfternoonTime.value,
      notificationsEveningTime: notificationsEveningTime.value,
      language: newLanguage,
      imagePath: imagePath.value,
      framePath: framePath.value,
      phqNotificationsEnabled: phqNotificationsEnabled.value,
      sidasNotificationsEnabled: sidasNotificationsEnabled.value,
    );
    await box.putAt(0, newSettings);

    language.value = newLanguage;
    // checkValues();
  }

  void updateImagePathSettings({
    required newImage,
  }) {
    SettingsHive newSettings = SettingsHive(
      notificationsEnabled: notificationsEnabled.value,
      notificationsMorningTime: notificationsMorningTime.value,
      notificationsAfternoonTime: notificationsAfternoonTime.value,
      notificationsEveningTime: notificationsEveningTime.value,
      language: language.value,
      imagePath: newImage,
      framePath: framePath.value,
      phqNotificationsEnabled: phqNotificationsEnabled.value,
      sidasNotificationsEnabled: sidasNotificationsEnabled.value,
    );
    box.putAt(0, newSettings);
    imagePath.value = newImage;
    update();
    // checkValues();
  }

  void updateFrameSettings({required newFrame}) async {
    SettingsHive newSettings = SettingsHive(
      notificationsEnabled: notificationsEnabled.value,
      notificationsMorningTime: notificationsMorningTime.value,
      notificationsAfternoonTime: notificationsAfternoonTime.value,
      notificationsEveningTime: notificationsEveningTime.value,
      language: language.value,
      imagePath: imagePath.value,
      framePath: newFrame,
      phqNotificationsEnabled: phqNotificationsEnabled.value,
      sidasNotificationsEnabled: sidasNotificationsEnabled.value,
    );
    box.putAt(0, newSettings);
    bool result = await UserProvider().updateFrame(framePath.value);
    log('save frame result $result');

    imagePath.value = newFrame;
    update();
    // checkValues();
  }

  void resetAllValues() {
    SettingsHive settings = box.get('settings');
    notificationsEnabled.value = settings.notificationsEnabled;
    notificationsMorningTime.value = settings.notificationsMorningTime;
    notificationsAfternoonTime.value = settings.notificationsAfternoonTime;
    notificationsEveningTime.value = settings.notificationsEveningTime;
    language.value = settings.language;
    imagePath.value = settings.imagePath;
    framePath.value = settings.framePath;
    phqNotificationsEnabled.value = settings.phqNotificationsEnabled;
    sidasNotificationsEnabled.value = settings.sidasNotificationsEnabled;
    // checkValues();
  }

  void checkValues() {
    print('Settings in the controller (Settings)');
    print('-------------------------------------------------');
    print(notificationsEnabled.value);
    print(notificationsMorningTime.value);
    print(notificationsAfternoonTime.value);
    print(notificationsEveningTime.value);
    print(language.value);
    print(imagePath.value);
    print(framePath.value);
    print(phqNotificationsEnabled.value);
    print(sidasNotificationsEnabled.value);

    SettingsHive settings = box.get('settings');
    print('Settings in the box (Settings)');
    print('-------------------------------------------------');
    print(settings.notificationsEnabled);
    print(settings.notificationsMorningTime);
    print(settings.notificationsAfternoonTime);
    print(settings.notificationsEveningTime);
    print(settings.language);
    print(settings.imagePath);
    print(settings.framePath);
    print(settings.phqNotificationsEnabled);
    print(settings.sidasNotificationsEnabled);
  }
}
