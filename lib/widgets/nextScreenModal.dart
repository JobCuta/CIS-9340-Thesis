import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/onboarding/questionnaires/OnBoardingScoresScreen.dart';
import 'package:flutter_application_1/constants/colors.dart';

import 'package:get/get.dart';
import 'dart:async';

void main() => runApp(const nextScreenModal());

class nextScreenModal extends StatelessWidget {
  const nextScreenModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const nextScreenModalWidget();
}

class nextScreenModalWidget extends StatefulWidget {
  const nextScreenModalWidget({Key? key}) : super(key: key);

  @override
  State<nextScreenModalWidget> createState() => _nextScreenModalState();
}

class _nextScreenModalState extends State<nextScreenModalWidget> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() => Get.off(const OnBoardingScoresScreen(),
      arguments: {'type': Get.arguments['type']},
      transition: Transition.fadeIn,
      duration: const Duration(seconds: 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        heightFactor: MediaQuery.of(context).size.height,
        widthFactor: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 145.0,
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset(
                  'assets/images/flower_filled.png',
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                Get.arguments['type'] == 'phq9'
                    ? 'Your results for your PHQ-9 Assessment is ready!'
                    : Get.arguments['type'] == 'sidas'
                        ? 'Your results for your SIDAS Assessment is ready!'
                        : 'Your results for your first evaluation is ready!',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.neutralGray04),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
