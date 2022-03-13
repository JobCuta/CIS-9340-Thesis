// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/emotionEntryHive.dart';
import 'package:flutter_application_1/models/Mood.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class EmotionController extends GetxController {
  final _selectedPositiveEmotions = [].obs;
  final _selectedNegativeEmotions = [].obs;
  var mainEmotion = ''.obs;
  var note = ''.obs;
  var isPositiveNotEmpty = false.obs;
  var isNegativeNotEmpty = false.obs;
  var isValid = false.obs;
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

  void saveToStorage() {
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

    // add method to (hour + minute + second) in a string
    String time = DateTime.now().toString();
    Map<String, Mood> test1 = {
      time : Mood(name: MoodEnum.Bad, icon: const AssetImage('assets/images/face_very_happy.png'), isSelected: true),
    };

    String date = dateTimeNowToString();

    if (isValid.value) {
      Box box = Hive.box<EmotionEntryHive>('emotion');
      EmotionEntryHive newEmotionEntry = EmotionEntryHive(
        // gonna make this dynamic later (overallMood, morningCheck, afternoonCheck, eveningCheck)
        overallMood: Mood(name: MoodEnum.Neutral, icon: const AssetImage('assets/images/face_very_happy.png'), isSelected: true), 
        weekday: weekdayString[DateTime.now().weekday] as String, 
        date: date,
        morningCheck: test1[time] as Map<String, Mood>,
        afternoonCheck: test1[time] as Map<String, Mood>,
        eveningCheck: test1[time] as Map<String, Mood>
      );

      box.put(date, newEmotionEntry);
    }
  }

  void updateEntryInStorage(String key, Map<String, Mood> morningCheck, Map<String, Mood> afternoonCheck, Map<String, Mood> eveningCheck) {
    Box box = Hive.box<EmotionEntryHive>('emotion');
    EmotionEntryHive emotionEntry = box.get(key);
    
    if (morningCheck != null) {
      emotionEntry.morningCheck = morningCheck;
    }
    if (afternoonCheck != null) {
      emotionEntry.afternoonCheck = afternoonCheck;
    }
    if (eveningCheck != null) {
      emotionEntry.eveningCheck = eveningCheck;
    }

    emotionEntry.save();
  }

  EmotionEntryHive getTodaysEmotionEntry() {
    Box box = Hive.box<EmotionEntryHive>('emotion');
    String date = dateTimeNowToString();

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

  void deleteEmotionEntry(String key) {
    Box box = Hive.box<EmotionEntryHive>('emotion');
    EmotionEntryHive emotionEntry = box.get(key);
    emotionEntry.delete();
  }

  String dateTimeNowToString() {
    DateTime dateTime = DateTime.now();
    return dateTime.year.toString() + "-" + dateTime.month.toString() + "-" + dateTime.day.toString();
  }

  void setEditMode(bool isEdit) {
    isEditMode.value = isEdit;
    update();
  }

}
