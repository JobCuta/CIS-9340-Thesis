import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

part 'settingsHive.g.dart';

@HiveType(typeId: 6)
class SettingsHive extends HiveObject {
  @HiveField(0)
  bool notificationsEnabled;

  @HiveField(1)
  List<String> notificationsMorningTime;

  @HiveField(2)
  List<String> notificationsAfternoonTime;

  @HiveField(3)
  List<String> notificationsEveningTime;

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
        notificationsMorningTime: ['9', '30'],
        notificationsAfternoonTime: ['12', '30'],
        notificationsEveningTime: ['18', '30'],
        language: 'English'));
  }
}
