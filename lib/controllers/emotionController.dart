// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/emotionEntryHive.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/Mood.dart';
import 'package:flutter_application_1/screens/main/EmotionalEvaluationEndScreen.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../apis/EmotionEntryDetail.dart';

class EmotionController extends GetxController {
  final _selectedPositiveEmotions = [].obs;
  final _selectedNegativeEmotions = [].obs;
  var mainEmotion = ''.obs;
  var note = ''.obs;

  var isPositiveNotEmpty = false.obs;
  var isNegativeNotEmpty = false.obs;
  var isValid = false.obs;

  var isFirstTimeAdding = false.obs;
  var isEditMode = false.obs;
  var isMorningCheck = false.obs;
  var isAfternoonCheck = false.obs;
  var isEveningCheck = false.obs;

    @override
    void onInit() {
      checkIfFirstTimeAddingForTheDay();
      super.onInit();
    }

  void addPositiveEmotion(emotion) {
    _selectedPositiveEmotions.add(emotion);
    isPositiveNotEmpty.value = _selectedPositiveEmotions.isNotEmpty;
    isValid.value = isPositiveNotEmpty.value || isNegativeNotEmpty.value;
    update();
  }

  void updatePositiveEmotion(emotion) {
    _selectedPositiveEmotions.value = emotion;
    isPositiveNotEmpty.value = _selectedPositiveEmotions.isNotEmpty;
    isValid.value = isPositiveNotEmpty.value || isNegativeNotEmpty.value;
    update();
  }

  void removePositive(emotion) {
    _selectedPositiveEmotions.remove(emotion);
    isPositiveNotEmpty.value = _selectedPositiveEmotions.isNotEmpty;
    isValid.value = isPositiveNotEmpty.value || isNegativeNotEmpty.value;
    update();
  }

  void addNegativeEmotion(emotion) {
    _selectedNegativeEmotions.add(emotion);
    isNegativeNotEmpty.value = _selectedNegativeEmotions.isNotEmpty;
    isValid.value = isPositiveNotEmpty.value || isNegativeNotEmpty.value;
    update();
  }

  void updateNegativeEmotion(emotion) {
    _selectedNegativeEmotions.value = emotion;
    isNegativeNotEmpty.value = _selectedNegativeEmotions.isNotEmpty;
    isValid.value = isPositiveNotEmpty.value || isNegativeNotEmpty.value;
    update();
  }

  void removeNegative(emotion) {
    _selectedNegativeEmotions.remove(emotion);
    isNegativeNotEmpty.value = _selectedNegativeEmotions.isNotEmpty;
    isValid.value = isPositiveNotEmpty.value || isNegativeNotEmpty.value;
    update();
  }

  void updateMainEmotion(String s) {
    mainEmotion.value = s;
    update();
  }

  void updateNotes(String s) {
    note.value = s;
    update();
  }

  void updatePartOfTheDayCheck(String part) {
    if (part == 'morning') {
      isMorningCheck.value = true;
    }
    else if (part == 'afternoon') {
      isAfternoonCheck.value = true;
    }
    else if (part == 'evening') {
      isEveningCheck.value = true;
    }

    print ("Part of the Day checks = " + isMorningCheck.value.toString() + ", " + isAfternoonCheck.value.toString() + ", " + isEveningCheck.value.toString());
    update();
  }

  void resetAllPartOfTheDayChecks() {
    isMorningCheck.value = false;
    isAfternoonCheck.value = false;
    isEveningCheck.value = false;
    isFirstTimeAdding.value = false;
    isEditMode.value = true;

    update();
  }

