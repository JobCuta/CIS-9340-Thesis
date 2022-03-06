import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(GetMaterialApp(home: ShakeScreen()));
}

class ShakeScreen extends StatefulWidget {
  ShakeScreen({Key? key}) : super(key: key);

  final bool initialAssessment = Get.arguments["initial?"]!;

  @override
  _ShakeScreenState createState() => _ShakeScreenState();
}

class _ShakeScreenState extends State<ShakeScreen> {
  Timer? timer;

  var breathing = [
    'assets/images/breathing.svg',
    'Take a minute to breathe and meditate',
    'Meditating refreshes your mind and readies you for anything.',
    'Breathing'
  ];
  var meditation = [
    'assets/images/meditating.svg',
    'Notice your surroundings, relax your mind and body as you do so',
    'Being aware of your surroundings helps your mind and body focus more!',
    'Meditating'
  ];
  var walking = [
    'assets/images/walking.svg',
    'Pace around your environment and clear you mind',
    'Meditating as you walk helps reduce stress and anxiety!',
    'Walking'
  ];

  @override
  void initState() {
    super.initState();
    var exercises = [breathing, walking, meditation];
    var randomExercise = (exercises..shuffle()).first;

    // function for the detector (only starts after initialization)
    timer = Timer(const Duration(seconds: 5), () {
      Get.toNamed('/exerciseScreen', arguments: {
        "assetImage": randomExercise[0],
        "prompt": randomExercise[1],
        "reason": randomExercise[2],
        "type": randomExercise[3],
        "initial?": widget.initialAssessment
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/background_images/orange_circles_background.png',
                    ),
                    fit: BoxFit.cover))),
        Container(
            // color: Colors.amberAccent,
            // height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Initial countdown beofre the exercise begins
                CircleAvatar(
                  radius: 100,
                  backgroundColor: const Color(0xffFFA132).withOpacity(0.60),
                  child: SvgPicture.asset('assets/images/phone.svg',
                      width: 200, height: 200),
                ),
                Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: const Color(0xffFFA132).withOpacity(0.60),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                    child: Column(
                      children: const [
                        Text('Randomizing...',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontFamily: 'Proxima Nova')),
                        Divider(
                          color: Colors.white,
                          height: 25,
                          thickness: 2,
                          indent: 5,
                          endIndent: 5,
                        ),
                        Text("Let's see what you'll get!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Proxima Nova')),
                      ],
                    )),
              ],
            )),
        Visibility(
          visible: widget.initialAssessment == false,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.all(12),
                    primary: const Color(0xff4CA7FC),
                  ),
                  onPressed: () {
                    dispose();
                    Get.toNamed('/wellnessScreen');
                  },
                  child: const Text(
                    'I want to pick the exercise',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: 'Proxima Nova',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

// Widget for the random exercises
class ExerciseScreen extends StatefulWidget {
  ExerciseScreen({Key? key}) : super(key: key);

  final String assetImage = Get.arguments["assetImage"]!;
  final String prompt = Get.arguments["prompt"]!;
  final String reason = Get.arguments["reason"]!;
  final String type = Get.arguments["type"]!;
  final bool initialAssessment = Get.arguments["initial?"]!;

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  var breathing = [
    'assets/images/breathing.svg',
    'Take a minute to breathe and meditate',
    'Meditating refreshes your mind and readies you for anything.',
    'Breathing'
  ];
  var meditation = [
    'assets/images/meditating.svg',
    'Notice your surroundings, relax your mind and body as you do so',
    'Being aware of your surroundings helps your mind and body focus more!',
    'Meditating'
  ];
  var walking = [
    'assets/images/walking.svg',
    'Pace around your environment and clear you mind',
    'Meditating as you walk helps reduce stress and anxiety!',
    'Walking'
  ];

  final PageController _pageController = PageController();
  final CountDownController _timerController = CountDownController();

  @override
  Widget build(BuildContext context) {
    var otherExercises = (widget.type == 'Breathing')
        ? [walking, meditation]
        : (widget.type == 'Meditating')
            ? [walking, breathing]
            : [meditation, breathing];

    return Scaffold(
        body: Stack(children: [
      // Used to add the background
      Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/background_images/orange_circles_background.png',
                  ),
                  fit: BoxFit.cover))),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: PageView.builder(
            // NeverScrollableScrollPhysics to ensure the user can only navigate through the pageviews with the expected interactions
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemBuilder: (context, position) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // For the CountDownTimer Widgets
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Visibility(
                              visible: position == 0,
                              child: InitialCountdownWidget(
                                  pageController: _pageController,
                                  timerController: _timerController,
                                  position: position)),
                          Visibility(
                              visible: position >= 1,
                              child: MainCountdownWidget(
                                  pageController: _pageController,
                                  timerController: _timerController,
                                  position: position)),
                        ],
                      ),
                    ),
                    // Middle Image
                    Expanded(
                      flex: 2,
                      child: SvgPicture.asset(
                        widget.assetImage,
                      ),
                    ),
                    // Holds the text seen on screen
                    Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 0),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: const Color(0xffFFA132).withOpacity(0.60),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4))),
                        child: Column(children: [
                          // Determines which AnimatedTextKit widget should be shown
                          (position == 0)
                              ? const Text('Relax and get ready...',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontFamily: 'Proxima Nova'))
                              : (position == 1)
                                  ? SizedBox(
                                      child: (widget.type == 'Breathing')
                                          ? const BreathingCycleWidget()
                                          : (widget.type == 'Walking')
                                              ? const WalkingCycleWidget()
                                              : const MeditationCycleWidget(),
                                      height: 26)
                                  : const Text('Good job!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontFamily: 'Proxima Nova')),
                          const Divider(
                            color: Colors.white,
                            height: 25,
                            thickness: 2,
                            indent: 5,
                            endIndent: 5,
                          ),
                          Text((position == 2) ? widget.reason : widget.prompt,
                              // Text(widget.reason,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Proxima Nova')),
                        ])),
                    // Button for the user to randomly generate a new exercise
                    (position == 1)
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    primary: const Color(0xff4CA7FC),
                                  ),
                                  onPressed: () {
                                    var randomExercise =
                                        (otherExercises..shuffle()).first;
                                    Get.offAndToNamed('/exerciseScreen',
                                        arguments: {
                                          "assetImage": randomExercise[0],
                                          "prompt": randomExercise[1],
                                          "reason": randomExercise[2],
                                          "type": randomExercise[3],
                                          "initial?": widget.initialAssessment
                                        });
                                  },
                                  child: const Text(
                                    'I want another exercise',
                                    style: TextStyle(
                                      fontFamily: 'Proxima Nova',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ) // user to the createAccountScreen
                                ),
                          )
                        : (position == 2)
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      primary: const Color(0xff4CA7FC),
                                    ),
                                    onPressed: () {
                                      Get.toNamed('/accountScreen');
                                    },
                                    child: Text(
                                      (widget.initialAssessment)
                                          ? 'Continue...'
                                          : 'Done',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontFamily: 'Proxima Nova',
                                      ),
                                    ),
                                  ),
                                ),
                              ) // Empty Text widget because the ternary operator needs a widget to be returned
                            : const Text(''),
                    // Allows the user to skip the exercises -> proceeds to the createAccountScreen
                    Visibility(
                      visible: widget.initialAssessment,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Visibility(
                          visible: position <= 1,
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed('/accountScreen');
                            },
                            child: const Text(
                              'Skip',
                              style: TextStyle(
                                  color: Color(0xff4CA7FC),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]);
            }),
      )
    ]));
  }
}

