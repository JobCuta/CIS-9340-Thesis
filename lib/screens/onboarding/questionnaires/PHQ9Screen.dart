import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'PHQ9Interpretation.dart';
import 'EmotionalEvaluationScreen.dart';
import 'InitialAssessmentScreen.dart';

class PHQ9Screen extends StatefulWidget {
  PHQ9Screen({Key? key}) : super(key: key);

  @override
  _PHQ9ScreenState createState() => _PHQ9ScreenState();
}

class _PHQ9ScreenState extends State<PHQ9Screen> {
  final PageController _pageController = PageController();

  var options = [
    'Pick an option',
    'Nearly every day',
    'More than half the days',
    'Several days',
    'Not at all'
  ];

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
    'assets/images/PHQ9_1.png',
    'assets/images/PHQ9_2.png',
    'assets/images/PHQ9_3.png',
    'assets/images/PHQ9_4.png',
    'assets/images/PHQ9_5.png',
    'assets/images/PHQ9_6.png',
    'assets/images/PHQ9_7.png',
    'assets/images/PHQ9_8.png',
    'assets/images/PHQ9_9.png'
  ];

  // corresponding values for the user's answers
  final List<int> answerValues = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
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
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: StepProgressIndicator(
                    totalSteps: questions.length,
                    currentStep: position + 1,
                    selectedColor: Colors.white,
                    unselectedColor: const Color(0xff004479),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                child: Center(
                    child: Wrap(alignment: WrapAlignment.center, runSpacing: 20,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      // PHQ9 Questions
                      Image(
                          width: 200,
                          height: 200,
                          image: AssetImage(assetImages[position])),
                      Container(
                        // height: 100,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 14.0),
                        decoration: BoxDecoration(
                            color: const Color(0xff3290FF).withOpacity(0.60),
                            // border: Border.all(color: Colors.black38, width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: Center(
                          child: Text(questions[position],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20)),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: Container(),
                            hint: const Text('Pick an option'),
                            value: answers[position],
                            icon: const Icon(Icons.keyboard_arrow_down),
                            onChanged: (String? newValue) {
                              print(position);
                              setState(() {
                                //  stores the value selected by the user so they can view their previous choices when they go back
                                answers[position] = newValue ?? "";
                                // stores the equivalent value based on the user's answer to the question
                                answerValues[position] = (newValue ==
                                        'Nearly every day')
                                    ? 3
                                    : (newValue == 'More than half the days')
                                        ? 2
                                        : (newValue == 'Several days')
                                            ? 1
                                            : 0;
                                // for verification that this is working correctly
                                print(answers);
                                print(answerValues);
                              });
                            },
                            items: options.map((String items) {
                              return DropdownMenuItem(
                                  value: items, child: Text(items));
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
                              child: const Text(
                                'Previous',
                                style: TextStyle(
                                    color: Color(0xffFFBE18),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.all(10),
                                primary: Colors.white,
                              ),
                              onPressed: () {
                                (position == 0)
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const GetMaterialApp(
                                                    home:
                                                        InitialAssessmentScreen())))
                                    : _pageController.jumpToPage(position - 1);
                              }),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.all(10),
                                primary: (answers[position] == 'Pick an option')
                                    ? const Color(0xffE2E4E4)
                                    : const Color(0xffFFBE18),
                              ),
                              onPressed: () {
                                (position == questions.length - 1)
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GetMaterialApp(
                                                    home:
                                                        PHQ9InterpretationScreen(
                                                  sum: answerValues.fold(
                                                      0,
                                                      (prev, current) =>
                                                          prev + current),
                                                ))))

                                    // Leads to EmotionalEvaluationScreen
                                    // ? Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const GetMaterialApp(
                                    //                 home:
                                    //                     EmotionalEvaluationScreen(
                                    //               initialAssessment: true,
                                    //             ))))

                                    // Checks if the user selected a valid value
                                    : (answers[position] == 'Pick an option')
                                        ? null
                                        : _pageController
                                            .jumpToPage(position + 1);
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
