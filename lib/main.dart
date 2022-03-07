import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/debug/HomepageScreen.dart';
import 'package:flutter_application_1/screens/debug/WellnessExercisesScreen.dart';
import 'package:flutter_application_1/screens/onboarding/login_registration/AnonymousScreen.dart';
import 'apis/userSecureStorage.dart';
// import 'screens/main/HomepageScreen.dart';
// import 'screens/main/WellnessExercisesScreen.dart';
import 'screens/onboarding/intro/ShakeScreen.dart';
import 'screens/onboarding/intro/IntroductionScreen.dart';
import 'screens/onboarding/login_registration/AboutSelfScreen.dart';
import 'screens/onboarding/login_registration/CreateAccountScreen.dart';
import 'screens/onboarding/login_registration/ForgotPasswordScreen.dart';
import 'screens/onboarding/questionnaires/EmotionalEvaluationPositiveNegativeScreen.dart';
import 'screens/onboarding/questionnaires/EmotionalEvaluationScreen.dart';
import 'screens/onboarding/questionnaires/InitialAssessmentScreen.dart';
import 'screens/onboarding/questionnaires/LoadingResultsScreen.dart';
import 'screens/onboarding/questionnaires/PHQ9Interpretation.dart';
import 'screens/onboarding/questionnaires/PHQ9Screen.dart';
import 'package:get/get.dart';
import 'screens/onboarding/questionnaires/SetNotificationScreen.dart';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool isLoggedIn = false;

  @override
  void initState() {
    UserSecureStorage.getLoginKey().then((value) {
      print(value);
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
    print(isLoggedIn);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Kasiyanna App',
        initialRoute: '/',
        getPages: [
          //intro
          GetPage(name: '/introScreen', page: () => const IntroductionScreen()),
          GetPage(name: '/shakeScreen', page: () => ShakeScreen()),
          GetPage(name: '/exerciseScreen', page: () => ExerciseScreen()),
          //login_registration
          GetPage(
              name: '/accountScreen', page: () => const CreateAccountScreen()),
          GetPage(
              name: '/aboutSelfScreen', page: () => const AboutSelfScreen()),
          GetPage(name: '/anonScreen', page: () => const AnonymousScreen()),
          GetPage(
              name: '/forgotScreen', page: () => const ForgotPasswordScreen()),
          //questionnaires
          GetPage(
              name: '/assessScreen',
              page: () => const InitialAssessmentScreen()),
          GetPage(name: '/phqScreen', page: () => const PHQ9Screen()),
          GetPage(
              name: '/phqloadingScreen',
              page: () => const LoadingResultsScreen()),
          GetPage(
              name: '/phqInterpretationScreen',
              page: () => PHQ9InterpretationScreen()),
          GetPage(
              name: '/emotionScreen',
              page: () => const EmotionalEvaluationScreen()),
          GetPage(
              name: '/emotionPNScreen',
              page: () => const EmotionalEvaluationPositiveNegativeScreen()),
          //notification
          GetPage(
              name: '/notifScreen', page: () => const SetNotificationScreen()),
          // main
          GetPage(name: '/homepage', page: () => const HomePageScreen()),

          // wellness exercises
          GetPage(
              name: '/wellnessScreen',
              page: () => const WellnessExercisesScreen()),
        ],
        theme: ThemeData(
          fontFamily: 'Proxima Nova',
          //Use this to specify the default text styling
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
            bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
            subtitle1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              primary: Colors.green[400],
              padding: const EdgeInsets.all(10),
            ),
          ),
        ),
        home:
            //change to screen checking log-in persisence
            (isLoggedIn) ? const HomePageScreen() : const IntroductionScreen());
  }
}
