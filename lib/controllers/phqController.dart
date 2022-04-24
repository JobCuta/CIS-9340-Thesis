import 'package:flutter_application_1/apis/phqHive.dart';
import 'package:flutter_application_1/apis/phqHiveObject.dart';
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
}
