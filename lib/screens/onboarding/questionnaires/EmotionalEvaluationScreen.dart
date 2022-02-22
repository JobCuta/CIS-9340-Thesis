import 'package:flutter/material.dart';
// import 'package:flutter_application_1/questionnaires/PHQ9.dart';
// import 'package:flutter_application_1/questionnaires/PHQ9Screen.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class EmotionalEvaluationScreen extends StatefulWidget {
  final bool initialAssessment;

  const EmotionalEvaluationScreen({key, required this.initialAssessment})
      : super(key: key);

  @override
  _EmotionalEvaluationScreenState createState() =>
      _EmotionalEvaluationScreenState();
}

class _EmotionalEvaluationScreenState extends State<EmotionalEvaluationScreen> {
  bool isVeryHappy = true;
  bool isHappy = true;
  bool isNeutral = true;
  bool isBad = true;
  bool isVeryBad = true;

  int position = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/blue_background.png',
                    ),
                    fit: BoxFit.cover))),
        // Keeps the StepProgressIndicator in the same spot
        Visibility(
          visible: widget.initialAssessment,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 75, horizontal: 25),
            child: Align(
              alignment: Alignment.topCenter,
              child: StepProgressIndicator(
                totalSteps: 11,
                currentStep: position,
                selectedColor: Colors.white,
                unselectedColor: const Color(0xff004479),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
          child:
              Wrap(alignment: WrapAlignment.center, runSpacing: 15, children: [
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
              decoration: BoxDecoration(
                  color: const Color(0xff3290FF).withOpacity(0.60),
                  // border: Border.all(color: Colors.black38, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: const Center(
                child: Text('How do you feel in this moment?',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
            // Text(,
            //     style: TextStyle(fontSize: 16)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    spacing: 10,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isVeryHappy = true;
                              isHappy = false;
                              isNeutral = false;
                              isBad = false;
                              isVeryBad = false;
                            });
                          }, // Image tapped
                          splashColor:
                              Colors.white12, // Splash color over image
                          child: Ink.image(
                            image: (isVeryHappy)
                                ? const AssetImage(
                                    'assets/images/face_very_happy.png',
                                  )
                                : const AssetImage('assets/images/splash.png'),
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                      const Text('Very Happy',
                          style: TextStyle(fontSize: 18, color: Colors.white))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 100,
              ),
              Expanded(
                child: Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    // runSpacing: 20,
                    spacing: 10,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isVeryHappy = false;
                              isHappy = true;
                              isNeutral = false;
                              isBad = false;
                              isVeryBad = false;
                            });
                            print('happy');
                          }, // Image tapped
                          splashColor:
                              Colors.white12, // Splash color over image
                          child: Ink.image(
                            image: (isHappy)
                                ? const AssetImage(
                                    'assets/images/face_happy.png',
                                  )
                                : const AssetImage(
                                    'assets/images/face_happy_selected.png'),
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                      const Text('Happy',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white))
                    ],
                  ),
                ),
              ),
            ]),
            Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                // runSpacing: 20,
                spacing: 10,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isVeryHappy = false;
                          isHappy = false;
                          isNeutral = true;
                          isBad = false;
                          isVeryBad = false;
                        });
                        print('neutral');
                      }, // Image tapped
                      splashColor: Colors.white12, // Splash color over image
                      child: Ink.image(
                        image: (isNeutral)
                            ? const AssetImage(
                                'assets/images/face_neutral.png',
                              )
                            : const AssetImage(
                                'assets/images/face_neutral_selected.png'),
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  const Text('Neutral',
                      style: TextStyle(fontSize: 18, color: Colors.white))
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    spacing: 10,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isVeryHappy = false;
                              isHappy = false;
                              isNeutral = false;
                              isBad = false;
                              isVeryBad = true;
                            });
                            print('very bad');
                          }, // Image tapped
                          splashColor:
                              Colors.white12, // Splash color over image
                          child: Ink.image(
                            image: (isVeryBad)
                                ? const AssetImage(
                                    'assets/images/face_very_bad.png',
                                  )
                                : const AssetImage(
                                    'assets/images/face_very_bad_selected.png'),
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                      const Text('Very Bad',
                          style: TextStyle(fontSize: 18, color: Colors.white))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 100,
              ),
              Expanded(
                child: Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    // runSpacing: 20,
                    spacing: 10,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isVeryHappy = false;
                              isHappy = false;
                              isNeutral = false;
                              isBad = true;
                              isVeryBad = false;
                            });
                            print('bad');
                          }, // Image tapped
                          splashColor:
                              Colors.white12, // Splash color over image
                          child: Ink.image(
                            image: (isBad)
                                ? const AssetImage(
                                    'assets/images/face_bad.png',
                                  )
                                : const AssetImage(
                                    'assets/images/face_bad_selected.png'),
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                      const Text('Bad',
                          style: TextStyle(fontSize: 18, color: Colors.white))
                    ],
                  ),
                ),
              ),
            ]),
          ]),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
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
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.all(10),
                    primary: (isVeryHappy &&
                            isHappy &&
                            isNeutral &&
                            isBad &&
                            isVeryBad)
                        ? const Color(0xffE2E4E4)
                        : const Color(0xffFFBE18),
                  ),
                  onPressed: () {}),
            ),
          ),
        )
      ]),
    );
  }
}
