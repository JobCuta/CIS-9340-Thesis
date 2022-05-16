import 'package:hive/hive.dart';
import 'package:get/get.dart';

part 'AdventureProgress.g.dart';

@HiveType(typeId: 12)
class AdventureProgress extends HiveObject{
  @HiveField(0)
  List<bool> memoryProvinceCompleted = [false, false, false, false, false, false];

  @HiveField(1)
  List<bool> sudokuProvinceCompleted = [false, false, false, false, false, false];

  @HiveField(2)
  List<bool> copingProvinceCompleted = [false, false, false, false, false, false];

  @HiveField(3)
  List<bool> apayaoCardsCompleted = [false, false, false, false, false, false, false, false];

  @HiveField(4)
  List<bool> kalingaCardsCompleted = [false, false, false, false, false, false, false, false];

  @HiveField(5)
  List<bool> abraCardsCompleted = [false, false, false, false, false, false, false, false];

  @HiveField(6)
  List<bool> mountainProvinceCardsCompleted = [false, false, false, false, false, false, false, false];

  @HiveField(7)
  List<bool> ifugaoCardsCompleted = [false, false, false, false, false, false, false, false];

  @HiveField(8)
  List<bool> benguetCardsCompleted = [false, false, false, false, false, false, false, false];

  AdventureProgress({
    required this.memoryProvinceCompleted,
    required this.sudokuProvinceCompleted,
    required this.copingProvinceCompleted,
    required this.apayaoCardsCompleted,
    required this.kalingaCardsCompleted,
    required this.abraCardsCompleted,
    required this.mountainProvinceCardsCompleted,
    required this.ifugaoCardsCompleted,
    required this.benguetCardsCompleted,
  });
}