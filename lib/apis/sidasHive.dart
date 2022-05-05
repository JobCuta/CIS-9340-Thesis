import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
part 'sidasHive.g.dart';

@HiveType(typeId: 1)
class sidasHive extends HiveObject {
  @HiveField(0)
  int index;

  @HiveField(1)
  int score;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  List<int> answerValues = [0, 0, 0, 0, 0];

  sidasHive({
    required this.index,
    required this.score,
    required this.date,
    required this.answerValues,
  });

  @override
  toString() => DateFormat('MMMM yyyy').format(date);

  Map toJson() => {'id': index, 'date_created': date.toUtc().toString(), 'sum': score};
}
