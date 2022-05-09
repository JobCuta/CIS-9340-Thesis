
import 'package:flutter_application_1/apis/AdventureProgress.dart';
import 'package:flutter_application_1/apis/MemoryGame.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../enums/Province.dart';

class MemoryController extends GetxController{
  Map<Province, int> provinceIndex = {
    Province.Apayao: 0,
    Province.Kalinga: 1,
    Province.Abra: 2,
    Province.MountainProvince: 3,
    Province.Ifugao: 4,
    Province.Benguet: 5
  };
  var provinceCompleted = [false, false, false, false, false, false].obs;

  void prepareTheObjects() {
    Box box = Hive.box<AdventureProgress>('adventure');
    // if (box.isEmpty) {
    //   MemoryGame memoryGameStatus = MemoryGame(
    //     provinceCompleted: [false, false, false, false, false, false],
    //   );
    //   box.put('memoryGameStatus', memoryGameStatus);
    // }

    AdventureProgress memoryGame = box.get('adventureProgress');
    provinceCompleted.value = memoryGame.memoryProvinceCompleted;

    update();
  }

  bool getCompleteStatusOfProvinceCards(int province) {
    return provinceCompleted.value[provinceIndex[province] as int];
  }

  void updateProvinceCompletion(Province province) {
    Box box = Hive.box<AdventureProgress>('adventure');
    AdventureProgress memoryGame = box.get('adventureProgress');

    if (province == Province.Abra) {
      updateIfCompleted(Province.Abra, memoryGame);
    } else if (province == Province.Apayao) {
      updateIfCompleted(Province.Apayao, memoryGame);
    } else if (province == Province.Benguet) {
      updateIfCompleted(Province.Benguet, memoryGame);
    } else if (province == Province.Ifugao) {
      updateIfCompleted(Province.Ifugao, memoryGame);
    } else if (province == Province.Kalinga) {
      updateIfCompleted(Province.Kalinga, memoryGame);
    } else {
      updateIfCompleted(Province.MountainProvince, memoryGame);
    }
  }

  void updateIfCompleted(Province province, AdventureProgress memoryGame) {
    memoryGame.memoryProvinceCompleted[provinceIndex[province] as int] = true;
    memoryGame.save();

    print("MEMORY GAME PROGRESS = " + memoryGame.memoryProvinceCompleted.toString());
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