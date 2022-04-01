import 'package:hive/hive.dart';
import 'package:get/get.dart';

part 'dailyHive.g.dart';

@HiveType(typeId: 2)
class DailyHive extends HiveObject{
  @HiveField(0)
  int currentWeekDay;

  @HiveField(1)
  DateTime currentDate;

  @HiveField(2)
  bool isDailyExerciseDone;

  @HiveField(3)
  bool isDailyEntryDone;

  @HiveField(4)
  bool showedAvailableTasks;

  DailyHive({
    required this.currentWeekDay,
    required this.currentDate,
    required this.isDailyExerciseDone,
    required this.isDailyEntryDone,
    required this.showedAvailableTasks
  });
}