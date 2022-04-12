import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main/HomepageScreen.dart';
import 'package:flutter_application_1/screens/onboarding/intro/IntroductionScreen.dart';
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

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds:
            (isLoggedIn) ? HomePageScreen(2) : const LanguageSelect(),
        image: Image.asset('assets/images/splash.png'),
        backgroundColor: Colors.white,
        photoSize: 100.0,
        loaderColor: Colors.red);
  }
}
