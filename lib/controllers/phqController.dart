import 'package:get/get.dart';

class PHQController extends GetxController {
  final List<int> answerValues = [0, 0, 0, 0, 0, 0, 0, 0, 0].obs;
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
}
