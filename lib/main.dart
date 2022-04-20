import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/ContactDetails.dart';
import 'package:flutter_application_1/apis/CopingGame.dart';
import 'package:flutter_application_1/apis/Emotion.dart';
import 'package:flutter_application_1/apis/EmotionEntryDetail.dart';
import 'package:flutter_application_1/apis/Level.dart';
import 'package:flutter_application_1/apis/SudokuSettings.dart';
import 'package:flutter_application_1/apis/phqHiveObject.dart';
import 'package:flutter_application_1/controllers/copingController.dart';
import 'package:flutter_application_1/controllers/dailyController.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:flutter_application_1/controllers/hopeBoxController.dart';
import 'package:flutter_application_1/controllers/settingsController.dart';
import 'package:flutter_application_1/controllers/sudokuController.dart';
import 'package:flutter_application_1/screens/MiniGames/CopingGame/CopingGameScreen.dart';
import 'package:flutter_application_1/screens/MiniGames/MemoryGame/MemoryGameScreen.dart';
import 'package:flutter_application_1/screens/MiniGames/Sudoku/SudokuScreen.dart';
import 'package:flutter_application_1/screens/SideMenu/HopeBox/HopeBoxContactEditScreen.dart';
import 'package:flutter_application_1/screens/SideMenu/HopeBox/HopeBoxImagesScreen.dart';
import 'package:flutter_application_1/screens/SideMenu/HopeBox/HopeBoxRecordingsScreen.dart';
import 'package:flutter_application_1/screens/SideMenu/HopeBox/HopeBoxVideoPlayer.dart';
import 'package:flutter_application_1/screens/SideMenu/HopeBox/HopeBoxVideosScreen.dart';
import 'package:flutter_application_1/screens/SideMenu/MentalHealthOnline.dart';
import 'package:flutter_application_1/screens/SideMenu/StatisticsScreen.dart';
import 'package:flutter_application_1/screens/SideMenu/StatisticsSubPage/PHQScoreScreen.dart';
import 'package:flutter_application_1/screens/SideMenu/StatisticsSubPage/SIDASScoreScreen.dart';
import 'package:flutter_application_1/screens/SideMenu/UserProfile/UserProfileFrameScreen.dart';
import 'package:flutter_application_1/screens/main/ActivitiesGameScreen.dart';
//import 'package:flutter_application_1/screens/debug/HomepageScreen.dart';
import 'package:flutter_application_1/screens/main/AdventureHomeScreen.dart';
import 'package:flutter_application_1/screens/main/EmotionalEvaluationEndScreen.dart';
import 'package:flutter_application_1/screens/main/EmotionalEvaluationStartScreen.dart';
import 'package:flutter_application_1/screens/main/UserEngagementScaleScreen.dart';
import 'package:flutter_application_1/screens/main/UserJourney.dart';
import 'package:flutter_application_1/screens/main/WellnessExercisesScreen.dart';
import 'package:flutter_application_1/screens/onboarding/intro/SplashScreen.dart';
import 'package:flutter_application_1/screens/onboarding/login_registration/AnonymousScreen.dart';
import 'package:flutter_application_1/screens/onboarding/login_registration/LoginSplash.dart';
import 'apis/hopeBoxHive.dart';
import 'apis/hopeBoxObject.dart';
import 'apis/phqHive.dart';
import 'apis/settingsHive.dart';
import 'apis/sidasHive.dart';
import 'apis/dailyHive.dart';
import 'apis/emotionEntryHive.dart';
import 'constants/notificationService.dart';
import 'screens/SideMenu/HopeBox/HopeBoxContactScreen.dart';
import 'screens/SideMenu/HopeBox/HopeBoxContactSetupScreen.dart';
import 'screens/SideMenu/HopeBox/HopeBoxMainScreen.dart';
import 'screens/SideMenu/UserProfile/UserProfileAccountScreen.dart';
import 'screens/SideMenu/UserProfile/UserProfileContactSupportScreen.dart';
import 'screens/SideMenu/UserProfile/UserProfileDeactivateAccountScreen.dart';
import 'screens/SideMenu/UserProfile/UserProfileDeactivateSucessfulScreen.dart';
import 'screens/SideMenu/UserProfile/UserProfileEditScreen.dart';
import 'screens/SideMenu/UserProfile/UserProfileLanguageScreen.dart';
import 'screens/SideMenu/UserProfile/UserProfileNotificationsScreen.dart';
import 'screens/SideMenu/UserProfile/UserProfileScreen.dart';
import 'screens/main/EntriesDetailScreen.dart';
import 'screens/main/EntriesScreen.dart';
import 'screens/main/HomepageScreen.dart';
import 'screens/onboarding/intro/ShakeScreen.dart';
import 'screens/onboarding/intro/IntroductionScreen.dart';
import 'screens/onboarding/login_registration/AboutSelfScreen.dart';
import 'screens/onboarding/login_registration/CreateAccountScreen.dart';
import 'screens/onboarding/login_registration/ForgotPasswordScreen.dart';
import 'screens/main/CalendarScreen.dart';
import 'screens/onboarding/questionnaires/InitialAssessmentPHQ9Screen.dart';
import 'screens/onboarding/questionnaires/InitialAssessmentSIDASScreen.dart';
import 'screens/onboarding/questionnaires/LoadingResultsScreen.dart';
import 'screens/onboarding/questionnaires/PHQ9Interpretation.dart';
import 'screens/onboarding/questionnaires/PHQ9Screen.dart';
import 'screens/SideMenu/AchievementsScreen.dart';
import 'package:get/get.dart';
import 'screens/onboarding/questionnaires/SIDASScreen.dart';
import 'screens/onboarding/questionnaires/SetNotificationScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init(); //

  Hive.registerAdapter(sidasHiveAdapter());
  Hive.registerAdapter(phqHiveAdapter());
  Hive.registerAdapter(phqHiveObjAdapter());
  Hive.registerAdapter<DailyHive>(DailyHiveAdapter());
  Hive.registerAdapter<EmotionEntryHive>(EmotionEntryHiveAdapter());
  Hive.registerAdapter<EmotionEntryDetail>(EmotionEntryDetailAdapter());
  Hive.registerAdapter(EmotionAdapter());
  Hive.registerAdapter<Level>(LevelAdapter());
  Hive.registerAdapter(SettingsHiveAdapter());
  Hive.registerAdapter(HopeBoxAdapter());
  Hive.registerAdapter(HopeBoxObjectAdapter());
  Hive.registerAdapter(ContactDetailsAdapter());
  Hive.registerAdapter(SudokuSettingsAdapter());
  Hive.registerAdapter(CopingGameAdapter());

  await Hive.initFlutter();

  await Hive.openBox('phq');
  await Hive.openBox('sidas');
  await Hive.openBox<DailyHive>('daily');
  await Hive.openBox<EmotionEntryHive>('emotion');
  await Hive.openBox<EmotionEntryDetail>('emotionEntry');
  await Hive.openBox('emotionObj');
  await Hive.openBox<Level>('level');
  await Hive.openBox<SettingsHive>('settings');
  await Hive.openBox<HopeBox>('hopeBox');
  await Hive.openBox<HopeBoxObject>('hopeBoxObj');
  await Hive.openBox<ContactDetails>('contactPerson');
  await Hive.openBox<SudokuSettings>('sudokuBox');
  await Hive.openBox<CopingGame>('copingGame');

  final DailyController _dailyController = Get.put(DailyController());
  _dailyController.prepareTheObjects();

  final SettingsController _settingsController = Get.put(SettingsController());
  _settingsController.prepareTheObjects();

  final LevelController _levelController = Get.put(LevelController());
  _levelController.prepareTheObjects();
  final HopeBoxController _hopeBoxController = Get.put(HopeBoxController());
  _hopeBoxController.prepareTheObjects();

  final SudokuController _sudokuController = Get.put(SudokuController());
  _sudokuController.prepareTheObjects();

  final CopingController _copingController = Get.put(CopingController());
  _copingController.prepareTheObjects();

  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kasiyanna App',
      initialRoute: '/homepage',
      getPages: [
        // intro
        GetPage(name: '/introScreen', page: () => const IntroductionScreen()),
        GetPage(name: '/shakeScreen', page: () => ShakeScreen()),
        GetPage(name: '/exerciseScreen', page: () => ExerciseScreen()),

        // login_registration
        GetPage(
            name: '/accountScreen', page: () => const CreateAccountScreen()),
        GetPage(name: '/aboutSelfScreen', page: () => const AboutSelfScreen()),
        GetPage(name: '/anonScreen', page: () => const AnonymousScreen()),
        GetPage(
            name: '/forgotScreen', page: () => const ForgotPasswordScreen()),
        GetPage(name: '/loginSplashScreen', page: () => const LoadingSplash()),

        // questionnaires
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
            page: () => const PHQ9InterpretationScreen()),

        // notification
        GetPage(
            name: '/notifScreen', page: () => const SetNotificationScreen()),

        // main
        GetPage(name: '/homepage', page: () => HomePageScreen(2)),

        GetPage(
            name: '/adventureHome', page: () => const AdventureHomeScreen()),
        GetPage(name: '/userJourney', page: () => const UserJourneyScreen()),
        GetPage(
            name: '/ActivitiesGameScreen',
            page: () => const ActivitiesGameScreen()),

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

        // calendar
        GetPage(name: '/calendarScreen', page: () => const CalendarScreen()),

        // entries detail
        GetPage(name: '/entriesScreen', page: () => const EntriesScreen()),
        GetPage(
            name: '/entriesDetailScreen',
            page: () => const EntriesDetailScreen()),

        // Side Menu Screens
        // Profile pages
        GetPage(
            name: '/userProfileScreen', page: () => const UserProfileScreen()),
        GetPage(
            name: '/userProfileEditScreen',
            page: () => const UserProfileEditScreen()),
        GetPage(
            name: '/userProfileFrameScreen',
            page: () => const UserProfileFrameScreen()),
        GetPage(
            name: '/userProfileNotificationsScreen',
            page: () => const UserProfileNotificationsScreen()),
        GetPage(
            name: '/userProfileLanguageScreen',
            page: () => const UserProfileLanguageScreen()),
        GetPage(
            name: '/userProfileContactScreen',
            page: () => const UserProfileContactSupportScreen()),
        GetPage(
            name: '/userProfileAccountScreen',
            page: () => const UserProfileAccountScreen()),
        GetPage(
            name: '/userDeactivateAccountScreen',
            page: () => const UserProfileDeactivateAccountScreen()),
        GetPage(
            name: '/userDeactivateSuccessScreen',
            page: () => const UserProfileDeactivateSuccessfulScreen()),
        // Hope Box Pages
        GetPage(name: '/hopeBox', page: () => const HopeBoxMainScreen()),
        GetPage(
            name: '/hopeBoxImages', page: () => const HopeBoxImagesScreen()),
        GetPage(
            name: '/hopeBoxVideos', page: () => const HopeBoxVideosScreen()),
        GetPage(name: '/hopeBoxVideoPlayer', page: () => HopeBoxVideoPlayer()),
        GetPage(
            name: '/hopeBoxRecordings',
            page: () => const HopeBoxRecordingsScreen()),
        GetPage(
            name: '/hopeBoxContact', page: () => const HopeBoxContactScreen()),
        GetPage(
            name: '/hopeBoxContactSetup',
            page: () => const HopeBoxContactSetupScreen()),
        GetPage(
            name: '/hopeBoxContactEdit',
            page: () => const HopeBoxContactEditScreen()),
        // Achievements Page
        GetPage(
            name: '/achievementsScreen',
            page: () => const AchievementsScreen()),
        // Hotline Page
        GetPage(
            name: '/MentalHealthOnlineScreen',
            page: () => const MentalHealthOnlineScreen()),
        // Statistics Page
        GetPage(
            name: '/statisticsScreen', page: () => const StatisticsScreen()),
        GetPage(name: '/phqStatScreen', page: () => const PHQScoreScreen()),
        GetPage(name: '/sidasStatScreen', page: () => const SIDASScoreScreen()),
        // Minigames Screens
        GetPage(name: '/sudoku', page: () => SudokuScreen()),
        GetPage(name: '/copingGame', page: () => CopingGameScreen()),
        GetPage(
            name: '/memoryGameScreen', page: () => const MemoryGameScreen()),

        // User Engagement Scale
        GetPage(
            name: '/engagementScaleScreen',
            page: () => const UESFocusedAttentionScreen()),
      ],
      theme: themeData,
      // home: const Splash()
    );
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
