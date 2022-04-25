import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/apis/tableSecureStorage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:percent_indicator/percent_indicator.dart';

import 'package:flutter_application_1/constants/colors.dart';

import '../../../apis/phqHive.dart';
import '../../../apis/sidasHive.dart';

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

  // creating several DatTime.now() makes varying dates. Strictly use one for the same exact dates.
  DateTime now = DateTime.now();

  void savePhqEntry(List<int> answerValues, int sum) async {
    var box = Hive.box('phq');

    var entry = phqHive(index: -1, date: now, score: sum);

    String monthKey = now.month.toString() + '-' + now.year.toString();
    box.put(monthKey, entry);

    String title = '', sub = '';
    Map result = await UserProvider().createPHQ(entry);

    // Check results of saving entry online
    if (result["status"]) {
      entry.index = result["body"]["id"];

      title = 'PHQ9 Entry saved!';
      sub = 'Entry was saved to your profile';
    } else {
      title = 'PHQ9 Entry not saved';
      sub = 'There was a problem saving your entry online';
    }

    Get.snackbar(title, sub,
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white60, colorText: Colors.black87);
  }

  void saveSidasEntry(List<int> answerValues, int sum) async {
    var box = Hive.box('sidas');
    sidasHive entry = sidasHive(
      answerValues: _sidasController.answerValues,
      date: now,
      index: -1,
      score: _sidasController.sum,
    );

    String monthKey = now.month.toString() + '-' + now.year.toString();
    box.put(monthKey, entry);

    String title = '', sub = '';
    Map result = await UserProvider().createSIDAS(entry);

    // Check results of saving entry online
    if (result["status"]) {
      entry.index = result["body"]["id"];

      title = 'SIDAS Entry saved!';
      sub = 'Entry was saved to your profile';
    } else {
      title = 'SIDAS Entry not saved';
      sub = 'There was a problem saving your entry online';
    }

    Get.snackbar(title, sub,
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white60, colorText: Colors.black87);
  }

  @override
  void initState() {
    super.initState();
    savePhqEntry(_phqController.answerValues, _phqController.sum);
    saveSidasEntry(_sidasController.answerValues, _sidasController.sum);

    TableSecureStorage.setLatestPHQ(now.toUtc().toString());
    TableSecureStorage.setLatestSIDAS(now.toUtc().toString());
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
        Container(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 25),
            child: Wrap(alignment: WrapAlignment.center, spacing: 100, runSpacing: 20, children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                child: Text('Here is your PHQ-9 and Suicidal Ideation Score',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Wrap(
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      Text.rich(TextSpan(children: <InlineSpan>[
                        TextSpan(
                            text: _phqController.sum.toString(),
                            style: TextStyle(
                                fontSize: 64,
                                fontFamily: 'Inconsolata',
                                color: Theme.of(context).colorScheme.neutralWhite01)),
                        TextSpan(
                            text: '/27',
                            style: TextStyle(
                                fontSize: 64,
                                fontFamily: 'Inconsolata',
                                color: Theme.of(context).colorScheme.sunflowerYellow04))
                      ])),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: LinearPercentIndicator(
                          barRadius: const Radius.circular(4),
                          lineHeight: 20,
                          percent: _phqController.sum / 27,
                          progressColor: Theme.of(context).colorScheme.neutralWhite01,
                          backgroundColor: Theme.of(context).colorScheme.sunflowerYellow03,
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
                          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)),
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Wrap(
                            runSpacing: 10,
                            alignment: WrapAlignment.center,
                            children: [
                              Text.rich(TextSpan(children: <InlineSpan>[
                                TextSpan(
                                    text: _sidasController.sum.toString(),
                                    style: TextStyle(
                                        fontSize: 64,
                                        fontFamily: 'Inconsolata',
                                        color: Theme.of(context).colorScheme.neutralWhite01)),
                                TextSpan(
                                    text: '/50',
                                    style: TextStyle(
                                        fontSize: 64,
                                        fontFamily: 'Inconsolata',
                                        color: Theme.of(context).colorScheme.sunflowerYellow04))
                              ])),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: LinearPercentIndicator(
                                  barRadius: const Radius.circular(4),
                                  lineHeight: 20,
                                  percent: _sidasController.sum / 50,
                                  progressColor: Theme.of(context).colorScheme.neutralWhite01,
                                  backgroundColor: Theme.of(context).colorScheme.sunflowerYellow03,
                                ),
                              ),
                              Text(_sidasController.sum >= 21 ? 'High Suicidal Ideation' : 'Low Suicidal Ideation',
                                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).colorScheme.neutralWhite01)),
                            ],
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                            color: const Color(0xffFFA132).withOpacity(0.60),
                            // border: Border.all(color: Colors.black38, width: 2),
                            borderRadius: const BorderRadius.all(Radius.circular(8))),
                        child: Center(
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
                              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                  fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.neutralWhite01)),
                        ),
                      ),
                    ],
                  )),
            ])),
        Container(
            padding: const EdgeInsets.all(16),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                      child: Text('Take me to Kasiyanna',
                          style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Theme.of(context).colorScheme.accentBlue02,
                      ),
                      onPressed: () {
                        _phqController.dispose();
                        _sidasController.dispose();
                        Get.toNamed('/homepage');
                      }),
                )))
      ])),
    );
  }
}
