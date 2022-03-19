import 'package:hive/hive.dart';
import 'package:get/get.dart';

import 'EmotionEntryDetail.dart';

part 'emotionEntryHive.g.dart';

@HiveType(typeId: 3)
class EmotionEntryHive extends HiveObject{
  @HiveField(0)
  String overallMood;

  @HiveField(1)
  String weekday;

  @HiveField(2)
  String month;

  @HiveField(3)
  int day;

  @HiveField(4)
  int year;

  @HiveField(5)
  EmotionEntryDetail morningCheck; 

  @HiveField(6)
  EmotionEntryDetail afternoonCheck;

  @HiveField(7)
  EmotionEntryDetail eveningCheck;

  EmotionEntryHive({
    required this.overallMood,
    required this.weekday,
    required this.month,
    required this.day,
    required this.year,
    required this.morningCheck,
    required this.afternoonCheck,
    required this.eveningCheck,
  });
}