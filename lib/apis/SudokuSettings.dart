import 'package:hive/hive.dart';
import 'package:get/get.dart';
part 'SudokuSettings.g.dart';

@HiveType(typeId: 11)
class SudokuSettings extends HiveObject {
  @HiveField(0)
  String currentDifficultyLevel;

  @HiveField(1)
  String currentTheme;

  @HiveField(2)
  String currentAccentColor;

  SudokuSettings({
    required this.currentDifficultyLevel,
    required this.currentTheme,
    required this.currentAccentColor,
  });
}
