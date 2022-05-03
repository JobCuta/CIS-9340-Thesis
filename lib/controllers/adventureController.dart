import 'package:flutter_application_1/apis/AdventureProgress.dart';
import 'package:flutter_application_1/controllers/copingController.dart';
import 'package:flutter_application_1/controllers/memoryController.dart';
import 'package:flutter_application_1/enums/Province.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AdventureController extends GetxController {
  var selectedProvince = Province.Apayao.obs;
  var willAddXpOnce = false.obs;

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

  void checkIfItWillAddXpForCompletingAllActivities() {
    Province province = selectedProvince.value;
    Map<Province, int> provinceIndex = {
      Province.Apayao: 0,
      Province.Kalinga: 1,
      Province.Abra: 2,
      Province.MountainProvince: 3,
      Province.Ifugao: 4,
      Province.Benguet: 5
    };
    
    Box box = Hive.box<AdventureProgress>('adventure');
    AdventureProgress adventureProgress = box.get('adventureProgress');

    List <bool> copingProvinceCompleted = adventureProgress.copingProvinceCompleted;
    List <bool> memoryProvinceCompleted = adventureProgress.memoryProvinceCompleted;
    List <bool> sudokuProvinceCompleted = adventureProgress.sudokuProvinceCompleted;

    bool isMemoryDone = memoryProvinceCompleted[provinceIndex[province] as int];
    bool isCopingDone = copingProvinceCompleted[provinceIndex[province] as int];
    bool isSudokuDone = sudokuProvinceCompleted[provinceIndex[province] as int];

    int completeCount = 0;
    if (isMemoryDone) completeCount++;
    if (isCopingDone) completeCount++;
    if (isSudokuDone) completeCount++;

    if (completeCount == 2) {
      willAddXpOnce.value = true;
      update();
    }
  }

  void setAddingOfXpForCompletingAllActivitiesToFalse() {
    willAddXpOnce.value = false;
    update();
  }
}