import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

void main() {
  runApp(const MaterialApp(home: PHQ9()));
}

class PHQ9 extends StatefulWidget {
  const PHQ9({Key? key}) : super(key: key);

  @override
  _PHQ9State createState() => _PHQ9State();
}

class _PHQ9State extends State<PHQ9> {
  final PageController _pageController = PageController();

  // Currently can't figure out how to display the hint text (Pick an option) with the current implementation
  // thus 'Pick an option' was added as an option (countermeasure added to ensure the user cannot proceed unless they choose a different option)
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

  // corresponding values for the user's answers
  final List<int> answerValues = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
            // NeverScrollableScrollPhysics to ensure the user can only navigate through the pageviews with the expected interactions
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: questions.length + 1,
            itemBuilder: (context, position) {
              return Stack(children: [
                Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/green_background.png',
                            ),
                            fit: BoxFit.cover))),
                // Keeps the StepProgressIndicator in the same spot
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      Visibility(
                        visible: position > 0,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: StepProgressIndicator(
                            totalSteps: 12,
                            currentStep: position,
                            selectedColor: Colors.white,
                            unselectedColor: const Color(0xffA6F4EF),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (position == 0)
                              //First page of the Page View
                              ? Wrap(
                                  runSpacing: 30,
                                  alignment: WrapAlignment.center,
                                  children: const [
                                      Text(
                                          "We're going to ask you X questions about mental health",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          'The questions will be about yourself, how you go through with and your physical well-being...',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14)),
                                      Text(
                                          'Feedback will be given right after.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          )),
                                    ])
                              // PHQ9 Questions
                              : Wrap(
                                  runSpacing: 50,
                                  alignment: WrapAlignment.center,
                                  children: [
                                      const SizedBox(height: 50),
                                      // Temporary placeholder image
                                      const Image(
                                          width: 200,
                                          height: 200,
                                          image: AssetImage(
                                              'assets/images/splash.png')),
                                      Text(questions[position - 1],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 26)),
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30.0, right: 30.0),
                                          child: DropdownButton(
                                            isExpanded: true,
                                            underline: Container(),
                                            hint: const Text('Pick an option'),
                                            value: answers[position - 1],
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                //  stores the value selected by the user so they can view their previous choices when they go back
                                                answers[position - 1] =
                                                    newValue ?? "";
                                                // stores the equivalent value based on the user's answer to the question
                                                answerValues[
                                                    position - 1] = (newValue ==
                                                        'Nearly every day')
                                                    ? 3
                                                    : (newValue ==
                                                            'More than half the days')
                                                        ? 2
                                                        : (newValue ==
                                                                'Several days')
                                                            ? 1
                                                            : 0;
                                                // for verification that this is working correctly
                                                print(answers);
                                                print(answerValues);
                                              });
                                            },
                                            items: options.map((String items) {
                                              return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items));
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(
                                      // height: 100,
                                      // )
                                    ]),
                        ])),
                // Bottombar
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: (position == 0)
                          // Next button in the 1st page
                          ? SizedBox(
                              width: 328,
                              height: 50,
                              child: ElevatedButton(
                                  child: const Text('Next',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    primary: const Color(0xff34B8AE),
                                  ),
                                  onPressed: () {
                                    _pageController.jumpToPage(1);
                                  }),
                            )
                          // Navigation buttons for the questions
                          : Row(children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                      child: const Text(
                                        'Previous',
                                        style: TextStyle(
                                            color: Color(0xff3FCD67),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 1.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        primary: Colors.white,
                                      ),
                                      onPressed: () {
                                        _pageController
                                            .jumpToPage(position - 1);
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
                                        elevation: 1.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        primary: (answers[position - 1] ==
                                                'Pick an option')
                                            ? const Color(0xffE2E4E4)
                                            : const Color(0xff3FCD67),
                                      ),
                                      onPressed: () {
                                        (position == questions.length)
                                            ? ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Placeholder, End of PHQ9'),
                                              ))
                                            // Checks if the user selected a valid value
                                            : (answers[position - 1] ==
                                                    'Pick an option')
                                                ? null
                                                : _pageController
                                                    .jumpToPage(position + 1);
                                      }),
                                ),
                              ),
                            ])),
                )
              ]);
            }));
  }
}
