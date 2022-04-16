import 'package:flutter_application_1/apis/phqHive.dart';
import 'package:flutter_application_1/apis/phqHiveObject.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class PHQController extends GetxController {
  Box box = Hive.box<phqHive>('phq');
  final List<int> answerValues = [0, 0, 0, 0, 0, 0, 0, 0, 0].obs;
  int sum = 0;

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

  addToHive() async {
    List<phqHiveObj> assessments = List<phqHiveObj>.empty(growable: true);
    if (box.isEmpty) {
      phqHiveObj newAssessment = phqHiveObj(date: DateTime.now(), score: sum);
      assessments.add(newAssessment);
      box.put(dateFormat.format(DateTime.now()).toString(),
          phqHive(assessments: assessments));
      print('NO ENTRIES');
      print(box.length);
    } else {
      // gets the last key (MM-YYYY) in the box
      var lastEntryIndex = box.toMap().length - 1;
      var lastEntry = box.getAt(lastEntryIndex);
      DateTime lastEntryDate = lastEntry.assessments.last.getDate();

      // new assessment date
      DateTime newEntryDate = lastEntryDate.add(const Duration(days: 14));
      // checks if the entry will be added to the assessments of the last key or to make a new key with the assessment as its first entry
      var key = dateFormat.format(newEntryDate);

      if (box.containsKey(key.toString())) {
        var monthYear = box.get(key.toString());
        print('HAS KEY');
        monthYear.assessments.add(phqHiveObj(date: newEntryDate, score: sum));
        box.put(key.toString(), phqHive(assessments: monthYear.assessments));
      } else {
        print('NO KEY');
        assessments.add(phqHiveObj(date: newEntryDate, score: sum));
        box.put(key.toString(), phqHive(assessments: assessments));
      }
    }
  }
}
