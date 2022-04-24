import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/apis/sidasHive.dart';
import 'package:flutter_application_1/apis/tableSecureStorage.dart';
import 'package:flutter_application_1/controllers/emotionController.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../controllers/sidasController.dart';

class SIDASScreen extends StatefulWidget {
  const SIDASScreen({Key? key, bool? initialAssessment}) : super(key: key);

  @override
  _SIDASScreenState createState() => _SIDASScreenState();
}

class _SIDASScreenState extends State<SIDASScreen> {
  final PageController _pageController = PageController();

  // SIDAS Questions
  final List<String> questions = [
    'In the past month, how often have you had thoughts about suicide?',
    'In the past month, how much control have you had over these thoughts?',
    'In the past month, how close have you come to making a suicide attempt?',
    'In the past month, to what extent have you felt tormented by thoughts about suicide?',
    'In the past month, how much have thoughts about suicide interfered with your ability to carry out daily activities, such as work, household tasks or social activies?',
  ];

  final List<String> answer_guide = [
    '(0 = Never, 10 = Always)',
    '(0 = No Control, 10 = Full Control)',
    '(0 = Not close at all, 10 = Made an attempt)',
    '(0 = Not at all, 10 = Extremely)',
    '(0 = Not at all, 10 = Extremely)',
  ];

  final List<String> zero_string = [
    '0 = Never',
    '0 = No Control',
    '0 = Not close at all',
    '0 = Not at all',
    '0 = Not at all',
  ];

  final SIDASController _sidasController = Get.put(SIDASController());
  final EmotionController _emotionController = Get.put(EmotionController());

  saveEntries() async {
    Box box = Hive.box('sidas');
    sidasHive assessMonth = box.get(Get.arguments["key"]);

    assessMonth.score = _sidasController.sum;
    assessMonth.save();

    DateTime nextMonth = DateTime.utc(assessMonth.date.year, assessMonth.date.month, assessMonth.date.day);
    sidasHive nextSidas = sidasHive(index: -1, score: -1, date: nextMonth, answerValues: []);
    String key = nextSidas.date.month.toString() + '-' + nextSidas.date.year.toString();

    box.put(key, nextSidas);

    String title = '', sub = '';
    bool result = await UserProvider().updateSIDAS(_sidasController.sum, assessMonth.index.toString());
    Map result2 = await UserProvider().createSIDAS(nextSidas);

    // Check results of saving entry online
    if (result && result2["status"]) {
      nextSidas.index = result2["body"]["id"];

      title = 'SIDAS Entry saved!';
      sub = 'Entry was saved to your profile';
    } else {
      title = 'SIDAS Entry not saved';
      sub = 'There was a problem saving your entry online';
    }

    Get.snackbar(title, sub,
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white60, colorText: Colors.black87);
  }

  checkIfOnboarding() {
    if (Get.arguments != null) {
      log('look im saving an entry');
      saveEntries();
      TableSecureStorage.setLatestSIDAS(DateTime.now().toUtc().toString());
      Get.offAndToNamed(Get.arguments["home"]);
    } else {
      Get.toNamed('/assessSIDASScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    buildItem(position, initial, reversed, color) {
      return Expanded(
        child: InkWell(
            onTap: () {
              _sidasController.updateValues(position, (position != 1) ? initial : reversed);
            },
            child: Container(
                alignment: Alignment.center,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: position != 1
                            ? _sidasController.answerValues[position] == initial
                                ? Theme.of(context).colorScheme.neutralWhite01
                                : Colors.transparent
                            : _sidasController.answerValues[position] == reversed
                                ? Theme.of(context).colorScheme.neutralWhite01
                                : Colors.transparent,
                        width: 4),
                    color: color),
                child: Text(initial.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Theme.of(context).colorScheme.neutralWhite01, fontWeight: FontWeight.w600)))),
      );
    }

    return Scaffold(
      body: PageView.builder(
          // NeverScrollableScrollPhysics to ensure the user can only navigate through the pageviews with the expected interactions
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemCount: questions.length,
          itemBuilder: (context, position) {
            return Stack(children: [
              Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/background_images/blue_background.png',
                          ),
                          fit: BoxFit.cover))),
              // Keeps the StepProgressIndicator in the same spot
              Container(
                padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: StepProgressIndicator(
                    selectedSize: 8.0,
                    unselectedSize: 8.0,
                    roundedEdges: const Radius.circular(4),
                    totalSteps: questions.length,
                    currentStep: position + 1,
                    selectedColor: Theme.of(context).colorScheme.neutralWhite01,
                    unselectedColor: const Color(0xffA1D6FF),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Center(
                    child: Wrap(alignment: WrapAlignment.center, runSpacing: 20, children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                    padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                        color: const Color(0xff3290FF).withOpacity(0.60),
                        borderRadius: const BorderRadius.all(Radius.circular(8))),
                    child: Wrap(alignment: WrapAlignment.center, runSpacing: 20, children: [
                      Text(questions[position],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)),
                      Text(answer_guide[position],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.neutralWhite01))
                    ]),
                  ),
                  GetBuilder<SIDASController>(
                    builder: (value) => Row(children: [
                      buildItem(position, 0, 10, const Color(0xffFFB762)),
                      buildItem(position, 1, 9, const Color(0xffFFAE50)),
                      buildItem(position, 2, 8, const Color(0xffFFA236)),
                      buildItem(position, 3, 7, const Color(0xffFF8A00)),
                      buildItem(position, 4, 6, const Color(0xffFF7A00)),
                      buildItem(position, 5, 5, const Color(0xffFF6B00)),
                      buildItem(position, 6, 4, const Color(0xffFF7A00)),
                      buildItem(position, 7, 3, const Color(0xffFF8A00)),
                      buildItem(position, 8, 2, const Color(0xffFFA236)),
                      buildItem(position, 9, 1, const Color(0xffFFAE50)),
                      buildItem(position, 10, 0, const Color(0xffFFB762)),
                    ]),
                  )
                ])),
              ),
              // Bottombar
              Container(
                padding: const EdgeInsets.all(20),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              child: Text(
                                'Previous',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(color: const Color(0xffFFBE18), fontWeight: FontWeight.w600),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.all(10),
                                primary: Theme.of(context).colorScheme.neutralWhite01,
                              ),
                              onPressed: () {
                                (position == 0)
                                    ? Get.toNamed('/assessSIDASScreen')
                                    : _pageController.jumpToPage(position - 1);
                              }),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              child: Text(
                                'Next',
                                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: Theme.of(context).colorScheme.neutralWhite01, fontWeight: FontWeight.w600),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: const Color(0xffFFBE18),
                              ),
                              onPressed: () {
                                if (position == questions.length - 1) {
                                  _emotionController.updateIfAddingFromOnboarding(true);
                                  Get.toNamed('/emotionStartScreen');
                                } else {
                                  // Checks if the user selected a valid value
                                  _pageController.jumpToPage(position + 1);
                                }
                              }),
                        ),
                      ),
                    ])),
              ),
            ]);
          }),
    );
  }
}
