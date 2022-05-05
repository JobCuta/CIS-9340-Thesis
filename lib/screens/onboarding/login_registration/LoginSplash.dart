import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/EmotionEntryDetail.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/apis/emotionEntryHive.dart';
import 'package:flutter_application_1/apis/phqHive.dart';
import 'package:flutter_application_1/apis/sidasHive.dart';
import 'package:flutter_application_1/apis/tableSecureStorage.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/main/HomepageScreen.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:splashscreen/splashscreen.dart';

class LoadingSplash extends StatefulWidget {
  const LoadingSplash({Key? key}) : super(key: key);

  @override
  State<LoadingSplash> createState() => _LoadingSplashState();
}

class _LoadingSplashState extends State<LoadingSplash> {
  String loadingStatus = 'Retrieving user details please wait..';

  String latestPhq = '', latestSidas = '', latestEmotion = '';

  /// Get data from online database
  /// Works by checking which storage is more up to date
  /// By comparing dates of latest entry from database with most recent change in local storage
  /// If the backend is outdated, entries of the list are 'updated', the list is not replaced.
  /// If the local storage is outdated, the entire Hive is replaced not updated.

  Future<Widget> loadFromFuture() async {
    await updatePHQ();
    await updateSIDAS();
    // await updateEmotions();

    return Future.value(HomePageScreen(2));
  }

  updatePHQ() async {
    Future.delayed(const Duration(milliseconds: 1000), () {
      loadingStatus = 'Updating PHQ Entries..';
    });
    await TableSecureStorage.getLatestPHQ().then((value) => latestPhq = value.toString());
    List phqList = await UserProvider().phqScores();
    // log('phq List $phqList');

    for (var entry in phqList) {
      DateTime parsed = DateFormat('dd/MM/yyyy HH:mm:ss').parse(entry["date_created"]);
      entry["date_created"] = parsed.toUtc().toString();
    }

    var box = Hive.box('phq');
    // log('phq box ${box.keys}');

    if (latestPhq == 'null') {
      log('phq latest change is new clearing everything..');
      box.clear();
      for (var entry in phqList) {
        DateTime date = DateTime.parse(entry["date_created"]);
        var item = phqHive(date: date, index: entry["id"], score: entry["score"].round());
        String key = date.month.toString() + '-' + date.day.toString();
        box.put(key, item);
      }
      TableSecureStorage.setLatestPHQ(DateTime.now().toUtc().toString());
      log('new phq box items ${box.keys}');
    } else {
      DateTime phqServer = DateTime.parse(phqList.first['date_created']), phqLocal = DateTime.parse(latestPhq);

      if (phqServer.isBefore(phqLocal) || box.length == 0) {
        List phqLocalList = box.values.map((e) => e.toJson()).toList();
        UserProvider().bulkPhqUpdate(phqLocalList);
      } else {
        log('phq database is new clearing everything..');
        box.clear();
        for (var entry in phqList) {
          DateTime date = DateTime.parse(entry["date_created"]);
          var item = phqHive(date: date, index: entry["id"], score: entry["score"].round());
          String key = date.month.toString() + '-' + date.day.toString();
          box.put(key, item);
        }
        TableSecureStorage.setLatestPHQ(DateTime.now().toUtc().toString());
        log('new phq box items ${box.keys}');
      }
    }
  }

  updateSIDAS() async {
    Future.delayed(const Duration(milliseconds: 1000), () {
      loadingStatus = 'Updating SIDAS Entries..';
    });

    await TableSecureStorage.getLatestSIDAS().then((value) => latestSidas = value.toString());
    List sidasList = await UserProvider().sidasScores();
    // log('sidas List $sidasList');

    for (var entry in sidasList) {
      DateTime parsed = DateFormat('dd/MM/yyyy HH:mm:ss').parse(entry["date_created"]);
      entry["date_created"] = parsed.toUtc().toString();
    }

    var box = Hive.box('sidas');
    // log('sidas box ${box.keys}');

    if (latestSidas == 'null') {
      log('sidas database is new clearing everything..');
      box.clear();
      for (var entry in sidasList) {
        DateTime date = DateTime.parse(entry["date_created"]);
        var item = sidasHive(date: date, index: entry["id"], score: entry["sum"].round(), answerValues: []);
        String key = date.month.toString() + '-' + date.day.toString();
        box.put(key, item);
      }
      log('new sidas box items ${box.keys}');
    } else {
      DateTime sidasServer = DateTime.parse(sidasList.first['date_created']), sidasLocal = DateTime.parse(latestSidas);

      if (sidasServer.isBefore(sidasLocal)) {
        List sidasLocalList = box.values.map((e) => e.toJson()).toList();
        UserProvider().bulkPhqUpdate(sidasLocalList);
      } else {
        log('sidas database is new clearing everything..');
        box.clear();
        for (var entry in sidasList) {
          DateTime date = entry["date_created"].toUtc();
          var item = sidasHive(date: date, index: entry["id"], score: entry["sum"].round(), answerValues: []);
          String key = date.month.toString() + '-' + date.day.toString();
          box.put(key, item);
        }
        TableSecureStorage.setLatestSIDAS(DateTime.now().toUtc().toString());
        log('new phq box items ${box.keys}');
      }
    }
  }

