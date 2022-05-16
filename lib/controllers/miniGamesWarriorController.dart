
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter_application_1/apis/MiniGamesWarrior.dart';

class MiniGamesWarriorController extends GetxController{
  var miniGamesWarrior = 0;

  void prepareTheObjects() {
    Box box = Hive.box<MiniGamesWarrior>('miniGamesWarrior');
    if (box.isEmpty) {
      MiniGamesWarrior mgwStatus = MiniGamesWarrior(
        mgw: 0
      );
      box.put('mgwStatus', mgwStatus);
    }
    MiniGamesWarrior mgw = box.get('mgwStatus');
    miniGamesWarrior = mgw.mgw;
    update();
  }

  void updateMGWCompletion() {
    Box box = Hive.box<MiniGamesWarrior>('miniGamesWarrior');
    MiniGamesWarrior mgwStatus = box.get('mgwStatus');

    if (mgwStatus.mgw < 10) {
      mgwStatus.mgw = mgwStatus.mgw++;
      miniGamesWarrior++;
      mgwStatus.save();
    }
  }

  void updateIfCompleted(int newValue, MiniGamesWarrior miniGamesWarrior) {
    miniGamesWarrior.mgw = newValue;
    miniGamesWarrior.save();
    update();
  }
}