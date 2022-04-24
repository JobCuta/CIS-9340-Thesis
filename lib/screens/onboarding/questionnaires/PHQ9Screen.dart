import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/apis/phqHive.dart';
import 'package:flutter_application_1/apis/phqHiveObject.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:hive/hive.dart';

import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../controllers/phqController.dart';

class PHQ9Screen extends StatefulWidget {
  const PHQ9Screen({Key? key, bool? initialAssessment}) : super(key: key);

  @override
  _PHQ9ScreenState createState() => _PHQ9ScreenState();
}

class _PHQ9ScreenState extends State<PHQ9Screen> {
  final PageController _pageController = PageController();

  var options = ['Pick an option', 'Nearly every day', 'More than half the days', 'Several days', 'Not at all'];

  // PHQ9 Questions
  final List<String> questions = [
    'Little interest or pleasure in doing things',
    'Feeling down, depressed, or hopeless',
    'Trouble falling or staying asleep, or sleeping too much',
    'Feeling tired or having little energy',
    'Poor Appetite or overeating',
    'Feeling bad about yourself or thinking you are a failure',
    'Trouble concentrating on things',
    'Moving or speaking so slowly that other people could have noticed or feeling fidgety/restless?',
    'Thoughts that you would be better off dead or of hurting yourself in some way'
  ];

  // Default user answers
  final List<String> answers = [
    'Pick an option',
    'Pick an option',
    'Pick an option',
    'Pick an option',
    'Pick an option',
    'Pick an option',
    'Pick an option',
    'Pick an option',
    'Pick an option'
  ];

  final List<String> assetImages = [
    'assets/images/PHQ9_1.svg',
    'assets/images/PHQ9_2.svg',
    'assets/images/PHQ9_3.svg',
    'assets/images/PHQ9_4.svg',
    'assets/images/PHQ9_5.svg',
    'assets/images/PHQ9_6.svg',
    'assets/images/PHQ9_7.svg',
    'assets/images/PHQ9_8.svg',
    'assets/images/PHQ9_9.svg'
  ];

  final PHQController _phqController = Get.put(PHQController());

  @override
  Widget build(BuildContext context) {

    /// Save PHQ score on both Hive and Backend
    saveEntries() async {
      var box = Hive.box('phq');
      phqHive assessMonth = box.get(Get.arguments["key"]);

      // update previously made entry's score
      assessMonth.assessments.first.score = _phqController.sum;
      assessMonth.save();

      // create a new entry for the next assessment
      int nextIndex = assessMonth.assessments.first.index + 1;
      var nextPhq = phqHiveObj( 
        index: nextIndex, 
        date: assessMonth.assessments.first.date.add(const Duration(days: 14)), 
        score: -1
      );

      if (assessMonth.assessments.first.date.month == nextPhq.date.month) {
        assessMonth.assessments.add(nextPhq);
        assessMonth.save();
      } else {
        var newMonth = phqHive(assessments: [nextPhq]);
        String monthKey = nextPhq.date.month.toString() + '-' + nextPhq.date.year.toString();
        box.put(monthKey, newMonth);
      }

      String title = '', sub = '';
      bool result = await UserProvider().updatePHQ(
        _phqController.sum,
        nextPhq.index.toString()
      );
      Map result2 = await UserProvider().createPHQ(nextPhq);

      // Check results of saving entry online
      if (result && result2["status"]) {
        nextPhq.index = result2["body"]["id"];
        
        title = 'PHQ9 Entry saved!';
        sub = 'Entry was saved to your profile';
      } else {
        title = 'PHQ9 Entry not saved';
        sub = 'There was a problem saving your entry online';
      }

      Get.snackbar(title, sub,
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white60, colorText: Colors.black87);
    }

    checkIfOnboarding() {
      if (Get.arguments != null) {
        log('look im saving an entry');
        saveEntries();
        // Get.offAndToNamed(Get.arguments["home"]);
      } else {
        Get.toNamed('/assessSIDASScreen');
      }
    }

    // Currently can't figure out how to display the hint text (Pick an option) with the current implementation
    // thus 'Pick an option' was added as an option (countermeasure added to ensure the user cannot proceed unless they choose a different option)
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
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                child: Center(
                    child: Wrap(alignment: WrapAlignment.center, runSpacing: 20,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      // PHQ9 Questions
                      SvgPicture.asset(
                        assetImages[position],
                        width: 200,
                        height: 200,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 14.0),
                        decoration: BoxDecoration(
                            color: const Color(0xff3290FF).withOpacity(0.60),
                            borderRadius: const BorderRadius.all(Radius.circular(8))),
                        child: Center(
                          child: Text(questions[position],
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).colorScheme.neutralWhite01,
                                  )),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.neutralWhite01,
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: DropdownButton(
                            dropdownColor: Theme.of(context).colorScheme.neutralWhite01,
                            isExpanded: true,
                            underline: Container(),
                            hint: const Text('Pick an option'),
                            value: answers[position],
                            icon: const Icon(Icons.keyboard_arrow_down),
                            onChanged: (String? newValue) {
                              setState(() {
                                //  stores the value selected by the user so they can view their previous choices when they go back
                                answers[position] = newValue ?? "";
                                // stores the equivalent value based on the user's answer to the question
                                _phqController.updateValues(
                                    position,
                                    (newValue == 'Nearly every day')
                                        ? 3
                                        : (newValue == 'More than half the days')
                                            ? 2
                                            : (newValue == 'Several days')
                                                ? 1
                                                : 0);
                              });
                            },
                            items: options.map((String items) {
                              return DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    items,
                                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).colorScheme.neutralGray04),
                                  ));
                            }).toList(),
                          ),
                        ),
                      ),
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
                                    ?.copyWith(fontWeight: FontWeight.w600, color: const Color(0xffFFBE18)),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Theme.of(context).colorScheme.neutralWhite01,
                              ),
                              onPressed: () {
                                (position == 0)
                                    ? Get.toNamed('/assessPHQScreen')
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
                                    fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: (answers[position] == 'Pick an option')
                                    ? Theme.of(context).colorScheme.neutralWhite04
                                    : const Color(0xffFFBE18),
                              ),
                              onPressed: () {
                                (position == questions.length - 1)
                                    ? checkIfOnboarding()
                                    // Checks if the user selected a valid value
                                    : (answers[position] == 'Pick an option')
                                        ? null
                                        : _pageController.jumpToPage(position + 1);
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
