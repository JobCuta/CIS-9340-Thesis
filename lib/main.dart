import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/SideMenu/MentalHealthOnline.dart';
//import 'package:flutter_application_1/screens/debug/HomepageScreen.dart';
import 'package:flutter_application_1/screens/debug/WellnessExercisesScreen.dart';
import 'package:flutter_application_1/screens/main/EmotionalEvaluationEndScreen.dart';
import 'package:flutter_application_1/screens/main/EmotionalEvaluationStartScreen.dart';
import 'package:flutter_application_1/screens/onboarding/login_registration/AnonymousScreen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'apis/phqHive.dart';
import 'apis/sidasHive.dart';
import 'apis/dailyHive.dart';
import 'apis/emotionEntryHive.dart';
import 'apis/userSecureStorage.dart';
import 'constants/notificationService.dart';
import 'screens/SideMenu/UserProfileNamesScreen.dart';
import 'screens/SideMenu/UserProfileScreen.dart';
import 'screens/main/EntriesDetailScreen.dart';
import 'screens/main/EntriesScreen.dart';
import 'screens/main/HomepageScreen.dart';
// import 'screens/main/WellnessExercisesScreen.dart';
import 'screens/onboarding/intro/ShakeScreen.dart';
import 'screens/onboarding/intro/IntroductionScreen.dart';
import 'screens/onboarding/login_registration/AboutSelfScreen.dart';
import 'screens/onboarding/login_registration/CreateAccountScreen.dart';
import 'screens/onboarding/login_registration/ForgotPasswordScreen.dart';
import 'screens/main/CalendarScreen.dart';
import 'screens/onboarding/questionnaires/EmotionalEvaluationPositiveNegativeScreen.dart';
import 'screens/onboarding/questionnaires/EmotionalEvaluationScreen.dart';
import 'screens/onboarding/questionnaires/InitialAssessmentPHQ9Screen.dart';
import 'screens/onboarding/questionnaires/InitialAssessmentSIDASScreen.dart';
import 'screens/onboarding/questionnaires/LoadingResultsScreen.dart';
import 'screens/onboarding/questionnaires/PHQ9Interpretation.dart';
import 'screens/onboarding/questionnaires/PHQ9Screen.dart';
import 'package:get/get.dart';
import 'screens/onboarding/questionnaires/SIDASScreen.dart';
import 'screens/onboarding/questionnaires/SetNotificationScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init(); //
  await Hive.initFlutter();
  Hive.registerAdapter(phqHiveAdapter());
  await Hive.openBox('phq');
  Hive.registerAdapter(sidasHiveAdapter());
  await Hive.openBox('sidas');
  Hive.registerAdapter(DailyHiveAdapter());
  await Hive.openBox<DailyHive>('daily');
  Hive.registerAdapter(EmotionEntryHiveAdapter());
  await Hive.openBox<EmotionEntryHive>('emotion');
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
    return GetMaterialApp(
        title: 'Kasiyanna App',
        initialRoute: '/homepage',
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
              name: '/assessPHQScreen',
              page: () => const InitialAssessmentPHQ9Screen()),
          GetPage(name: '/phqScreen', page: () => const PHQ9Screen()),
          GetPage(
              name: '/loadingScreen', page: () => const LoadingResultsScreen()),
          GetPage(
              name: '/assessSIDASScreen',
              page: () => const InitialAssessmentSIDASScreen()),
          GetPage(name: '/sidasScreen', page: () => const SIDASScreen()),
          GetPage(
              name: '/interpretationScreen',
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

          //SideMenu
          GetPage(
              name: '/MentalHealthOnlineScreen',
              page: () => const MentalHealthOnlineScreen()),

          // wellness exercises
          GetPage(
              name: '/wellnessScreen',
              page: () => const WellnessExercisesScreen()),
          GetPage(
              name: '/emotionStartScreen',
              page: () => const EmotionalEvaluationStartScreen()),
          GetPage(
              name: '/emotionEndScreen',
              page: () => const EmotionalEvaluationEndScreen()),

          //calendar
          GetPage(name: '/calendarScreen', page: () => const CalendarScreen()),

          // entries detail
          GetPage(name: '/entriesScreen', page: () => const EntriesScreen()),
          GetPage(
              name: '/entriesDetailScreen',
              page: () => const EntriesDetailScreen()),

          // Sidebar pages
          GetPage(
              name: '/userProfileScreen',
              page: () => const UserProfileScreen()),
          GetPage(
              name: '/userProfileNamesScreen',
              page: () => const UserProfileNamesScreen()),
        ],
        theme: themeData,
        home:
            //change to screen checking log-in persisence
            (isLoggedIn) ? const HomePageScreen() : const IntroductionScreen());
  }
}

final ThemeData themeData = ThemeData(
  fontFamily: 'Proxima Nova',
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 68.0),
    headline2: TextStyle(
      fontSize: 56.0,
    ),
    headline3: TextStyle(
      fontSize: 46.0,
    ),
    headline4: TextStyle(
      fontSize: 38.0,
    ),
    headline5: TextStyle(
      fontSize: 30.0,
    ),
    subtitle1: TextStyle(
      fontSize: 24.0,
    ),
    subtitle2: TextStyle(
      fontSize: 20.0,
    ),
    bodyText1: TextStyle(
      fontSize: 16.0,
    ),
    bodyText2: TextStyle(
      fontSize: 14.0,
    ),
    caption: TextStyle(
      fontSize: 12.0,
    ),
  ),
  backgroundColor: const Color(0xffF2F6F7),
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff1BBCB6),
      onPrimary: Color(0xffFFFFFF),
      secondary: Color(0xff3FCD67),
      onSecondary: Color(0xffFFFFFF),
      error: Color(0xffB22428),
      onError: Color(0xffFFFFFF),
      background: Color(0xffF2F6F7),
      onBackground: Color(0xff161818),
      surface: Color(0xffFFFFFF),
      onSurface: Color(0xff161818)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      primary: Colors.green[400],
      padding: const EdgeInsets.all(10),
    ),
  ),
  buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
);
