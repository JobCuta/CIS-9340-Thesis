// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/emotionEntryHive.dart';
import 'package:flutter_application_1/enums/PartOfTheDay.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/Mood.dart';
import 'package:flutter_application_1/screens/main/EmotionalEvaluationEndScreen.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../apis/EmotionEntryDetail.dart';

class EmotionController extends GetxController {
  var _selectedEmotionEntry;

  var _selectedPositiveEmotions = [].obs;
  var _selectedNegativeEmotions = [].obs;
  var mainEmotion = ''.obs;
  var note = ''.obs;

  var isPositiveNotEmpty = false.obs;
  var isNegativeNotEmpty = false.obs;
  var isValid = false.obs;

  var isAddingFromDaily = false.obs;
  var isEditMode = false.obs;
  var isMorningCheck = false.obs;
  var isAfternoonCheck = false.obs;
  var isEveningCheck = false.obs;


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

  void updatePartOfTheDayCheck(PartOfTheDay part) {
    if (part == PartOfTheDay.Morning) {
      isMorningCheck.value = true;
      isAfternoonCheck.value = false;
      isEveningCheck.value = false;
    }
    else if (part == PartOfTheDay.Afternoon) {
      isAfternoonCheck.value = true;
      isMorningCheck.value = false;
      isEveningCheck.value = false;
    }
    else if (part == PartOfTheDay.Evening) {
      isEveningCheck.value = true;
      isMorningCheck.value = false;
      isAfternoonCheck.value = false;
    }

    print ("Part of the Day checks = " + isMorningCheck.value.toString() + ", " + isAfternoonCheck.value.toString() + ", " + isEveningCheck.value.toString());
    update();
  }

  void resetAllValues() {
    isMorningCheck.value = false;
    isAfternoonCheck.value = false;
    isEveningCheck.value = false;
    isAddingFromDaily.value = false;
    isEditMode.value = true;

    _selectedPositiveEmotions.value = [];
    _selectedNegativeEmotions.value = [];
    mainEmotion.value = '';
    note.value = '';

    isPositiveNotEmpty.value = false;
    isNegativeNotEmpty.value = false;
    isValid.value = false;

    update();
  }

  // THIS METHOD WILL ONLY BE USED IN DAILYCONTROLLER
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

    Map<int, String> month = {
      1: 'January',
      2: 'Febuary',
      3: 'March',
      4: 'April',
      5: 'May',
      6: 'June',
      7: 'July',
      8: 'August',
      9: 'September',
      10: 'October',
      11: 'November',
      12: 'December'
    };

    DateTime dateTime = DateTime.now();
    String date = dateToString(dateTime);
    String time = timeToString(dateTime);
    Mood? mood = moodMap['NoData'] as Mood;
    List<dynamic> positiveEmotions = [];
    List<dynamic> negativeEmotions = [];

    Box box = Hive.box<EmotionEntryHive>('emotion');
    EmotionEntryHive newEmotionEntry = EmotionEntryHive(
      overallMood: mood.name, 
      weekday: weekdayString[DateTime.now().weekday] as String, 
      month: month[dateTime.month] as String,
      day: dateTime.day,
      year: dateTime.year,
      morningCheck: EmotionEntryDetail(isEmpty: true, mood: moodMap['NoData']!.name, positiveEmotions: [], negativeEmotions: []),
      afternoonCheck: EmotionEntryDetail(isEmpty: true, mood: moodMap['NoData']!.name, positiveEmotions: [], negativeEmotions: []),
      eveningCheck: EmotionEntryDetail(isEmpty: true, mood: moodMap['NoData']!.name, positiveEmotions: [], negativeEmotions: []),
    );

    resetAllValues();
    print("--------------- ADDING ---------------");
    print("Emotion box length = " + box.length.toString());
    print("[EEH] Overall Mood Name = " + newEmotionEntry.overallMood);
    print("[EEH] Weekday = " + newEmotionEntry.weekday);
    print("[EED] Morning Check = " + newEmotionEntry.morningCheck.toString());
    print("[EED] Afternoon Check = " + newEmotionEntry.afternoonCheck.toString());
    print("[EED] Evening Check = " + newEmotionEntry.eveningCheck.toString());

    box.put(date, newEmotionEntry);
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

    calculateOverallMood(emotionEntry);

    print("--------------- UPDATING ---------------");
    print("[EEH] Overall Mood Name = " + emotionEntry.overallMood);
    print("[EEH] Weekday = " + emotionEntry.weekday);
    print("[EED] Morning Check = " + emotionEntry.morningCheck.toString());
    print("[EED] Afternoon Check = " + emotionEntry.afternoonCheck.toString());
    print("[EED] Evening Check = " + emotionEntry.eveningCheck.toString());
    resetAllValues();
    emotionEntry.save();
  }

  EmotionEntryHive getTodaysEmotionEntry() {
    Box box = Hive.box<EmotionEntryHive>('emotion');
    String date = dateToString(DateTime.now());

    if (box.containsKey(date)) {
      return box.get(date);
    } else {
      saveEntryToStorage();
      return box.get(date);
    }
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

  void deleteEmotionEntry(PartOfTheDay part) {
    Box box = Hive.box<EmotionEntryHive>('emotion');
    EmotionEntryHive emotionEntry = box.get(dateToString(DateTime.now()));
    
    if (part == PartOfTheDay.Morning) {
      emotionEntry.morningCheck = EmotionEntryDetail(isEmpty: true, mood: moodMap['NoData']!.name, positiveEmotions: [], negativeEmotions: []);
    }
    else if (part == PartOfTheDay.Afternoon) {
      emotionEntry.afternoonCheck = EmotionEntryDetail(isEmpty: true, mood: moodMap['NoData']!.name, positiveEmotions: [], negativeEmotions: []);
    }
    else if (part == PartOfTheDay.Evening) {
      emotionEntry.eveningCheck = EmotionEntryDetail(isEmpty: true, mood: moodMap['NoData']!.name, positiveEmotions: [], negativeEmotions: []);
    }

    calculateOverallMood(emotionEntry);

    emotionEntry.save();
  }

  // KEY FOR THE BOX
  String dateToString(DateTime dateTime) {
    return dateTime.year.toString() + "-" + dateTime.month.toString() + "-" + dateTime.day.toString();
  }

  
  String timeToString(DateTime dateTime) {
    return dateTime.hour.toString() + ":" + dateTime.minute.toString();
  }

  void updateIfAddingFromDaily(bool isFromDaily) {
    isAddingFromDaily.value = isFromDaily;
    update();
  }

  void updateEditMode(bool isEdit) {
    isEditMode.value = isEdit;
    update();
  }

  void updateSelectedEmotionEntry(EmotionEntryHive emotionEntry) {
    _selectedEmotionEntry = emotionEntry;
    update();
  }

  EmotionEntryHive getSelectedEmotionEntry() {
    return _selectedEmotionEntry;
  }

  void calculateOverallMood(EmotionEntryHive emotionEntry) {
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


    num overallMood = moodValue / moodCount;
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
  }
}
