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
  // await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
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

    await TableSecureStorage.getLatestSIDAS().then((value) => latestSidas = value.toString());

    log('these dates $latestPhq, $latestSidas');

    List<sidasHive> sidasList = await UserProvider().sidasScores();

    DateTime sidasServer = sidasList.first.date, sidasLocal = DateTime.parse(latestSidas);

    loadingStatus = 'Updating Lists..';

    if (sidasServer.isBefore(sidasLocal)) {
    } else {}

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
      box.clear();
      for (var entry in phqList) {
        DateTime itemD = DateFormat('dd/MM/yyyy HH:mm:ss').parse(entry["date_created"]);
        var item = phqHive(date: itemD, index: entry["id"], score: entry["score"]);
        String key = itemD.month.toString() + '-' + itemD.day.toString();
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
