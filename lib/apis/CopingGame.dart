import 'package:hive/hive.dart';
import 'package:get/get.dart';

part 'CopingGame.g.dart';

@HiveType(typeId: 12)
class CopingGame extends HiveObject{
  @HiveField(0)
  List<bool> provinceCompleted;

  @HiveField(1)
  List<bool> apayaoCardsCompleted = [false, false, false, false, false, false, false, false];

  @HiveField(2)
  List<bool> kalingaCardsCompleted = [false, false, false, false, false, false, false, false];

  @HiveField(3)
  List<bool> abraCardsCompleted = [false, false, false, false, false, false, false, false];

  @HiveField(4)
  List<bool> mountainProvinceCardsCompleted = [false, false, false, false, false, false, false, false];

  @HiveField(5)
  List<bool> ifugaoCardsCompleted = [false, false, false, false, false, false, false, false];

  @HiveField(6)
  List<bool> benguetCardsCompleted = [false, false, false, false, false, false, false, false];

  CopingGame({
    required this.provinceCompleted,
    required this.apayaoCardsCompleted,
    required this.kalingaCardsCompleted,
    required this.abraCardsCompleted,
    required this.mountainProvinceCardsCompleted,
    required this.ifugaoCardsCompleted,
    required this.benguetCardsCompleted
  });
}