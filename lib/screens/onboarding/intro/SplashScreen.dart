import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main/HomepageScreen.dart';
import 'package:flutter_application_1/screens/onboarding/intro/LanguageSelectScreen.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter_application_1/apis/userSecureStorage.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isLoggedIn = false;

  @override
  void initState() {
    UserSecureStorage.getLoginKey().then((value) {
      if (value == null) {
        setState(() {
          isLoggedIn = false;
        });
      } else {
        setState(() {
          isLoggedIn = true;
        });
      }
    });
    super.initState();
  }

  Future<Widget> loadFromFuture() async {
    if (!isLoggedIn) {
      return Future.value(const LanguageSelect());
    }
    // Get entire database scores of SIDAS, PHQ, HOPEBOX, LEVEL, ACHIEVEMENTS, ETC.
    // compare if the latest entry is much later than the database
    // somehow check if updated missed entries are up-to-date as well

    // Check if PHQ date here is more recent that database

    // apply to the rest

    // update the database - local overwriting the database with no entries
    // datebase update the local - datbase might have older entries

    return Future.value(HomePageScreen(2));
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: (isLoggedIn) ? HomePageScreen(2) : const LanguageSelect(),
        // navigateAfterFuture: loadFromFuture(),
        image: Image.asset('assets/images/splash.png'),
        backgroundColor: Colors.white,
        photoSize: 100.0,
        loaderColor: Colors.red);
  }
}
