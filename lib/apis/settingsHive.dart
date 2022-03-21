import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

part 'settingsHive.g.dart';

@HiveType(typeId: 6)
class SettingsHive extends HiveObject {
  @HiveField(0)
  bool notificationsEnabled;

  @HiveField(1)
  TimeOfDay notificationsMorningTime;

  @HiveField(2)
  TimeOfDay notificationsAfternoonTime;

  @HiveField(3)
  TimeOfDay notificationsEveningTime;

  @HiveField(4)
  String language;

  SettingsHive(
      {required this.notificationsEnabled,
      required this.notificationsMorningTime,
      required this.notificationsAfternoonTime,
      required this.notificationsEveningTime,
      required this.language});

  @override
  Future<void> init() async {
    var box = await Hive.openBox('settings');
    if (box.toMap().isNotEmpty) return;
    box.add(SettingsHive(
        notificationsEnabled: false,
        notificationsMorningTime: TimeOfDay(hour: 9, minute: 30),
        notificationsAfternoonTime: TimeOfDay(hour: 12, minute: 30),
        notificationsEveningTime: TimeOfDay(hour: 18, minute: 30),
        language: 'English'));
  }
}
