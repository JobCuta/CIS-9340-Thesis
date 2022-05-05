import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
part 'phqHive.g.dart';

@HiveType(typeId: 0)
class phqHive extends HiveObject {
  @HiveField(0)
  int index;

  @HiveField(1)
  int score;

  @HiveField(2)
  DateTime date;

  phqHive({required this.index, required this.score, required this.date});

  @override
  toString() => DateFormat('MMMM yyyy').format(date);

  Map toJson() => {
        'id': index,
        'score': score,
        'date_created': date.toUtc().toString(),
        'date_modified': DateTime.now().toUtc().toString()
      };
}
