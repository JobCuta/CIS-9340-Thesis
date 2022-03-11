import 'package:get/get.dart';

class SIDASController extends GetxController {
  // final List<int> answerValues = [0, 0, 0, 0, 0].obs;
  final List<int> answerValues = [5, 5, 5, 5, 5].obs;

  int sum = 0;

  void updateValues(int position, int i) {
    answerValues[position] = i;
    print(answerValues);
    calculateSum();
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