  void saveEntryToStorage() {
    // maybe store this somewhere else
    Map<int, String> weekdayString = {
      1 : 'Monday',
      2 : 'Tuesday',
      3 : 'Wednesday',
      4 : 'Thursday',
      5 : 'Friday',
      6 : 'Saturday',
      7 : 'Sunday'
    }; 

    if (isValid.value) {
      DateTime dateTime = DateTime.now();
      String date = dateToString(dateTime);
      String time = timeToString(dateTime);
      Mood? mood = moodMap[mainEmotion.value] as Mood;
      List<dynamic> positiveEmotions = _selectedPositiveEmotions.value;
      List<dynamic> negativeEmotions = _selectedNegativeEmotions.value;

      if (!isMorningCheck.value && !isAfternoonCheck.value && !isEveningCheck.value) {
        if (dateTime.hour < 12 && dateTime.hour > 23) {
          isMorningCheck.value = true;
        }
        else if (dateTime.hour > 11 && dateTime.hour < 18) {
          isAfternoonCheck.value = true;
        }
        else if (dateTime.hour > 17 && dateTime.hour < 24) {
          isEveningCheck.value = true;
        }              
        update(); 
      }

      Box box = Hive.box<EmotionEntryHive>('emotion');
      EmotionEntryHive newEmotionEntry = EmotionEntryHive(
        overallMood: mood.name, 
        weekday: weekdayString[DateTime.now().weekday] as String, 
        date: date,
        morningCheck: (isMorningCheck.value) 
          ? EmotionEntryDetail(time: time, note: note.value, mood: mood.name, positiveEmotions: positiveEmotions, negativeEmotions: negativeEmotions, isEmpty: false)
          : EmotionEntryDetail(isEmpty: true, mood: moodMap['noData']!.name, positiveEmotions: [], negativeEmotions: []),
        afternoonCheck: (isAfternoonCheck.value) 
          ? EmotionEntryDetail(time: time, note: note.value, mood: mood.name, positiveEmotions: positiveEmotions, negativeEmotions: negativeEmotions, isEmpty: false)
          : EmotionEntryDetail(isEmpty: true, mood: moodMap['noData']!.name, positiveEmotions: [], negativeEmotions: []),
        eveningCheck: (isEveningCheck.value)
          ? EmotionEntryDetail(time: time, note: note.value, mood: mood.name, positiveEmotions: positiveEmotions, negativeEmotions: negativeEmotions, isEmpty: false)
          : EmotionEntryDetail(isEmpty: true, mood: moodMap['noData']!.name, positiveEmotions: [], negativeEmotions: []),
      );

      resetAllPartOfTheDayChecks();
      print("--------------- ADDING ---------------");
      print("Emotion box length = " + box.length.toString());
      print("[EEH] Overall Mood Name = " + newEmotionEntry.overallMood);
      print("[EEH] Weekday = " + newEmotionEntry.weekday);
      print("[EEH] Date = " + newEmotionEntry.date);
      print("[EED] Morning Check = " + newEmotionEntry.morningCheck.toString());
      print("[EED] Afternoon Check = " + newEmotionEntry.afternoonCheck.toString());
      print("[EED] Evening Check = " + newEmotionEntry.eveningCheck.toString());

      box.put(date, newEmotionEntry);
    }
  }

