import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
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
    log('phq List ${phqList.first}');

    for (var entry in phqList) {
      DateTime parsed = DateFormat('dd/MM/yyyy HH:mm:ss').parse(entry["date_created"]);
      entry["date_created"] = parsed.toUtc().toString();
    }

    var box = Hive.box('phq');

    if (latestPhq == 'null') {
      box.clear();
      for (var entry in phqList) {
        DateTime date = DateTime.parse(entry["date_created"]);
        var item = phqHive(date: date, index: entry["id"], score: entry["score"].round());
        String key = date.month.toString() + '-' + date.day.toString();
        box.put(key, item);
      }
      return;
    } else {
      DateTime phqServer = DateTime.parse(phqList.first['date_created']), phqLocal = DateTime.parse(latestPhq);

      if (phqServer.isBefore(phqLocal) || box.length == 0) {
        UserProvider().bulkPhqUpdate(phqList);
      } else {
        box.clear();
        for (var entry in phqList) {
          DateTime date = DateTime.parse(entry["date_created"]);
          var item = phqHive(date: entry["date_created"], index: entry["id"], score: entry["score"].round());
          String key = date.month.toString() + '-' + date.day.toString();
          box.put(key, item);
        }
      }
    }
  }

  updateSIDAS() async {
    Future.delayed(const Duration(milliseconds: 1000), () {
      loadingStatus = 'Updating SIDAS Entries..';
    });

    await TableSecureStorage.getLatestSIDAS().then((value) => latestSidas = value.toString());
    List sidasList = await UserProvider().sidasScores();
    log('sidas List $sidasList');

    for (var entry in sidasList) {
      DateTime parsed = DateFormat('dd/MM/yyyy HH:mm:ss').parse(entry["date_created"]);
      entry["date_created"] = parsed.toUtc().toString();
    }

    var box = Hive.box('sidas');

    if (latestSidas == 'null') {
      box.clear();
      for (var entry in sidasList) {
        DateTime date = DateTime.parse(entry["date_created"]);
        var item = sidasHive(date: date, index: entry["id"], score: entry["sum"].round(), answerValues: []);
        String key = date.month.toString() + '-' + date.day.toString();
        box.put(key, item);
      }
      return;
    } else {
      DateTime sidasServer = DateTime.parse(sidasList.first['date_created']), sidasLocal = DateTime.parse(latestSidas);

      if (sidasServer.isBefore(sidasLocal)) {
        UserProvider().bulkPhqUpdate(sidasList);
      } else {
        for (var entry in sidasList) {
          DateTime date = entry["date_created"].toUtc();
          var item = sidasHive(date: date, index: entry["id"], score: entry["sum"].round(), answerValues: []);
          String key = date.month.toString() + '-' + date.day.toString();
          box.put(key, item);
        }
      }
    }
  }

  updateEmotions() async {
    Future.delayed(const Duration(milliseconds: 1000), () {
      loadingStatus = 'Updating Emotion Entries..';
    });

    await TableSecureStorage.getLatestEmotion().then((value) => latestEmotion);
    List<dynamic> emotionList = await UserProvider().emotionScores();
    log('emotion List $emotionList');

    var box = Hive.box('emotions');

    if (latestEmotion == 'null') {
    } else {
      DateTime emotionServer = DateTime.parse(''), emotionLocal = DateTime.parse(latestEmotion);
      if (emotionServer.isBefore(emotionLocal)) {
        UserProvider().bulkEmotionUpdate([]);
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
