import 'package:flutter_application_1/apis/AdventureProgress.dart';
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


  void prepareTheObjects() {
    Box box = Hive.box<AdventureProgress>('adventure');

    AdventureProgress copingGame = box.get('adventureProgress');
    provinceCompleted.value = copingGame.copingProvinceCompleted;
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
    Box box = Hive.box<AdventureProgress>('adventure');
    AdventureProgress copingGame = box.get('adventureProgress');

    if (province == Province.Abra) {
      abraCardsCompleted.value[gridNum] = true;
      copingGame.abraCardsCompleted[gridNum] = true;

      abraCardsCompleted.refresh();
      checkIfAllProvinceCardsAreComplete(abraCardsCompleted, Province.Abra, copingGame);
    }

    else if (province == Province.Apayao) {
      apayaoCardsCompleted.value[gridNum] = true;
      copingGame.apayaoCardsCompleted[gridNum] = true;

      apayaoCardsCompleted.refresh();
      checkIfAllProvinceCardsAreComplete(apayaoCardsCompleted, Province.Apayao, copingGame);
    }

    else if (province == Province.Benguet) {
      benguetCardsCompleted.value[gridNum] = true;
      copingGame.benguetCardsCompleted[gridNum] = true;

      benguetCardsCompleted.refresh();
      checkIfAllProvinceCardsAreComplete(benguetCardsCompleted, Province.Benguet, copingGame);
    }

    else if (province == Province.Ifugao) {
      ifugaoCardsCompleted.value[gridNum] = true;
      copingGame.ifugaoCardsCompleted[gridNum] = true;

      ifugaoCardsCompleted.refresh();
      checkIfAllProvinceCardsAreComplete(ifugaoCardsCompleted, Province.Ifugao, copingGame);
    }

    else if (province == Province.Kalinga) {
      kalingaCardsCompleted.value[gridNum] = true;
      copingGame.kalingaCardsCompleted[gridNum] = true;

      kalingaCardsCompleted.refresh();
      checkIfAllProvinceCardsAreComplete(kalingaCardsCompleted, Province.Kalinga, copingGame);
    }

    else if (province == Province.MountainProvince) {
      mountainProvinceCardsCompleted.value[gridNum] = true;
      copingGame.mountainProvinceCardsCompleted[gridNum] = true;

      mountainProvinceCardsCompleted.refresh();
      checkIfAllProvinceCardsAreComplete(mountainProvinceCardsCompleted, Province.MountainProvince, copingGame);
    }

    update();
    copingGame.save();

    print('-------- COPING GAME UPDATE');
    print('All Provinces: ${provinceCompleted.value.toString()}');
    print('Abra: ${abraCardsCompleted.value.toString()}');
    print('Apayao: ${apayaoCardsCompleted.value.toString()}');
    print('Benguet: ${benguetCardsCompleted.value.toString()}');
    print('Kalinga: ${kalingaCardsCompleted.value.toString()}');
    print('Ifugao: ${ifugaoCardsCompleted.value.toString()}');
    print('Mt. Province: ${mountainProvinceCardsCompleted.value.toString()}');
  }

  void checkIfAllProvinceCardsAreComplete(List<bool> provinceCardsCompleted, Province province, AdventureProgress copingGame) {
    if (!provinceCardsCompleted.contains(false)) {
      provinceCompleted.value[provinceIndex[province] as int] = true;
      copingGame.copingProvinceCompleted[provinceIndex[province] as int] = true;
    }
  }

  bool getCompleteStatusOfProvinceCards(Province province) {
    return provinceCompleted.value[provinceIndex[province] as int];
  }

  bool checkIfItWillBeCompletedSoon(Province province) {
    List<bool> cardsCompleted = (province == Province.Abra) ? abraCardsCompleted.value 
          : (province == Province.Apayao) ? apayaoCardsCompleted.value
          : (province == Province.Benguet) ? benguetCardsCompleted.value
          : (province == Province.Ifugao) ? ifugaoCardsCompleted.value
          : (province == Province.Kalinga) ? kalingaCardsCompleted.value
          : benguetCardsCompleted.value;
    
    int done = 0;
    int notDone = 0;
    for (bool isCompleted in cardsCompleted) {
      if (isCompleted) {
        done++;
      } else {
        notDone++;
      }
    }

    return (notDone == 1);
  }
  
}
