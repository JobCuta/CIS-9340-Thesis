import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/apis/emotionEntryHive.dart';
import 'package:flutter_application_1/enums/PartOfTheDay.dart';
import 'package:flutter_application_1/models/Mood.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../apis/EmotionEntryDetail.dart';

class EmotionController extends GetxController {
  var _selectedEmotionEntry;

  var selectedPositiveEmotions = [].obs;
  var selectedNegativeEmotions = [].obs;
  var mainEmotion = ''.obs;
  var note = ''.obs;
  var dateTime = DateTime.now().obs;

  var isPositiveNotEmpty = false.obs;
  var isNegativeNotEmpty = false.obs;
  var isValid = false.obs;

  var isAddingFromDaily = false.obs;
  var isAddingFromOnboarding = false.obs;
  var isEditMode = false.obs;

  var isMorningCheck = false.obs;
  var isAfternoonCheck = false.obs;
  var isEveningCheck = false.obs;
  var noEntriesCount = 0.obs;
  var validEntriesCount = 0.obs;

  var currentStreak = 0.obs;
  var longestStreak = 0.obs;
  var monthMoodCount = [0, 0, 0, 0, 0].obs;

  Map<int, String> monthStr = {
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

  Map<String, int> monthNameToMonthNumber = {
    'January': 1,
    'February': 2,
    'March': 3,
    'April': 4,
    'May': 5,
    'June': 6,
    'July': 7,
    'August': 8,
    'September': 9,
    'October': 10,
    'November': 11,
    'December': 12
  };

  void updatePositiveEmotions(emotions) {
    selectedPositiveEmotions.value = emotions;
    isPositiveNotEmpty.value = selectedPositiveEmotions.isNotEmpty;
    isValid.value = isPositiveNotEmpty.value || isNegativeNotEmpty.value;
    update();
  }

  void updateNegativeEmotions(emotions) {
    selectedNegativeEmotions.value = emotions;
    isNegativeNotEmpty.value = selectedNegativeEmotions.isNotEmpty;
    isValid.value = isPositiveNotEmpty.value || isNegativeNotEmpty.value;
    update();
  }

  void updateMainEmotion(String s) {
    mainEmotion.value = s;
    update();
  }

  void updateNotes(String s) {
    note.value = s.trim();
    update();
  }

  void updatePartOfTheDayCheck(PartOfTheDay part) {
    if (part == PartOfTheDay.Morning) {
      isMorningCheck.value = true;
      isAfternoonCheck.value = false;
      isEveningCheck.value = false;
    } else if (part == PartOfTheDay.Afternoon) {
      isAfternoonCheck.value = true;
      isMorningCheck.value = false;
      isEveningCheck.value = false;
    } else if (part == PartOfTheDay.Evening) {
      isEveningCheck.value = true;
      isMorningCheck.value = false;
      isAfternoonCheck.value = false;
    }

    log("Part of the Day checks = " +
        isMorningCheck.value.toString() +
        ", " +
        isAfternoonCheck.value.toString() +
        ", " +
        isEveningCheck.value.toString());
    update();
  }

  void updateDateTime(String month, int day, int year) {
    dateTime.value = (DateTime.now().year != year ||
            (DateTime.now().month != monthNameToMonthNumber[month] && DateTime.now().day != day))
        ? DateTime(year = year, monthNameToMonthNumber[month] as int, day)
        : DateTime(year = year, monthNameToMonthNumber[month] as int, day, DateTime.now().hour, DateTime.now().minute);

    DateTime(year = year, monthNameToMonthNumber[month] as int, day, DateTime.now().hour, DateTime.now().minute);

    update();
  }

  void updateIfAddingFromDaily(bool isFromDaily) {
    isAddingFromDaily.value = isFromDaily;
    update();
  }

  void updateIfAddingFromOnboarding(bool isFromOnboarding) {
    isAddingFromOnboarding.value = isFromOnboarding;
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

  void resetAllValues() {
    selectedPositiveEmotions.value = [];
    selectedNegativeEmotions.value = [];
    mainEmotion.value = '';
    note.value = '';

    isPositiveNotEmpty.value = false;
    isNegativeNotEmpty.value = false;

    isAddingFromDaily.value = false;
    isAddingFromOnboarding.value = false;
    isEditMode.value = false;

    isMorningCheck.value = false;
    isAfternoonCheck.value = false;
    isEveningCheck.value = false;

    update();
  }

  updateEmotionBackend(EmotionEntryDetail entry) async {
    /// update entry in the backend
    /// if the entry does not exist in the backend, it is created instead.
    log('this the entry ${entry.toString()}');
    Map<String, String> result = await UserProvider().updateEmotion(entry, dateTime.value);
    String title = '', sub = '';
    log('saving emotion to backend.. ${result}');
    switch (result['status']) {
      case 'Not Found':
        Map<String, dynamic> create = await UserProvider().createEmotion(entry, dateTime.value);
        log('not found.. creating emotion entry.. ${create}');
        if (create["status"]) {
          log('successfully created.');
          entry.id = create['body']['id'];
          title = 'Emotion Entry saved!';
          sub = 'Entry was saved to your profile';
        } else {
          title = 'Emotion Entry not saved';
          sub = 'There was a problem saving your entry online';
        }
        break;
      case 'Updated':
        title = 'Emotion Entry saved!';
        sub = 'Entry was saved to your profile';
        break;
      case 'Error':
        title = 'Emotion Entry not saved';
        sub = 'There was a problem saving your entry online';
        break;
      default:
    }
    Get.snackbar(title, sub,
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white60, colorText: Colors.black87);
  }

  emptyMoodEntry(String timeOfDay) => EmotionEntryDetail(
      mood: moodMap['NoData']!.name,
      positiveEmotions: [],
      negativeEmotions: [],
      isEmpty: true,
      timeOfDay: timeOfDay,
      id: -1);

  // THIS METHOD WILL ONLY BE USED IN DAILYCONTROLLER
  Future<void> createNewEntriesInStorage(int differenceInDays) async {
    Map<int, String> weekdayString = {
      1: 'Monday',
      2: 'Tuesday',
      3: 'Wednesday',
      4: 'Thursday',
      5: 'Friday',
      6: 'Saturday',
      7: 'Sunday'
    };

    Mood mood = moodMap['NoData'] as Mood;

    // 0 = first time users
    // other numbers = this method was called from the dailyController, number is based on the
    // missing entries between now and last date logged in
    if (differenceInDays == 0) {
      DateTime dateTime = DateTime.now();
      String date = dateToString(dateTime);

      Box box = Hive.box<EmotionEntryHive>('emotion');
      EmotionEntryHive newEmotionEntry = EmotionEntryHive(
        overallMood: mood.name,
        weekday: weekdayString[dateTime.weekday] as String,
        month: monthStr[dateTime.month] as String,
        day: dateTime.day,
        year: dateTime.year,
        morningCheck: emptyMoodEntry('morning'),
        afternoonCheck: emptyMoodEntry('afternoon'),
        eveningCheck: emptyMoodEntry('evening'),
      );

      /// creating entries in the backend
      var uploadM = await UserProvider().createEmotion(emptyMoodEntry('morning'), dateTime);
      var uploadN = await UserProvider().createEmotion(emptyMoodEntry('afternoon'), dateTime);
      var uploadE = await UserProvider().createEmotion(emptyMoodEntry('evening'), dateTime);

      if (uploadM['status'] == true) {
        newEmotionEntry.morningCheck.id = uploadM['body']['id'];
        log('morning saved');
      }
      if (uploadN['status'] == true) {
        newEmotionEntry.morningCheck.id = uploadN['body']['id'];
        log('afternoon saved');
      }
      if (uploadE['status'] == true) {
        newEmotionEntry.morningCheck.id = uploadE['body']['id'];
        log('evening saved');
      }

      log("--------------- ADDING ---------------");
      log("Emotion box length = " + box.length.toString());
      log("[EEH] Overall Mood Name = " + newEmotionEntry.overallMood);
      log("[EEH] Weekday = " + newEmotionEntry.weekday);
      log("[EED] Morning Check = " + newEmotionEntry.morningCheck.toString());
      log("[EED] Afternoon Check = " + newEmotionEntry.afternoonCheck.toString());
      log("[EED] Evening Check = " + newEmotionEntry.eveningCheck.toString());

      box.put(date, newEmotionEntry);
    } else {
      Box box = Hive.box<EmotionEntryHive>('emotion');
      EmotionEntryHive latestEmotionEntry = box.getAt(box.length - 1);
      log("Emotion Entry received was from ${latestEmotionEntry.month} + ${latestEmotionEntry.day} + ${latestEmotionEntry.year}");

      final latestEmotionEntryDate = DateTime(
          latestEmotionEntry.year, monthNameToMonthNumber[latestEmotionEntry.month] as int, latestEmotionEntry.day);
      log("Latest Emotion Entry Date = " + latestEmotionEntryDate.toString());

      for (int i = 1; i <= differenceInDays; i++) {
        DateTime dateTime = latestEmotionEntryDate.add(Duration(days: i));
        String date = dateToString(dateTime);

        Box box = Hive.box<EmotionEntryHive>('emotion');
        EmotionEntryHive newEmotionEntry = EmotionEntryHive(
          overallMood: mood.name,
          weekday: weekdayString[dateTime.weekday] as String,
          month: monthStr[dateTime.month] as String,
          day: dateTime.day,
          year: dateTime.year,
          morningCheck: emptyMoodEntry('morning'),
          afternoonCheck: emptyMoodEntry('afternoon'),
          eveningCheck: emptyMoodEntry('evening'),
        );

        /// creating entries in the backend
        var uploadM = await UserProvider().createEmotion(emptyMoodEntry('morning'), dateTime);
        var uploadN = await UserProvider().createEmotion(emptyMoodEntry('afternoon'), dateTime);
        var uploadE = await UserProvider().createEmotion(emptyMoodEntry('evening'), dateTime);

        if (uploadM['status'] == true) {
          newEmotionEntry.morningCheck.id = uploadM['body']['id'];
          log('morning saved');
        }
        if (uploadN['status'] == true) {
          newEmotionEntry.morningCheck.id = uploadN['body']['id'];
          log('afternoon saved');
        }
        if (uploadE['status'] == true) {
          newEmotionEntry.morningCheck.id = uploadE['body']['id'];
          log('evening saved');
        }

        log("--------------- ADDING ---------------");
        log("Emotion box length = " + box.length.toString());
        log("[EEH] Overall Mood Name = " + newEmotionEntry.overallMood);
        log("[EEH] Weekday = " + newEmotionEntry.weekday);
        log("[EED] Morning Check = " + newEmotionEntry.morningCheck.toString());
        log("[EED] Afternoon Check = " + newEmotionEntry.afternoonCheck.toString());
        log("[EED] Evening Check = " + newEmotionEntry.eveningCheck.toString());

        box.put(date, newEmotionEntry);
      }
    }
  }

  Future<void> updateEntryInStorage() async {
    Box box = Hive.box<EmotionEntryHive>('emotion');
    String time = timeToString(dateTime.value);

    EmotionEntryHive emotionEntry = box.get(dateToString(dateTime.value));
    Mood? mood = moodMap[mainEmotion.value] as Mood;
    List<dynamic> positiveEmotions = selectedPositiveEmotions.value;
    List<dynamic> negativeEmotions = selectedNegativeEmotions.value;

    if (!isMorningCheck.value && !isAfternoonCheck.value && !isEveningCheck.value) {
      if (dateTime.value.hour < 12 && dateTime.value.hour > 23) {
        isMorningCheck.value = true;
      } else if (dateTime.value.hour > 11 && dateTime.value.hour < 18) {
        isAfternoonCheck.value = true;
      } else if (dateTime.value.hour > 17 && dateTime.value.hour < 24) {
        isEveningCheck.value = true;
      }
    }

    if (isMorningCheck.value) {
      emotionEntry.morningCheck.time = time;
      emotionEntry.morningCheck.note = note.value;
      emotionEntry.morningCheck.mood = mood.name;
      emotionEntry.morningCheck.positiveEmotions = positiveEmotions;
      emotionEntry.morningCheck.negativeEmotions = negativeEmotions;
      emotionEntry.morningCheck.isEmpty = false;
      updateEmotionBackend(emotionEntry.morningCheck);
    } else if (isAfternoonCheck.value) {
      emotionEntry.afternoonCheck.time = time;
      emotionEntry.afternoonCheck.note = note.value;
      emotionEntry.afternoonCheck.mood = mood.name;
      emotionEntry.afternoonCheck.positiveEmotions = positiveEmotions;
      emotionEntry.afternoonCheck.negativeEmotions = negativeEmotions;
      emotionEntry.afternoonCheck.isEmpty = false;
      updateEmotionBackend(emotionEntry.afternoonCheck);
    } else if (isEveningCheck.value) {
      emotionEntry.eveningCheck.time = time;
      emotionEntry.eveningCheck.note = note.value;
      emotionEntry.eveningCheck.mood = mood.name;
      emotionEntry.eveningCheck.positiveEmotions = positiveEmotions;
      emotionEntry.eveningCheck.negativeEmotions = negativeEmotions;
      emotionEntry.eveningCheck.isEmpty = false;
      updateEmotionBackend(emotionEntry.eveningCheck);
    }

    calculateOverallMood(emotionEntry);
    emotionEntry.save();

    log("--------------- UPDATING ---------------");
    log("[EEH] Overall Mood Name = " + emotionEntry.overallMood);
    log("[EEH] Weekday = " + emotionEntry.weekday);
    log("[EED] Morning Check = " + emotionEntry.morningCheck.toString());
    log("[EED] Afternoon Check = " + emotionEntry.afternoonCheck.toString());
    log("[EED] Evening Check = " + emotionEntry.eveningCheck.toString());
    resetAllValues();
  }

  EmotionEntryHive getTodaysEmotionEntry() {
    Box box = Hive.box<EmotionEntryHive>('emotion');
    String date = dateToString(DateTime.now());
    if (box.containsKey(date)) {
      return box.get(date);
    } else {
      createNewEntriesInStorage(0);
      return box.get(date);
    }
  }

  EmotionEntryHive getEmotionEntryForDate(DateTime dateTime) {
    Box box = Hive.box<EmotionEntryHive>('emotion');
    String date = dateToString(dateTime);
    if (box.containsKey(date)) {
      return box.get(date);
    } else {
      throw Exception("Entry with this date doesn't exist");
    }
  }

  List<EmotionEntryHive> getEmotionEntriesInTheLastDays(int days) {
    Box box = Hive.box<EmotionEntryHive>('emotion');
    final emotionEntryKeys = box.keys;

    if (emotionEntryKeys.length <= days) {
      return box.values.toList() as List<EmotionEntryHive>;
    } else {
      List<EmotionEntryHive> emotionEntries = [];
      int index = box.length;

      for (int i = 1; i <= days; i++) {
        EmotionEntryHive emotionEntry = box.getAt(index - i);
        emotionEntries.add(emotionEntry);
      }
      return emotionEntries;
    }
  }

  List<EmotionEntryHive> getEmotionEntriesForMonth(int month, int year) {
    Box box = Hive.box<EmotionEntryHive>('emotion');
    final emotionEntryKeys = box.keys;
    List<EmotionEntryHive> emotionEntries = [];
    currentStreak.value = 0;
    monthMoodCount.value = [0, 0, 0, 0, 0];
    // update();

    String selectedMonth = monthStr[month] as String;

    for (var key in emotionEntryKeys) {
      EmotionEntryHive emotionEntry = box.get(key);
      if (emotionEntry.month == selectedMonth && emotionEntry.year == year) {
        emotionEntries.add(emotionEntry);
        if (emotionEntry.overallMood == 'VeryBad') {
          monthMoodCount.value[0]++;
        } else if (emotionEntry.overallMood == 'Bad') {
          monthMoodCount.value[1]++;
        } else if (emotionEntry.overallMood == 'Neutral') {
          monthMoodCount.value[2]++;
        } else if (emotionEntry.overallMood == 'Happy') {
          monthMoodCount.value[3]++;
        } else if (emotionEntry.overallMood == 'VeryHappy') {
          monthMoodCount.value[4]++;
        }
      }

      if (emotionEntry.overallMood != 'NoData') {
        currentStreak.value++;
      } else {
        currentStreak.value = 0;
      }
    }

    log("CURRENT STREAK VALUE = $currentStreak");
    log("MONTH MOOD COUNT = ${monthMoodCount.toString()}");

    // update();
    return emotionEntries;
  }

  void updateCurrentStreakAndMonthMoodCount(int month, int year) {
    Box box = Hive.box<EmotionEntryHive>('emotion');
    final emotionEntryKeys = box.keys;
    List<EmotionEntryHive> emotionEntries = [];
    currentStreak.value = 0;
    monthMoodCount.value = [0, 0, 0, 0, 0];
    update();

    String selectedMonth = monthStr[month] as String;

    for (var key in emotionEntryKeys) {
      EmotionEntryHive emotionEntry = box.get(key);
      if (emotionEntry.month == selectedMonth && emotionEntry.year == year) {
        emotionEntries.add(emotionEntry);
        if (emotionEntry.overallMood == 'VeryBad') {
          monthMoodCount.value[0]++;
        } else if (emotionEntry.overallMood == 'Bad') {
          monthMoodCount.value[1]++;
        } else if (emotionEntry.overallMood == 'Neutral') {
          monthMoodCount.value[2]++;
        } else if (emotionEntry.overallMood == 'Happy') {
          monthMoodCount.value[3]++;
        } else if (emotionEntry.overallMood == 'VeryHappy') {
          monthMoodCount.value[4]++;
        }
      }

      if (emotionEntry.overallMood != 'NoData') {
        currentStreak.value++;
      } else {
        currentStreak.value = 0;
      }
    }

    log("CURRENT STREAK VALUE = $currentStreak");
    log("MONTH MOOD COUNT = ${monthMoodCount.toString()}");

    update();
  }

  void updateLongestStreak() {
    int longestStreakTemp = 0;
    Box box = Hive.box<EmotionEntryHive>('emotion');
    final emotionEntryKeys = box.keys;
    for (var key in emotionEntryKeys) {
      EmotionEntryHive emotionEntry = box.get(key);
      if (emotionEntry.overallMood == 'NoData') {
        longestStreakTemp = 0;
      } else {
        longestStreakTemp++;
      }
    }

    longestStreak.value = longestStreakTemp;
    update();
  }

  List<EmotionEntryHive> getAllEmotionEntries() {
    Box box = Hive.box<EmotionEntryHive>('emotion');
    final emotionEntryKeys = box.keys;
    List<EmotionEntryHive> emotionEntries = [];
    for (var key in emotionEntryKeys) {
      EmotionEntryHive emotionEntry = box.get(key);
      emotionEntries.add(emotionEntry);
      if (emotionEntry.overallMood == 'NoData') {
        noEntriesCount.value++;
      }
    }
    // update();
    return emotionEntries;
  }

  void checkNoEntriesCount() {
    noEntriesCount.value = 0;
    Box box = Hive.box<EmotionEntryHive>('emotion');
    final emotionEntryKeys = box.keys;
    for (var key in emotionEntryKeys) {
      EmotionEntryHive emotionEntry = box.get(key);
      if (emotionEntry.overallMood == 'NoData') {
        noEntriesCount.value++;
      }
    }
    // update();
  }

  void checkValidEntriesCount() {
    validEntriesCount.value = 0;
    Box box = Hive.box<EmotionEntryHive>('emotion');
    final emotionEntryKeys = box.keys;
    for (var key in emotionEntryKeys) {
      EmotionEntryHive emotionEntry = box.get(key);
      if (emotionEntry.overallMood != 'NoData') {
        validEntriesCount.value++;
      }
    }
    update();
  }

  void deleteEmotionEntry(PartOfTheDay part) {
    Box box = Hive.box<EmotionEntryHive>('emotion');
    EmotionEntryHive emotionEntry = box.get(dateToString(DateTime.now()));

    if (part == PartOfTheDay.Morning) {
      emotionEntry.morningCheck = EmotionEntryDetail(
        isEmpty: true,
        mood: moodMap['NoData']!.name,
        positiveEmotions: [],
        negativeEmotions: [],
        timeOfDay: 'morning',
        id: -1,
      );
    } else if (part == PartOfTheDay.Afternoon) {
      emotionEntry.afternoonCheck = EmotionEntryDetail(
        isEmpty: true,
        mood: moodMap['NoData']!.name,
        positiveEmotions: [],
        negativeEmotions: [],
        timeOfDay: 'afternoon',
        id: -1,
      );
    } else if (part == PartOfTheDay.Evening) {
      emotionEntry.eveningCheck = EmotionEntryDetail(
        isEmpty: true,
        mood: moodMap['NoData']!.name,
        positiveEmotions: [],
        negativeEmotions: [],
        timeOfDay: 'evening',
        id: -1,
      );
    }

    calculateOverallMood(emotionEntry);

    emotionEntry.save();
  }

  // KEY FOR THE BOX
  String dateToString(DateTime dateTime) {
    String month = dateTime.month < 10 ? '0${dateTime.month}' : dateTime.month.toString();
    String day = dateTime.day < 10 ? '0${dateTime.day}' : dateTime.day.toString();
    String date = dateTime.year.toString() + "-" + month + "-" + day;
    log("KEY IS $date");

    return date;
  }

  String timeToString(DateTime dateTime) {
    log('$dateTime');
    return DateFormat.Hm().format(dateTime);
  }

  void calculateOverallMood(EmotionEntryHive emotionEntry) {
    int moodCount = 0;
    int moodValue = 0;

    if (emotionEntry.morningCheck.mood != 'NoData') {
      moodCount++;
      moodValue += emotionEntry.morningCheck.mood == 'VeryBad'
          ? 1
          : emotionEntry.morningCheck.mood == 'Bad'
              ? 2
              : emotionEntry.morningCheck.mood == 'Neutral'
                  ? 3
                  : emotionEntry.morningCheck.mood == 'Happy'
                      ? 4
                      : emotionEntry.morningCheck.mood == 'VeryHappy'
                          ? 5
                          : 0;
    }

    if (emotionEntry.afternoonCheck.mood != 'NoData') {
      moodCount++;
      moodValue += emotionEntry.afternoonCheck.mood == 'VeryBad'
          ? 1
          : emotionEntry.afternoonCheck.mood == 'Bad'
              ? 2
              : emotionEntry.afternoonCheck.mood == 'Neutral'
                  ? 3
                  : emotionEntry.afternoonCheck.mood == 'Happy'
                      ? 4
                      : emotionEntry.afternoonCheck.mood == 'VeryHappy'
                          ? 5
                          : 0;
    }

    if (emotionEntry.eveningCheck.mood != 'NoData') {
      moodCount++;
      moodValue += emotionEntry.eveningCheck.mood == 'VeryBad'
          ? 1
          : emotionEntry.eveningCheck.mood == 'Bad'
              ? 2
              : emotionEntry.eveningCheck.mood == 'Neutral'
                  ? 3
                  : emotionEntry.eveningCheck.mood == 'Happy'
                      ? 4
                      : emotionEntry.eveningCheck.mood == 'VeryHappy'
                          ? 5
                          : 0;
    }

    if (moodCount != 0) {
      num overallMood = moodValue / moodCount;
      if (overallMood.floor() == 1) {
        emotionEntry.overallMood = 'VeryBad';
      } else if (overallMood.floor() == 2) {
        emotionEntry.overallMood = 'Bad';
      } else if (overallMood.floor() == 3) {
        emotionEntry.overallMood = 'Neutral';
      } else if (overallMood.floor() == 4) {
        emotionEntry.overallMood = 'Happy';
      } else if (overallMood.floor() == 5) {
        emotionEntry.overallMood = 'VeryHappy';
      }
    } else {
      emotionEntry.overallMood = 'NoData';
    }
  }

  // ---------------------------------- EVERYTHING BELOW IS ADMIN / TESTING PURPOSES ONLY ----------------------------------
  void testLargeNumberOfFutureEntries(int numberOfEntries) {
    final latestEmotionEntryDate = DateTime(2022, 4, 10);

    DateTime currentDate = DateTime.now();
    int differenceInDays = daysBetween(latestEmotionEntryDate, currentDate);

    for (int i = 1; i <= differenceInDays; i++) {
      DateTime dateTime = latestEmotionEntryDate.add(Duration(days: i));
      log("DATETIME $i is ${dateTime.month} ${dateTime.day} ${dateTime.year}");
    }
    createNewEntriesInStorage(numberOfEntries);
  }

  void testLargeNumberOfPastEntries(int numberOfEntries) {
    final latestEmotionEntryDate = DateTime(2022, 4, 10);

    DateTime currentDate = DateTime.now();
    int differenceInDays = daysBetween(latestEmotionEntryDate, currentDate);

    for (int i = 1; i <= differenceInDays; i++) {
      DateTime dateTime = latestEmotionEntryDate.subtract(Duration(days: i));
      log("DATETIME $i is ${dateTime.month} ${dateTime.day} ${dateTime.year}");
    }
    // createNewEntriesInStorage(numberOfEntries);
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
