import 'package:hive/hive.dart';
part 'phqHiveObject.g.dart';

@HiveType(typeId: 13)
class phqHiveObj extends HiveObject {
  @HiveField(0)
  int index;

  @HiveField(1)
  int score;

  @HiveField(2)
  DateTime date;
  

  phqHiveObj({required this.index, required this.score, required this.date});
}
