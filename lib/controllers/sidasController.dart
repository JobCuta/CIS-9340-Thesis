import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/apis/sidasHive.dart';
import 'package:flutter_application_1/apis/tableSecureStorage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SIDASController extends GetxController {
  // final List<int> answerValues = [0, 0, 0, 0, 0].obs;
  final List<int> answerValues = [5, 5, 5, 5, 5].obs;

  int sum = 0;

  void updateValues(int position, int i) {
    answerValues[position] = i;
    calculateSum();
    update();
  }

  void calculateSum() {
    sum = 0;
    for (var num in answerValues) {
      sum += num;
    }
    update();
  }

  saveEntries() async {
    DateTime now = DateTime.now();
    var box = Hive.box('sidas');
    sidasHive entry = sidasHive(
      answerValues: answerValues,
      date: now,
      index: -1,
      score: sum,
    );

    String monthKey = now.month.toString() + '-' + now.year.toString();
    box.put(monthKey, entry);

    String title = '', sub = '';
    Map result = await UserProvider().createSIDAS(entry);

    // Check results of saving entry online
    if (result["status"]) {
      entry.index = result["body"]["id"];

      title = 'SIDAS Entry saved!';
      sub = 'Entry was saved to your profile';
      log('it worked');
    } else {
      title = 'SIDAS Entry not saved';
      sub = 'There was a problem saving your entry online';
    }

    TableSecureStorage.setLatestSIDAS(DateTime.now().toUtc().toString());

    Get.snackbar(title, sub,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white60,
        colorText: Colors.black87);
  }
}
