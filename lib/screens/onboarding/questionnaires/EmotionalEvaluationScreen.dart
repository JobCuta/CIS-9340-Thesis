import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'EmotionalEvaluationPositiveNegativeScreen.dart';

void main() {
  runApp(const GetMaterialApp(home: EmotionalEvaluationScreen()));
}

class Emotion {
  final int id;
  final String name;

  Emotion({
    required this.id,
    required this.name,
  });

  @override
  toString() => name;
}

class EmotionalEvaluationScreen extends StatefulWidget {
  const EmotionalEvaluationScreen({key}) : super(key: key);

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
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 75, 25, 0),
          child: Container(
            height: 50,
            padding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
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
                        setState(() {
                          isVeryHappy = true;
                          isHappy = false;
                          isNeutral = false;
                          isBad = false;
                          isVeryBad = false;
                        });
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
                        setState(() {
                          isVeryHappy = false;
                          isHappy = true;
                          isNeutral = false;
                          isBad = false;
                          isVeryBad = false;
                        });
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
                      setState(() {
                        isVeryHappy = false;
                        isHappy = false;
                        isNeutral = true;
                        isBad = false;
                        isVeryBad = false;
                      });
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
                        setState(() {
                          isVeryHappy = false;
                          isHappy = false;
                          isNeutral = false;
                          isBad = false;
                          isVeryBad = true;
                        });
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
                        setState(() {
                          isVeryHappy = false;
                          isHappy = false;
                          isNeutral = false;
                          isBad = true;
                          isVeryBad = false;
                        });
                      },
                      splashColor: Colors.white12,
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
                        : Get.toNamed('/emotionPNScreen');
                  }),
            ),
          ),
        ),
      ]),
    );
  }
}

void toEmotionalEvaluationPositiveNegative(context, initialAssessment) {
  Get.toNamed('/emotionPNScreen');
}