// AnimatedTextKit for the Meditation Exercise
class MeditationCycleWidget extends StatefulWidget {
  const MeditationCycleWidget({Key? key}) : super(key: key);

  @override
  _MeditationCycleWidgetState createState() => _MeditationCycleWidgetState();
}

class _MeditationCycleWidgetState extends State<MeditationCycleWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        FadeAnimatedText('Focus...',
            textStyle: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
            fadeInEnd: 0.2,
            fadeOutBegin: 0.9,
            duration: const Duration(seconds: 15)),
        FadeAnimatedText('Ground yourself...',
            textStyle: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
            duration: const Duration(seconds: 15)),
      ],
      totalRepeatCount: 2,
    );
  }
}

// AnimatedTextKit for the Walking Exercise
class WalkingCycleWidget extends StatefulWidget {
  const WalkingCycleWidget({Key? key}) : super(key: key);

  @override
  _WalkingCycleWidgetState createState() => _WalkingCycleWidgetState();
}

class _WalkingCycleWidgetState extends State<WalkingCycleWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        FadeAnimatedText('Clear your mind',
            textStyle: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
            fadeInEnd: 0.2,
            fadeOutBegin: 0.9,
            duration: const Duration(seconds: 15)),
        FadeAnimatedText('Pace yourself carefully',
            textStyle: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
            duration: const Duration(seconds: 15)),
      ],
      totalRepeatCount: 2,
    );
  }
}

