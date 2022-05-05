import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'EmotionEntryDetail.g.dart';

@HiveType(typeId: 4)
class EmotionEntryDetail extends HiveObject {
  @HiveField(0)
  String time;

  @HiveField(1)
  String note;

  @HiveField(2)
  String mood;

  @HiveField(3)
  List<dynamic> positiveEmotions;

  @HiveField(4)
  List<dynamic> negativeEmotions;

  @HiveField(5)
  bool isEmpty;

  @HiveField(6)
  String timeOfDay;

  @HiveField(7)
  int id;

  EmotionEntryDetail({
    this.time = '',
    this.note = '',
    required this.mood,
    required this.positiveEmotions,
    required this.negativeEmotions,
    required this.isEmpty,
    required this.timeOfDay,
    required this.id,
  });

  String getMood() {
    return mood;
  }

  @override
  String toString() {
    return time +
        ", " +
        note +
        ", " +
        mood +
        ", " +
        positiveEmotions.toString() +
        ", " +
        negativeEmotions.toString() +
        ", " +
        id.toString() +
        ", " +
        timeOfDay;
  }
}
