
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

  var selectedProvince = Province.Apayao.obs;

  void prepareTheObjects() {
    Box box = Hive.box<MemoryGame>('memoryGame');
    if (box.isEmpty) {
      MemoryGame memoryGameStatus = MemoryGame(
        provinceCompleted: [false, false, false, false, false, false],
      );
      box.put('memoryGameStatus', memoryGameStatus);
    }

    MemoryGame memoryGame = box.get('memoryGameStatus');
    provinceCompleted.value = memoryGame.provinceCompleted;

    update();
  }

  bool getCompleteStatusOfProvinceCards(int province) {
    return provinceCompleted.value[provinceIndex[province] as int];
  }

  void updateProvinceCompletion(Province province) {
    Box box = Hive.box<MemoryGame>('memoryGame');
    MemoryGame memoryGame = box.get('memoryGameStatus');

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

  void updateIfCompleted(Province province, MemoryGame memoryGame) {
    memoryGame.provinceCompleted[provinceIndex[province] as int] = true;
  }

  void updateSelectedProvince(Province province) {
    selectedProvince.value = province;
    update();
  }
}