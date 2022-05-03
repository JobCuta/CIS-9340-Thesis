import 'package:hive/hive.dart';

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

  EmotionEntryDetail({
    this.time = '',
    this.note = '',
    required this.mood,
    required this.positiveEmotions,
    required this.negativeEmotions,
    required this.isEmpty,
    required this.timeOfDay
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
        positiveEmotions.length.toString() +
        ", " +
        negativeEmotions.length.toString();
  }
}