  void updateEntryInStorage() {
    Box box = Hive.box<EmotionEntryHive>('emotion');
    DateTime dateTime = DateTime.now();
    String time = timeToString(dateTime);
    EmotionEntryHive emotionEntry = box.get(dateToString(dateTime));
    Mood? mood = moodMap[mainEmotion.value] as Mood;
    List<dynamic> positiveEmotions = _selectedPositiveEmotions.value;
    List<dynamic> negativeEmotions = _selectedNegativeEmotions.value;

    if (!isMorningCheck.value && !isAfternoonCheck.value && !isEveningCheck.value) {
      if (dateTime.hour < 12 && dateTime.hour > 23) {
        isMorningCheck.value = true;
      }
      else if (dateTime.hour > 11 && dateTime.hour < 18) {
        isAfternoonCheck.value = true;
      }
      else if (dateTime.hour > 17 && dateTime.hour < 24) {
        isEveningCheck.value = true;
      }              
      update(); 
    }

    if (isMorningCheck.value) {
      emotionEntry.morningCheck.time = time;
      emotionEntry.morningCheck.note = note.value;
      emotionEntry.morningCheck.mood = mood.name;
      emotionEntry.morningCheck.positiveEmotions = positiveEmotions;
      emotionEntry.morningCheck.negativeEmotions = negativeEmotions;
      emotionEntry.morningCheck.isEmpty = false;
    }

    else if (isAfternoonCheck.value) {
      emotionEntry.afternoonCheck.time = time;
      emotionEntry.afternoonCheck.note = note.value;
      emotionEntry.afternoonCheck.mood = mood.name;
      emotionEntry.afternoonCheck.positiveEmotions = positiveEmotions;
      emotionEntry.afternoonCheck.negativeEmotions = negativeEmotions;
      emotionEntry.afternoonCheck.isEmpty = false;
    }

    else if (isEveningCheck.value) {
      emotionEntry.eveningCheck.time = time;
      emotionEntry.eveningCheck.note = note.value;
      emotionEntry.eveningCheck.mood = mood.name;
      emotionEntry.eveningCheck.positiveEmotions = positiveEmotions;
      emotionEntry.eveningCheck.negativeEmotions = negativeEmotions;
      emotionEntry.eveningCheck.isEmpty = false;
    }


    int moodCount = 0;
    if (emotionEntry.morningCheck.mood != 'NoData') moodCount++;
    if (emotionEntry.afternoonCheck.mood != 'NoData') moodCount++;
    if (emotionEntry.eveningCheck.mood != 'NoData') moodCount++;

    int moodValue = 0;
    if (emotionEntry.morningCheck.mood == 'VeryBad') {
      moodValue++;
    }
    else if (emotionEntry.morningCheck.mood == 'Bad') {
      moodValue += 2;
    }
    else if (emotionEntry.morningCheck.mood == 'Neutral') {
      moodValue += 3;
    }
    else if (emotionEntry.morningCheck.mood == 'Happy') {
      moodValue += 4;
    }
    else if (emotionEntry.morningCheck.mood == 'VeryHappy') {
      moodValue += 5;
    }

    if (emotionEntry.afternoonCheck.mood == 'VeryBad') {
      moodValue++;
    }
    else if (emotionEntry.afternoonCheck.mood == 'Bad') {
      moodValue += 2;
    }
    else if (emotionEntry.afternoonCheck.mood == 'Neutral') {
      moodValue += 3;
    }
    else if (emotionEntry.afternoonCheck.mood == 'Happy') {
      moodValue += 4;
    }
    else if (emotionEntry.afternoonCheck.mood == 'VeryHappy') {
      moodValue += 5;
    }


    if (emotionEntry.eveningCheck.mood == 'VeryBad') {
      moodValue++;
    }
    else if (emotionEntry.eveningCheck.mood == 'Bad') {
      moodValue += 2;
    }
    else if (emotionEntry.eveningCheck.mood == 'Neutral') {
      moodValue += 3;
    }
    else if (emotionEntry.eveningCheck.mood == 'Happy') {
      moodValue += 4;
    }
    else if (emotionEntry.eveningCheck.mood == 'VeryHappy') {
      moodValue += 5;
    }


    int overallMood = (moodValue / moodCount) as int;
    if (overallMood == 1) {
      emotionEntry.overallMood = 'VeryBad';
    }
    else if (overallMood == 2) {
      emotionEntry.overallMood = 'Bad';
    }
    else if (overallMood == 3) {
      emotionEntry.overallMood = 'Neutral';
    }
    else if (overallMood == 4) {
      emotionEntry.overallMood = 'Happy';
    }
    else if (overallMood == 5) {
      emotionEntry.overallMood = 'VeryHappy';
    }


    print("--------------- UPDATING ---------------");
    print("[EEH] Overall Mood Name = " + emotionEntry.overallMood);
    print("[EEH] Weekday = " + emotionEntry.weekday);
    print("[EEH] Date = " + emotionEntry.date);
    print("[EED] Morning Check = " + emotionEntry.morningCheck.toString());
    print("[EED] Afternoon Check = " + emotionEntry.afternoonCheck.toString());
    print("[EED] Evening Check = " + emotionEntry.eveningCheck.toString());
    emotionEntry.save();
  }

  EmotionEntryHive getTodaysEmotionEntry() {
    Box box = Hive.box<EmotionEntryHive>('emotion');
    String date = dateToString(DateTime.now());

    if (box.containsKey(date)) {
      return box.get(date);
    }

    throw Exception('No emotion entry yet for today');
  }

  List<EmotionEntryHive> getAllEmotionEntries() {
    Box box = Hive.box<EmotionEntryHive>('emotion');
    final emotionEntryKeys = box.keys;
    List<EmotionEntryHive> emotionEntries = [];
    for (var key in emotionEntryKeys) {
      emotionEntries.add(box.get(key));
    }

    return emotionEntries;
  }

  void deleteEmotionEntry() {
    Box box = Hive.box<EmotionEntryHive>('emotion');
    EmotionEntryHive emotionEntry = box.get(dateToString(DateTime.now()));
    emotionEntry.delete();
  }

  // KEY FOR THE BOX
  String dateToString(DateTime dateTime) {
    return dateTime.year.toString() + "-" + dateTime.month.toString() + "-" + dateTime.day.toString();
  }

  
  String timeToString(DateTime dateTime) {
    return dateTime.hour.toString() + ":" + dateTime.minute.toString() + ":" + dateTime.second.toString();
  }

  void checkIfFirstTimeAddingForTheDay() {
    Box box = Hive.box<EmotionEntryHive>('emotion');
    String key = dateToString(DateTime.now());
    isFirstTimeAdding.value = !box.containsKey(key);
  
    update();
  }

  void setEditMode(bool isEdit) {
    isEditMode.value = isEdit;

    update();
  }
}
