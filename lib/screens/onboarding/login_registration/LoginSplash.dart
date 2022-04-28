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

  String latestPhq = '', latestSidas = '';
  /// Get data from online database
  /// Works by checking which storage is more up to date
  ///

  Future<Widget> loadFromFuture() async {
    // Get latest changes from local storage
    // Get entire database scores of SIDAS, PHQ, HOPEBOX, LEVEL, ACHIEVEMENTS, ETC.
    // compare if the latest entry is much later than the database
    // somehow check if updated missed entries are up-to-date as well
    loadingStatus = 'Getting List from Server..';

    updatePHQ();
    updateSIDAS();

    return Future.value(HomePageScreen(2));
  }

  updatePHQ() async {
    loadingStatus = 'Updating PHQ Entries..';
    await TableSecureStorage.getLatestPHQ().then((value) => latestPhq = value.toString());
    List phqList = await UserProvider().phqScores();
    DateTime phqServer = phqList.first.date, phqLocal = DateTime.parse(latestPhq);

    for (var entry in phqList) {
      DateTime parsed = DateFormat('dd/MM/yyyy HH:mm:ss').parse(entry["date_created"]);
      entry["date_created"] = parsed.toUtc().toString();
    }

    if (phqServer.isBefore(phqLocal)) {
      UserProvider().bulkPhqUpdate(phqList);
    } else {
      var box = Hive.box('phq');
      for (var entry in phqList) {
        DateTime date = entry["date_created"].toUtc();
        var item = phqHive(date: entry["date_created"], index: entry["id"], score: entry["score"]);
        String key = date.month.toString() + '-' + date.day.toString();
        box.put(key, item);
      }
    }
  }

  updateSIDAS() async {
    loadingStatus = 'Updating SIDAS Entries..';
    await TableSecureStorage.getLatestSIDAS().then((value) => latestSidas = value.toString());
    List sidasList = await UserProvider().sidasScores();
    DateTime sidasServer = sidasList.first.date, sidasLocal = DateTime.parse(latestSidas);

    for (var entry in sidasList) {
      DateTime parsed = DateFormat('dd/MM/yyyy HH:mm:ss').parse(entry["date_created"]);
      entry["date_created"] = parsed.toUtc().toString();
    }

    if (sidasServer.isBefore(sidasLocal)) {
      UserProvider().bulkPhqUpdate(sidasList);
    } else {
      var box = Hive.box('sidas');
      for (var entry in sidasList) {
        DateTime date = entry["date_created"].toUtc();
        var item = sidasHive(date: entry["date_created"], index: entry["id"], score: entry["sum"], answerValues: []);
        String key = date.month.toString() + '-' + date.day.toString();
        box.put(key, item);
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
