import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/apis/phqHive.dart';
import 'package:flutter_application_1/apis/tableSecureStorage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class PHQController extends GetxController {
  Box box = Hive.box('phq');
  final List<int> answerValues = [0, 0, 0, 0, 0, 0, 0, 0, 0].obs;
  int sum = -1;

  final dateFormat = DateFormat('MM-yyyy');

  void updateValues(int position, int i) {
    answerValues[position] = i;
    calculateSum();
    print(answerValues);
    update();
  }

  void calculateSum() {
    sum = 0;
    for (var num in answerValues) {
      sum += num;
    }
    print(sum);
    update();
  }

  saveEntries() async {
    DateTime now = DateTime.now();
    var box = Hive.box('phq');

    var entry = phqHive(index: -1, date: now, score: sum);

    String key = now.month.toString() + '-' + now.day.toString();
    box.put(key, entry);

    String title = '', sub = '';
    Map result = await UserProvider().createPHQ(entry);

    // Check results of saving entry online
    if (result["status"]) {
      entry.index = result["body"]["id"];

      title = 'PHQ9 Entry saved!';
      sub = 'Entry was saved to your profile';
      log('it worked');
    } else {
      title = 'PHQ9 Entry not saved';
      sub = 'There was a problem saving your entry online';
    }

    TableSecureStorage.setLatestPHQ(now.toUtc().toString());

    Get.snackbar(title, sub,
<<<<<<< HEAD
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white60,
        colorText: Colors.black87);
=======
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white60, colorText: Colors.black87);
>>>>>>> 428d8d8b40e5b319931e5eec04767c9afc373812
  }
}
