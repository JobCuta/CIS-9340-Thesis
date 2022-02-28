import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'EmotionalEvaluationPositiveNegativeScreen.dart';

void main() {
  runApp(MaterialApp(home: EmotionalEvaluationScreen(initialAssessment: true)));
}

class Emotion {
  final int id;
  final String name;

  Emotion({
    required this.id,
    required this.name,
  });

  @override
  toString() => '$name';
}

class EmotionalEvaluationScreen extends StatefulWidget {
  bool initialAssessment = true;

  EmotionalEvaluationScreen({key, required this.initialAssessment})
      : super(key: key);

  @override
  _EmotionalEvaluationScreenState createState() =>
      _EmotionalEvaluationScreenState();
}

class _EmotionalEvaluationScreenState extends State<EmotionalEvaluationScreen> {
  // int position = 10;
  bool isVeryHappy = true;
  bool isHappy = true;
  bool isNeutral = true;
  bool isBad = true;
  bool isVeryBad = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/background_images/blue_background.png',
                    ),
                    fit: BoxFit.cover))),
        // Keeps the StepProgressIndicator in the same spot
        // Visibility(
        //   visible: widget.initialAssessment,
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(vertical: 75, horizontal: 25),
        //     child: Align(
        //       alignment: Alignment.topCenter,
        //       child: StepProgressIndicator(
        //         totalSteps: 11,
        //         currentStep: position,
        //         selectedColor: Colors.white,
        //         unselectedColor: const Color(0xff004479),
        //       ),
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 75, 25, 0),
          child: Container(
            height: 50,
            // width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
            // vertical: 10.0, horizontal: 18.0),
            decoration: BoxDecoration(
                color: const Color(0xff3290FF).withOpacity(0.60),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: const Align(
              alignment: Alignment.topCenter,
              child: Text('How do you feel in this moment?',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ),
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Container(
          //   padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
          //   child: Wrap(
          //       alignment: WrapAlignment.center,
          //       runSpacing: 20,
          //       children: [
          //         Container(
          //           width: double.infinity,
          //           padding: const EdgeInsets.symmetric(
          //               vertical: 14.0, horizontal: 18.0),
          //           decoration: BoxDecoration(
          //               color: const Color(0xff3290FF).withOpacity(0.60),
          //               borderRadius:
          //                   const BorderRadius.all(Radius.circular(8))),
          //           child: const Align(
          //             alignment: Alignment.topCenter,
          //             child: Text('How do you feel in this moment?',
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(color: Colors.white, fontSize: 20)),
          //             // ),
          //           ),
          //         ),
          // Text(,
          //     style: TextStyle(fontSize: 16)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                spacing: 5,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        (widget.initialAssessment)
                            ? setState(() {
                                isVeryHappy = true;
                                isHappy = false;
                                isNeutral = false;
                                isBad = false;
                                isVeryBad = false;
                              })
                            : toEmotionalEvaluationPositiveNegative(
                                context, widget.initialAssessment);
                      }, // Image tapped
                      splashColor: Colors.white12, // Splash color over image
                      child: Ink.image(
                        image: (isVeryHappy)
                            ? const AssetImage(
                                'assets/images/face_very_happy_selected.png',
                              )
                            : const AssetImage(
                                'assets/images/face_very_happy.png'),
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
            const SizedBox(
              width: 100,
            ),
            Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                spacing: 5,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        (widget.initialAssessment)
                            ? setState(() {
                                isVeryHappy = false;
                                isHappy = true;
                                isNeutral = false;
                                isBad = false;
                                isVeryBad = false;
                              })
                            : toEmotionalEvaluationPositiveNegative(
                                context, widget.initialAssessment);
                        print('happy');
                      }, // Image tapped
                      splashColor: Colors.white12, // Splash color over image
                      child: Ink.image(
                        image: (isHappy)
                            ? const AssetImage(
                                'assets/images/face_happy_selected.png',
                              )
                            : const AssetImage('assets/images/face_happy.png'),
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  const Text('Happy',
                      style: TextStyle(fontSize: 18, color: Colors.white))
                ],
              ),
            ),
          ]),
          Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              spacing: 5,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      (widget.initialAssessment)
                          ? setState(() {
                              isVeryHappy = false;
                              isHappy = false;
                              isNeutral = true;
                              isBad = false;
                              isVeryBad = false;
                            })
                          : toEmotionalEvaluationPositiveNegative(
                              context, widget.initialAssessment);
                      print('neutral');
                    }, // Image tapped
                    splashColor: Colors.white12, // Splash color over image
                    child: Ink.image(
                      image: (isNeutral)
                          ? const AssetImage(
                              'assets/images/face_neutral_selected.png',
                            )
                          : const AssetImage('assets/images/face_neutral.png'),
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
            Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                spacing: 5,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        (widget.initialAssessment)
                            ? setState(() {
                                isVeryHappy = false;
                                isHappy = false;
                                isNeutral = false;
                                isBad = false;
                                isVeryBad = true;
                              })
                            : toEmotionalEvaluationPositiveNegative(
                                context, widget.initialAssessment);
                        print('very bad');
                      }, // Image tapped
                      splashColor: Colors.white12, // Splash color over image
                      child: Ink.image(
                        image: (isVeryBad)
                            ? const AssetImage(
                                'assets/images/face_very_bad_selected.png',
                              )
                            : const AssetImage(
                                'assets/images/face_very_bad.png'),
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
            const SizedBox(
              width: 100,
            ),
            Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                spacing: 5,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        (widget.initialAssessment)
                            ? setState(() {
                                isVeryHappy = false;
                                isHappy = false;
                                isNeutral = false;
                                isBad = true;
                                isVeryBad = false;
                              })
                            : toEmotionalEvaluationPositiveNegative(
                                context, widget.initialAssessment);
                        print('bad');
                      }, // Image tapped
                      splashColor: Colors.white12, // Splash color over image
                      child: Ink.image(
                        image: (isBad)
                            ? const AssetImage(
                                'assets/images/face_bad_selected.png',
                              )
                            : const AssetImage('assets/images/face_bad.png'),
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  const Text('Bad',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ]),
        ]),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
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
                    elevation: 0,
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
                  onPressed: () {
                    (isVeryHappy && isHappy && isNeutral && isBad && isVeryBad)
                        ? null
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MaterialApp(
                                        home:
                                            EmotionalEvaluationPositiveNegativeScreen(
                                      initialAssessment: true,
                                    ))));
                    //
                  }),
            ),
          ),
        ),
      ]),
    );
  }
}

void toEmotionalEvaluationPositiveNegative(context, initialAssessment) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MaterialApp(
                  home: EmotionalEvaluationPositiveNegativeScreen(
                initialAssessment: initialAssessment,
              ))));
}
