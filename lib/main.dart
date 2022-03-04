import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/onboarding/login_registration/AnonymousScreen.dart';
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

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kasiyanna App',
      initialRoute: '/',
      getPages: [
        //intro
        GetPage(name: '/introScreen', page: () => const IntroductionScreen()),
        GetPage(name: '/shakeScreen', page: () => const ShakeScreen()),
        GetPage(name: '/exerciseScreen', page: () => ExerciseScreen()),
        //login_registration
        GetPage(
            name: '/accountScreen', page: () => const CreateAccountScreen()),
        GetPage(name: '/aboutSelfScreen', page: () => const AboutSelfScreen()),
        GetPage(name: '/anonScreen', page: () => const AnonymousScreen()),
        GetPage(
            name: '/forgotScreen', page: () => const ForgotPasswordScreen()),
        //questionnaires
        GetPage(
            name: '/assessScreen', page: () => const InitialAssessmentScreen()),
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
      ],
      home:
          const IntroductionScreen(), //change to screen checking log-in persisence
    );
  }
}
