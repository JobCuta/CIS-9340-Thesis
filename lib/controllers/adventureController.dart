import 'package:flutter_application_1/apis/AdventureProgress.dart';
import 'package:flutter_application_1/controllers/copingController.dart';
import 'package:flutter_application_1/controllers/memoryController.dart';
import 'package:flutter_application_1/enums/Province.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AdventureController extends GetxController {
  var selectedProvince = Province.Apayao.obs;

  void prepareTheObjects() {
    Box box = Hive.box<AdventureProgress>('adventure');
    CopingController _copingController = Get.put(CopingController());
    MemoryController _memoryController = Get.put(MemoryController());
    if (box.isEmpty) {
      AdventureProgress adventureProgress = AdventureProgress(
        memoryProvinceCompleted: [false, false, false, false, false, false],
        sudokuProvinceCompleted: [false, false, false, false, false, false],
        copingProvinceCompleted: [false, false, false, false, false, false],
        apayaoCardsCompleted: [false, false, false, false, false, false, false, false],
        kalingaCardsCompleted: [false, false, false, false, false, false, false, false],
        abraCardsCompleted: [false, false, false, false, false, false, false, false],
        mountainProvinceCardsCompleted: [false, false, false, false, false, false, false, false],
        ifugaoCardsCompleted: [false, false, false, false, false, false, false, false],
        benguetCardsCompleted: [false, false, false, false, false, false, false, false]
      );
      box.put('adventureProgress', adventureProgress);
    }

    _copingController.prepareTheObjects();
    _memoryController.prepareTheObjects();
  }

  void updateSelectedProvince(Province province) {
    selectedProvince.value = province;
    update();
  }
}