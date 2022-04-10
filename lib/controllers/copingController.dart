import 'package:flutter_application_1/apis/CopingGame.dart';
import 'package:flutter_application_1/apis/dailyHive.dart';
import 'package:flutter_application_1/apis/emotionEntryHive.dart';
import 'package:flutter_application_1/controllers/emotionController.dart';
import 'package:flutter_application_1/enums/DailyTask.dart';
import 'package:flutter_application_1/enums/Province.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class CopingController extends GetxController {
  // order based on unlock order of provinces
  // key: Province - value: index number for variable provinceCompleted
  Map<Province, int> provinceIndex = {
    Province.Apayao: 0,
    Province.Kalinga: 1,
    Province.Abra: 2,
    Province.MountainProvince: 3,
    Province.Ifugao: 4,
    Province.Benguet: 5
  };
  var provinceCompleted = [false, false, false, false, false, false].obs;

  // from top to bottom, left to right
  var apayaoCardsCompleted = [false, false, false, false, false, false, false, false].obs;
  var kalingaCardsCompleted = [false, false, false, false, false, false, false, false].obs;
  var abraCardsCompleted = [false, false, false, false, false, false, false, false].obs;
  var mountainProvinceCardsCompleted = [false, false, false, false, false, false, false, false].obs;
  var ifugaoCardsCompleted = [false, false, false, false, false, false, false, false].obs;
  var benguetCardsCompleted = [false, false, false, false, false, false, false, false].obs;

  var selectedProvince = Province.Abra.obs;


  void prepareTheObjects() {
    Box box = Hive.box<CopingGame>('copingGame');
    if (box.isEmpty) {
      CopingGame copingGameStatus = CopingGame(
        provinceCompleted: [false, false, false, false, false, false],
        apayaoCardsCompleted: [false, false, false, false, false, false, false, false],
        kalingaCardsCompleted: [false, false, false, false, false, false, false, false],
        abraCardsCompleted: [false, false, false, false, false, false, false, false],
        mountainProvinceCardsCompleted: [false, false, false, false, false, false, false, false],
        ifugaoCardsCompleted: [false, false, false, false, false, false, false, false],
        benguetCardsCompleted: [false, false, false, false, false, false, false, false]
      );
      box.put('copingGameStatus', copingGameStatus);
    }

    CopingGame copingGame = box.get('copingGameStatus');
    provinceCompleted.value = copingGame.provinceCompleted;
    apayaoCardsCompleted.value = copingGame.apayaoCardsCompleted;
    kalingaCardsCompleted.value = copingGame.kalingaCardsCompleted;
    abraCardsCompleted.value = copingGame.abraCardsCompleted;
    mountainProvinceCardsCompleted.value = copingGame.mountainProvinceCardsCompleted;
    ifugaoCardsCompleted.value = copingGame.ifugaoCardsCompleted;
    benguetCardsCompleted.value = copingGame.benguetCardsCompleted;

    update();
  }


  List<bool> getCardCompletions(Province province) {
    return province == Province.Abra ? abraCardsCompleted.value 
        : province == Province.Apayao ? apayaoCardsCompleted.value
        : province == Province.Benguet ? benguetCardsCompleted.value
        : province == Province.Ifugao ? ifugaoCardsCompleted.value
        : province == Province.Kalinga ? kalingaCardsCompleted.value
        : mountainProvinceCardsCompleted.value;
  }

  void updateCardCompletion(Province province, int gridNum) {
    Box box = Hive.box<CopingGame>('copingGame');
    CopingGame copingGame = box.get('copingGameStatus');

    if (province == Province.Abra) {
      abraCardsCompleted.value[gridNum] = true;
      copingGame.abraCardsCompleted[gridNum] = true;

      abraCardsCompleted.refresh();
      if (!abraCardsCompleted.value.contains(false)) {
        provinceCompleted.value[provinceIndex[province] as int] = true;
        copingGame.provinceCompleted[provinceIndex[province] as int] = true;
      }
    }

    else if (province == Province.Apayao) {
      apayaoCardsCompleted.value[gridNum] = true;
      copingGame.apayaoCardsCompleted[gridNum] = true;

      apayaoCardsCompleted.refresh();
      if (!apayaoCardsCompleted.value.contains(false)) {
        provinceCompleted.value[provinceIndex[province] as int] = true;
        copingGame.provinceCompleted[provinceIndex[province] as int] = true;
      }
    }

    else if (province == Province.Benguet) {
      benguetCardsCompleted.value[gridNum] = true;
      copingGame.benguetCardsCompleted[gridNum] = true;

      benguetCardsCompleted.refresh();
      if (!benguetCardsCompleted.value.contains(false)) {
        provinceCompleted.value[provinceIndex[province] as int] = true;
        copingGame.provinceCompleted[provinceIndex[province] as int] = true;
      }
    }

    else if (province == Province.Ifugao) {
      ifugaoCardsCompleted.value[gridNum] = true;
      copingGame.ifugaoCardsCompleted[gridNum] = true;

      ifugaoCardsCompleted.refresh();
      if (!ifugaoCardsCompleted.value.contains(false)) {
        provinceCompleted.value[provinceIndex[province] as int] = true;
        copingGame.provinceCompleted[provinceIndex[province] as int] = true;
      }
    }

    else if (province == Province.Kalinga) {
      kalingaCardsCompleted.value[gridNum] = true;
      copingGame.kalingaCardsCompleted[gridNum] = true;

      kalingaCardsCompleted.refresh();
      if (!kalingaCardsCompleted.value.contains(false)) {
        provinceCompleted.value[provinceIndex[province] as int] = true;
        copingGame.provinceCompleted[provinceIndex[province] as int] = true;
      }
    }

    else if (province == Province.MountainProvince) {
      mountainProvinceCardsCompleted.value[gridNum] = true;
      copingGame.mountainProvinceCardsCompleted[gridNum] = true;

      mountainProvinceCardsCompleted.refresh();
      if (!mountainProvinceCardsCompleted.value.contains(false)) {
        provinceCompleted.value[provinceIndex[province] as int] = true;
        copingGame.provinceCompleted[provinceIndex[province] as int] = true;
      }
    }

    update();
    copingGame.save();
  }

  void updateSelectedProvince(Province province) {
    selectedProvince.value = province;
    update();
  }
  
}
