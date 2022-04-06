import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:percent_indicator/percent_indicator.dart';

import 'package:flutter_application_1/constants/colors.dart';

import '../../../apis/phqHive.dart';
import '../../../apis/sidasHive.dart';

import '../../../controllers/phqController.dart';
import '../../../controllers/sidasController.dart';

class PHQ9InterpretationScreen extends StatefulWidget {
  PHQ9InterpretationScreen({Key? key}) : super(key: key);

  @override
  _PHQ9InterpretationScreenState createState() =>
      _PHQ9InterpretationScreenState();
}

class _PHQ9InterpretationScreenState extends State<PHQ9InterpretationScreen> {
  final PHQController _phqController = Get.put(PHQController());
  final SIDASController _sidasController = Get.put(SIDASController());

  //to save data locally to hive
  void addToPhqHive(List<int> answerValues, int sum) async {
    var box = await Hive.openBox('phq');
    var newPhq =
        phqHive(date: DateTime.now(), answerValues: answerValues, sum: sum);
    box.add(newPhq);

    //Output values inside hive into terminal in the last index
    // var last_entry = box.toMap().length - 1;
    // print('PHQ9');
    // print(box.getAt(last_entry).date.toString());
    // print(box.getAt(last_entry).answerValues.toString());
    // print(box.getAt(last_entry).sum.toString());
  }

  void addToSidasHive(List<int> answerValues, int sum) async {
    var box = await Hive.openBox('sidas');
    var newSidas =
        sidasHive(date: DateTime.now(), answerValues: answerValues, sum: sum);
    box.add(newSidas);

    //Output values inside hive into terminal in the last index
    // var last_entry = box.toMap().length - 1;
    // print('SIDAS');
    // print(box.getAt(last_entry).date.toString());
    // print(box.getAt(last_entry).answerValues.toString());
    // print(box.getAt(last_entry).sum.toString());
  }

  @override
  Widget build(BuildContext context) {
    addToPhqHive(_phqController.answerValues, _phqController.sum);
    addToSidasHive(_sidasController.answerValues, _sidasController.sum);
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
            child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 100,
                runSpacing: 20,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                    child: Text(
                        'Here is your PHQ-9 and Suicidal Ideation Score',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).colorScheme.neutralWhite01)),
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
                              progressColor:
                                  Theme.of(context).colorScheme.neutralWhite01,
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
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            decoration: BoxDecoration(
                                color:
                                    const Color(0xffFFA132).withOpacity(0.60),
                                // border: Border.all(color: Colors.black38, width: 2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
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
                        Get.toNamed('/homepage');
                      }),
                )))
      ])),
    );
  }
}