// AnimatedTextKit for the Breathing Exercise
class BreathingCycleWidget extends StatefulWidget {
  const BreathingCycleWidget({Key? key}) : super(key: key);

  @override
  BreathingCycleWidgetState createState() => BreathingCycleWidgetState();
}

class BreathingCycleWidgetState extends State<BreathingCycleWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        FadeAnimatedText('Inhale...',
            textStyle: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
            fadeInEnd: 0.2,
            fadeOutBegin: 0.7,
            duration: const Duration(seconds: 4)),
        FadeAnimatedText('Hold...',
            textStyle: const TextStyle(
                fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white),
            duration: const Duration(seconds: 4)),
        FadeAnimatedText('Exhale...',
            textStyle: const TextStyle(
                fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white),
            duration: const Duration(seconds: 4)),
        FadeAnimatedText('Hold...',
            textStyle: const TextStyle(
                fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white),
            duration: const Duration(seconds: 4)),
      ],
      totalRepeatCount: 4,
    );
  }
}

// Widget for the countdown timer (10s)
class InitialCountdownWidget extends StatefulWidget {
  final PageController pageController;
  final CountDownController timerController;
  final int position;

  const InitialCountdownWidget(
      {key,
      required this.pageController,
      required this.timerController,
      required this.position})
      : super(key: key);

  @override
  _InitialCountdownWidgetState createState() => _InitialCountdownWidgetState();
}

class _InitialCountdownWidgetState extends State<InitialCountdownWidget> {
  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
        duration: 10,
        initialDuration: 0,
        controller: widget.timerController,
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.height / 5,
        ringColor: const Color(0xffFFB35A),
        fillColor: Colors.orange[100]!,
        backgroundColor: const Color(0xffE1871D).withOpacity(0.40),
        backgroundGradient: null,
        strokeWidth: 20.0,
        strokeCap: StrokeCap.round,
        textStyle: const TextStyle(
            fontSize: 50.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: 'Proxima Nova'),

        // Format for the Countdown Text.
        textFormat: CountdownTextFormat.SS,
        isReverse: true,
        isReverseAnimation: false,
        isTimerTextShown: true,
        autoStart: true,
        onComplete: () {
          // using jumpToPage to avoid the animations, TBD
          widget.pageController.jumpToPage(widget.position + 1);
        });
  }
}

// Widget for the countdown timer (60s)
class MainCountdownWidget extends StatefulWidget {
  final PageController pageController;
  final CountDownController timerController;
  final int position;

  const MainCountdownWidget(
      {key,
      required this.pageController,
      required this.timerController,
      required this.position})
      : super(key: key);

  @override
  _MainCountdownWidgetState createState() => _MainCountdownWidgetState();
}

class _MainCountdownWidgetState extends State<MainCountdownWidget> {
  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
        duration: (widget.position == 1) ? 60 : 0,
        initialDuration: 0,
        controller: widget.timerController,
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.height / 5,
        ringColor: const Color(0xffFFB35A),
        fillColor: Colors.orange[100]!,
        backgroundColor: const Color(0xffE1871D).withOpacity(0.40),
        strokeWidth: 20.0,
        strokeCap: StrokeCap.round,
        textStyle: const TextStyle(
            fontSize: 50.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: 'Proxima Nova'),

        // Format for the Countdown Text.
        textFormat: CountdownTextFormat.SS,
        isReverse: true,
        isReverseAnimation: false,
        isTimerTextShown: true,
        autoStart: true,
        onComplete: () {
          widget.pageController.jumpToPage(widget.position + 1);
        });
  }
}
