import 'package:hive/hive.dart';
part 'phqHiveObject.g.dart';

@HiveType(typeId: 13)
class phqHiveObj extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  int score;

  DateTime getDate() {
    return date;
  }

  int getScore() {
    return score;
  }

  phqHiveObj({required this.date, required this.score});
}
