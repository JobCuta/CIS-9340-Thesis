import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/enums/Mood.dart';

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
  Map<Mood, String> morningCheck;   // mood and time

  @HiveField(4)
  Map<Mood, String> afternoonCheck;

  @HiveField(5)
  Map<Mood, String> eveningCheck;

  EmotionEntryHive({
    required this.overallMood,
    required this.weekday,
    required this.date,
    required this.morningCheck,
    required this.afternoonCheck,
    required this.eveningCheck,
  });
}