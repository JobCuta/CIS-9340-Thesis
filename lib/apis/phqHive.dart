import 'package:hive/hive.dart';
import 'package:get/get.dart';
part 'phqHive.g.dart';

@HiveType(typeId: 0)
class phqHive extends HiveObject{
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  List<int> answerValues = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  @HiveField(2)
  int sum = 0;

  phqHive({
    required this.date,
    required this.answerValues,
    required this.sum,
  });
}