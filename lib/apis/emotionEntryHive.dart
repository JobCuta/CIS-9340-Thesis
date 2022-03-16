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
  String date;

  @HiveField(3)
  EmotionEntryDetail morningCheck; 

  @HiveField(4)
  EmotionEntryDetail afternoonCheck;

  @HiveField(5)
  EmotionEntryDetail eveningCheck;

  EmotionEntryHive({
    required this.overallMood,
    required this.weekday,
    required this.date,
    required this.morningCheck,
    required this.afternoonCheck,
    required this.eveningCheck,
  });
}