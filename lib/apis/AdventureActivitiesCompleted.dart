import 'package:hive/hive.dart';

class AdventureActivitiesCompleted extends HiveObject{

  @HiveField(0)
  List<bool> apayaoLevelCompleted;

  @HiveField(1)
  List<bool> kalingaLevelCompleted;

  @HiveField(2)
  List<bool> abraLevelCompleted;

  @HiveField(3)
  List<bool> mtProvinceLevelCompleted;

  @HiveField(4)
  List<bool> ifugaoLevelCompleted;

  @HiveField(5)
  List<bool> benguetLevelCompleted;

  AdventureActivitiesCompleted({
    required this.apayaoLevelCompleted,
    required this.kalingaLevelCompleted,
    required this.abraLevelCompleted,
    required this.mtProvinceLevelCompleted,
    required this.ifugaoLevelCompleted,
    required this.benguetLevelCompleted,
   });
}