  updateEmotions() async {
    // Future.delayed(const Duration(milliseconds: 1000), () {
    //   loadingStatus = 'Updating Emotion Entries..';
    // });

    await TableSecureStorage.getLatestEmotion().then((value) => latestEmotion);
    Map<String, dynamic> emotionList = await UserProvider().emotionScores();
    log('emotion List $emotionList');

    var box = Hive.box('emotion');

    if (latestEmotion == 'null') {
    } else {
      DateTime emotionServer = DateTime.parse(''), emotionLocal = DateTime.parse(latestEmotion);
      if (emotionServer.isBefore(emotionLocal)) {
        List emotionLocalList = [];
        box.values.map(
          (e) {
            e as EmotionEntryHive;
            DateTime date = DateFormat('MMMM-dd-yyyy').parse('${e.month}-${e.day}-${e.year}');
            String dateString = DateFormat('yyyy-MM-dd').format(date);
            emotionLocalList.add(// Morning
                {
              'id': e.morningCheck.id,
              'date': dateString,
              'date_time_answered': e.morningCheck.time,
              'time_of_day': e.morningCheck.timeOfDay,
              'current_mood': e.morningCheck.mood,
              'positive_emotions': e.morningCheck.positiveEmotions.map((e) => e.name).toList(),
              'negative_emotions': e.morningCheck.negativeEmotions.map((e) => e.name).toList(),
            });
            emotionLocalList.add(// Afternoon
                {
              'id': e.afternoonCheck.id,
              'date': dateString,
              'date_time_answered': e.afternoonCheck.time,
              'time_of_day': e.afternoonCheck.timeOfDay,
              'current_mood': e.afternoonCheck.mood,
              'positive_emotions': e.afternoonCheck.positiveEmotions.map((e) => e.name).toList(),
              'negative_emotions': e.afternoonCheck.negativeEmotions.map((e) => e.name).toList(),
            });
            emotionLocalList.add(// Evening
                {
              'id': e.eveningCheck.id,
              'date': dateString,
              'date_time_answered': e.eveningCheck.time,
              'time_of_day': e.eveningCheck.timeOfDay,
              'current_mood': e.eveningCheck.mood,
              'positive_emotions': e.eveningCheck.positiveEmotions.map((e) => e.name).toList(),
              'negative_emotions': e.eveningCheck.negativeEmotions.map((e) => e.name).toList(),
            });
          },
        );
        UserProvider().bulkEmotionUpdate(emotionLocalList);
      } else {
        DateTime emotionServer = DateTime.parse(emotionList['date_created']),
            emotionLocal = DateTime.parse(latestSidas);

        if (emotionServer.isBefore(emotionLocal)) {
          List sidasLocalList = box.values.map((e) => e.toJson()).toList();
          UserProvider().bulkPhqUpdate(sidasLocalList);
        } else {
          box.clear();
          emptyMoodEntry(String timeOfDay) => EmotionEntryDetail(
              mood: '', positiveEmotions: [], negativeEmotions: [], isEmpty: true, timeOfDay: timeOfDay, id: -1);
          for (var entry in emotionList['entries']) {
            DateTime date = DateTime.parse(entry["date_created"]).toUtc();
            var item = EmotionEntryHive(
              overallMood: entry['overallMood'],
              weekday: DateFormat.EEEE().format(date),
              month: DateFormat.MMM().format(date),
              day: date.day,
              year: date.year,
              morningCheck: emptyMoodEntry('morning'),
              afternoonCheck: emptyMoodEntry('afternoon'),
              eveningCheck: emptyMoodEntry('evening'),
            );
            for (var emotion in entry['entries']) {
              switch (emotion['time_of_day']) {
                case 'morning':
                  var m = EmotionEntryDetail(
                      mood: emotion['current_mood'],
                      positiveEmotions: emotion['positive_emotions'],
                      negativeEmotions: emotion['negative_emotions'],
                      isEmpty: false,
                      timeOfDay: emotion['time_of_day'],
                      id: emotion['id']);
                  item.morningCheck = m;
                  break;
                case 'afternoon':
                  var a = EmotionEntryDetail(
                      mood: emotion['current_mood'],
                      positiveEmotions: emotion['positive_emotions'],
                      negativeEmotions: emotion['negative_emotions'],
                      isEmpty: false,
                      timeOfDay: emotion['time_of_day'],
                      id: emotion['id']);
                  item.morningCheck = a;
                  break;
                case 'evening':
                  var e = EmotionEntryDetail(
                      mood: emotion['current_mood'],
                      positiveEmotions: emotion['positive_emotions'],
                      negativeEmotions: emotion['negative_emotions'],
                      isEmpty: false,
                      timeOfDay: emotion['time_of_day'],
                      id: emotion['id']);
                  item.morningCheck = e;
                  break;
                default:
              }
            }
            String key = date.month.toString() + '-' + date.day.toString();
            box.put(key, item);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      navigateAfterFuture: loadFromFuture(),
      // seconds: 10,
      // navigateAfterSeconds: HomePageScreen(2),
      backgroundColor: Colors.white,
      loaderColor: Theme.of(context).colorScheme.accentBlue01,
      image: Image.asset('assets/images/splash.png'),
      photoSize: 100.0,
      loadingText: Text(loadingStatus),
    );
  }
}
