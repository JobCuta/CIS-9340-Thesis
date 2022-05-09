import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/AdventureProgress.dart';
import 'package:flutter_application_1/apis/SudokuSettings.dart';
import 'package:flutter_application_1/controllers/adventureController.dart';
import 'package:flutter_application_1/enums/Province.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SudokuController extends GetxController {
  Box box = Hive.box<SudokuSettings>('sudokuBox');
  var currentDifficultyLevel = ''.obs;
  var currentTheme = ''.obs;
  var currentAccentColor = ''.obs;

  void prepareTheObjects() {
    if (box.isEmpty) {
      SudokuSettings sudokuBox = SudokuSettings(
          currentDifficultyLevel: 'easy',
          currentTheme: 'Green',
          currentAccentColor: 'darkGrey');
      box.put('sudokuBox', sudokuBox);
    }
    SudokuSettings sudoku = box.get('sudokuBox');
    currentDifficultyLevel.value = sudoku.currentDifficultyLevel;
    currentTheme.value = sudoku.currentTheme;
    currentAccentColor.value = sudoku.currentAccentColor;
    update();
  }

  void getSettings({newDifficultyLevel, newAccentColor, newTheme}) {
    SudokuSettings sudoku = box.get('sudokuBox');
    currentDifficultyLevel.value = sudoku.currentDifficultyLevel;
    currentAccentColor.value = sudoku.currentAccentColor;
    currentTheme.value = sudoku.currentTheme;
    update();
  }

  void updateDifficulty(newDifficultyLevel) {
    SudokuSettings newSettings = SudokuSettings(
        currentDifficultyLevel: newDifficultyLevel,
        currentAccentColor: currentAccentColor.value,
        currentTheme: currentTheme.value);
    box.putAt(0, newSettings);
    currentDifficultyLevel.value = newSettings.currentDifficultyLevel;
    update();
  }

  void updateAccent(newAccent) {
    SudokuSettings newSettings = SudokuSettings(
        currentDifficultyLevel: currentDifficultyLevel.value,
        currentAccentColor: newAccent,
        currentTheme: currentTheme.value);
    box.putAt(0, newSettings);
    currentAccentColor.value = newSettings.currentAccentColor;
    update();
  }

  void updateTheme(newTheme) {
    SudokuSettings newSettings = SudokuSettings(
        currentDifficultyLevel: currentDifficultyLevel.value,
        currentAccentColor: currentAccentColor.value,
        currentTheme: newTheme);
    box.putAt(0, newSettings);
    currentTheme.value = newSettings.currentTheme;
    update();
  }

  void updateIfCompleted() {
    Map<Province, int> provinceIndex = {
      Province.Apayao: 0,
      Province.Kalinga: 1,
      Province.Abra: 2,
      Province.MountainProvince: 3,
      Province.Ifugao: 4,
      Province.Benguet: 5
    };
    AdventureController adventureController = Get.put(AdventureController());
    Province selectedProvince = adventureController.selectedProvince.value;
    Box box = Hive.box<AdventureProgress>('adventure');
    AdventureProgress sudokuGame = box.get('adventureProgress');

    sudokuGame.sudokuProvinceCompleted[provinceIndex[selectedProvince] as int] = true;
    sudokuGame.save();

    print("SUDOKU GAME PROGRESS = " + sudokuGame.sudokuProvinceCompleted.toString());
  }

  void incrementMiniGamesWarrior() {
    Box box = Hive.box<AdventureProgress>('adventure');
    AdventureProgress sudokuGame = box.get('adventureProgress');

    int i = sudokuGame.miniGamesWarrior;
    if (i < 10) {
      i += 1;
    }
    sudokuGame.miniGamesWarrior = i;
    sudokuGame.save();
  }
}
