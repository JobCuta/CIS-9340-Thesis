import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/apis/phqHive.dart';
import 'package:flutter_application_1/apis/sidasHive.dart';
import 'package:flutter_application_1/apis/tableSecureStorage.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/main/HomepageScreen.dart';
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
    // Get entire database scores of SIDAS, PHQ, HOPEBOX, LEVEL, ACHIEVEMENTS, ETC.
    // compare if the latest entry is much later than the database
    // somehow check if updated missed entries are up-to-date as well
    await TableSecureStorage.getLatestPHQ().then((value) => latestPhq = value.toString());
    await TableSecureStorage.getLatestSIDAS().then((value) => latestSidas = value.toString());

    log('these dates $latestPhq, $latestSidas');
    List<phqHive> phqList = await UserProvider().phqScores();
    List<sidasHive> sidasList = await UserProvider().sidasScores();

    DateTime phqDate = phqList.first.date;
    DateTime sidasDate = sidasList.first.date;

    log('----PHQ SCORES---- \n $phqList');
    // Check if PHQ date here is more recent that database

    // apply to the rest

    // update the database - local overwriting the database with no entries
    // datebase update the local - datbase might have older entries

    return Future.value(HomePageScreen(2));
  }

  compareDates() {
    
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
