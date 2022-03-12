import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/models/Mood.dart';

part 'emotionEntryHive.g.dart';

@HiveType(typeId: 3)
class EmotionEntryHive extends HiveObject{
  @HiveField(0)
  Mood overallMood;

  @HiveField(1)
  String weekday;

  @HiveField(2)
  String date;

  @HiveField(3)
  Map<String, Mood> morningCheck;   // mood and time

  @HiveField(4)
  Map<String, Mood> afternoonCheck;

  @HiveField(5)
  Map<String, Mood> eveningCheck;

  EmotionEntryHive({
    required this.overallMood,
    required this.weekday,
    required this.date,
    required this.morningCheck,
    required this.afternoonCheck,
    required this.eveningCheck,
  });
}