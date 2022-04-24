import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/apis/phqHiveObject.dart';
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
    DateTime next = now.add(const Duration(days: 14));
    phqHive m1 = phqHive(assessments: []), m2 = phqHive(assessments: []);

    var newPhq = phqHiveObj(index: -1, date: now, score: sum);
    var nextPhq = phqHiveObj(index: -1, date: next, score: -1);

    if (now.month == next.month) {
      var phqMonth = phqHive(assessments: [newPhq, nextPhq]);
      String monthKey = now.month.toString() + '-' + now.year.toString();
      box.put(monthKey, phqMonth);
    } else {
      m1.assessments.add(newPhq);
      m2.assessments.add(nextPhq);

      String m1Key = now.month.toString() + '-' + now.year.toString();
      String m2Key = next.month.toString() + '-' + next.year.toString();

      box.put(m1Key, m1);
      box.put(m2Key, m2);
    }

    String title = '', sub = '';
    Map result = await UserProvider().createPHQ(newPhq);
    Map result2 = await UserProvider().createPHQ(nextPhq);

    // Check results of saving entry online
    if (result["status"] && result2["status"]) {
      newPhq.index = result["body"]["id"];
      nextPhq.index = result["body"]["id"];

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

    DateTime n1D = now, n2D = DateTime(now.year, now.month + 1, now.day);

    var newSidas = sidasHive(index: -1, date: n1D, answerValues: answerValues, score: sum);
    var nextSidas = sidasHive(index: -1, date: n2D, answerValues: [], score: -1);

    box.put(n1D.month.toString() + '-' + n1D.year.toString(), newSidas);
    box.put(n2D.month.toString() + '-' + n2D.year.toString(), nextSidas);

    // Attempt to save entry online
    String title = '', sub = '';
    Map result = await UserProvider().createSIDAS(newSidas);
    Map result2 = await UserProvider().createSIDAS(nextSidas);

    // Check results of saving entry online
    if (result["status"] && result2["status"]) {
      newSidas.index = result["body"]["id"];
      nextSidas.index = result2["body"]["id"];

      title = 'SIDAS Entry saved!';
      sub = 'Entry was saved to your profile';
    } else {
      title = 'SIDAS Entry not saved';
      sub = 'There was a problem saving your entry online';
    }

    Get.snackbar(title, sub,
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white60, colorText: Colors.black87);

    // Update latest change of SIDAS storage
    TableSecureStorage.setLatestSIDAS(DateTime.now().toUtc().toString());
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
