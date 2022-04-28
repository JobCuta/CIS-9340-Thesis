import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:percent_indicator/percent_indicator.dart';

import 'package:flutter_application_1/constants/colors.dart';

import '../../../controllers/phqController.dart';
import '../../../controllers/sidasController.dart';

class OnBoardingScoresScreen extends StatefulWidget {
  const OnBoardingScoresScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScoresScreenState createState() => _OnBoardingScoresScreenState();
}

class _OnBoardingScoresScreenState extends State<OnBoardingScoresScreen> {
  final PHQController _phqController = Get.put(PHQController());
  final SIDASController _sidasController = Get.put(SIDASController());
  var type = Get.arguments['type'];

  @override
  void initState() {
    super.initState();
    if (type == 'both') {
      _phqController.saveEntries();
      _sidasController.saveEntries();
    } else if (type == 'phq9') {
      _phqController.saveEntries();
    } else {
      _sidasController.saveEntries();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Stack(alignment: AlignmentDirectional.topCenter, children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/background_images/orange_gradient_background.png',
                    ),
                    fit: BoxFit.cover))),
        SafeArea(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 25),
              child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 100,
                  runSpacing: 20,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 25),
                      child: Text(
                          type == 'both'
                              ? 'Here is your PHQ-9 and Suicidal Ideation Score'
                              : type == 'phq9'
                                  ? 'Here is your PHQ-9 Score'
                                  : 'Here is your Suicidal Ideation Score',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralWhite01)),
                    ),
                    Wrap(
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        Visibility(
                          visible: type == 'phq9' || type == 'both',
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Wrap(
                                alignment: WrapAlignment.center,
                                runSpacing: 10,
                                children: [
                                  Text.rich(TextSpan(children: <InlineSpan>[
                                    TextSpan(
                                        text: _phqController.sum.toString(),
                                        style: TextStyle(
                                            fontSize: 64,
                                            fontFamily: 'Inconsolata',
                                            color: Theme.of(context)
                                                .colorScheme
                                                .neutralWhite01)),
                                    TextSpan(
                                        text: '/27',
                                        style: TextStyle(
                                            fontSize: 64,
                                            fontFamily: 'Inconsolata',
                                            color: Theme.of(context)
                                                .colorScheme
                                                .sunflowerYellow04))
                                  ])),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: LinearPercentIndicator(
                                      barRadius: const Radius.circular(4),
                                      lineHeight: 20,
                                      percent: _phqController.sum / 27,
                                      progressColor: Theme.of(context)
                                          .colorScheme
                                          .neutralWhite01,
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .sunflowerYellow03,
                                    ),
                                  ),
                                  Text(
                                      _phqController.sum >= 20
                                          ? 'Severe Depression'
                                          : _phqController.sum >= 15
                                              ? 'Moderately Severe Depression'
                                              : _phqController.sum >= 10
                                                  ? 'Moderate Depression'
                                                  : _phqController.sum >= 5
                                                      ? 'Mild Depression'
                                                      : 'None - Minimal Depression',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .neutralWhite01)),
                                ]),
                          ),
                        ),
                        Visibility(
                          visible: type == 'sidas' || type == 'both',
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                runSpacing: 10,
                                children: [
                                  Text.rich(TextSpan(children: <InlineSpan>[
                                    TextSpan(
                                        text: _sidasController.sum.toString(),
                                        style: TextStyle(
                                            fontSize: 64,
                                            fontFamily: 'Inconsolata',
                                            color: Theme.of(context)
                                                .colorScheme
                                                .neutralWhite01)),
                                    TextSpan(
                                        text: '/50',
                                        style: TextStyle(
                                            fontSize: 64,
                                            fontFamily: 'Inconsolata',
                                            color: Theme.of(context)
                                                .colorScheme
                                                .sunflowerYellow04))
                                  ])),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: LinearPercentIndicator(
                                      barRadius: const Radius.circular(4),
                                      lineHeight: 20,
                                      percent: _sidasController.sum / 50,
                                      progressColor: Theme.of(context)
                                          .colorScheme
                                          .neutralWhite01,
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .sunflowerYellow03,
                                    ),
                                  ),
                                  Text(
                                      _sidasController.sum >= 21
                                          ? 'High Suicidal Ideation'
                                          : 'Low Suicidal Ideation',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .neutralWhite01)),
                                ],
                              )),
                        ),
                        Visibility(
                          visible: type == 'phq9' || type == 'both',
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            decoration: BoxDecoration(
                                color:
                                    const Color(0xffFFA132).withOpacity(0.60),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: Text(
                                _phqController.sum >= 20
                                    ? 'Immediate initiation of pharmacotherapy and, if severe impairment or poor response to therapy, expedited referral to a mental health specialist for psychotherapy and/or collaborative management'
                                    : _phqController.sum >= 15
                                        ? 'Active treatment with pharmacotherapy and/or psychotherapy'
                                        : _phqController.sum >= 10
                                            ? 'Treatment plan, considering counseling, follow-up and/or pharmacotherapy'
                                            : _phqController.sum >= 5
                                                ? 'Watchful waiting; repeat PHQ-9 at follow-up'
                                                : 'None',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralWhite01)),
                          ),
                        ),
                      ],
                    ),
                  ])),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                      child: Text(
                          type == 'both'
                              ? 'Take me to Kasiyanna'
                              : 'Return to homepage',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralWhite01)),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Theme.of(context).colorScheme.accentBlue02,
                      ),
                      onPressed: () {
                        if (type == 'both') {
                          _phqController.dispose();
                          _sidasController.dispose();
                        } else if (type == 'phq9') {
                          _phqController.dispose();
                        } else {
                          _sidasController.dispose();
                        }
                        Get.toNamed('/homepage');
                      }),
                )))
      ])),
    );
  }
}
