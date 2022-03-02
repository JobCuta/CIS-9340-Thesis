import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:shake/shake.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../login_registration/CreateAccountScreen.dart';

void main() {
  runApp(const MaterialApp(home: ShakeScreen()));
}

class ShakeScreen extends StatefulWidget {
  const ShakeScreen({Key? key}) : super(key: key);

  @override
  _ShakeScreenState createState() => _ShakeScreenState();
}

class _ShakeScreenState extends State<ShakeScreen> {
  // variables for the PageView.builder
  final PageController _pageController = PageController();

  List<String> screenTitle = [
    'Shake your phone!',
    'Randomising...',
  ];

  List<String> screenDescription = [
    'Randomize the first exercise you will do!',
    "Let's see what you'll get!",
  ];

  late ShakeDetector detector;

  @override
  void initState() {
    super.initState();

    // function for the detector (only starts after initialization)
    detector = ShakeDetector.waitForStart(onPhoneShake: () {
      _pageController.jumpToPage(1);
      detector.stopListening();
      startTime();
    });
    detector.startListening();
  }

  startTime() async {
    var breathing = [
      'assets/images/breathing.png',
      'Take a minute to breathe and meditate',
      'Meditating refreshes your mind and readies you for anything.',
      'Breathing'
    ];
    var meditation = [
      'assets/images/meditating.png',
      'Notice your surroundings, relax your mind and body as you do so',
      'Being aware of your surroundings helps your mind and body focus more!',
      'Meditating'
    ];
    var walking = [
      'assets/images/walking.png',
      'Pace around your environment and clear you mind',
      'Meditating as you walk helps reduce stress and anxiety!',
      'Walking'
    ];

    var exercises = [breathing, walking, meditation];
    var randomExercise = (exercises..shuffle()).first;
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Get.toNamed('/exerciseScreen', arguments: {
        "assetImage": randomExercise[0],
        "prompt": randomExercise[1],
        "reason": randomExercise[2],
        "type": randomExercise[3]
      });
    });
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
        PageView.builder(
          // NeverScrollableScrollPhysics to ensure the user can only navigate through the pageviews with the expected interactions
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemBuilder: (context, position) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Initial countdown beofre the exercise begins
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.orange[300]!,
                  child: const Image(
                      image: AssetImage('assets/images/phone.png'),
                      width: 200,
                      height: 200),
                ),
                Container(
                    margin: const EdgeInsets.all(50),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.orange[300]!.withOpacity(0.50),
                        // border: Border.all(color: Colors.black38, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: Column(
                      children: [
                        Text(screenTitle[position],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const Divider(
                          color: Colors.white,
                          height: 25,
                          thickness: 2,
                          indent: 5,
                          endIndent: 5,
                        ),
                        Text(screenDescription[position],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white)),
                      ],
                    )), // REMOVE UPON FINAL DEPLOYMENT (included for testing purposes only)
                TextButton(
                    child: const Text('SHAKE (Emulator)'),
                    onPressed: () {
                      detector.stopListening();
                      startTime();
                    }),
                TextButton(
                  onPressed: () {
                    Get.to('/accountScreen');
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.blue[300], fontSize: 24),
                  ),
                ),
              ],
            );
          },
        )
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


  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  var breathing = [
    'assets/images/breathing.png',
    'Take a minute to breathe and meditate',
    'Meditating refreshes your mind and readies you for anything.',
    'Breathing'
  ];
  var meditation = [
    'assets/images/meditating.png',
    'Notice your surroundings, relax your mind and body as you do so',
    'Being aware of your surroundings helps your mind and body focus more!',
    'Meditating'
  ];
  var walking = [
    'assets/images/walking.png',
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
      PageView.builder(
          // NeverScrollableScrollPhysics to ensure the user can only navigate through the pageviews with the expected interactions
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemBuilder: (context, position) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // For the CountDownTimer Widgets
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Visibility(
                            visible: position == 0,
                            child: InitialCountdownWidget(
                                pageController: _pageController,
                                timerController: _timerController,
                                position: position)),
                        Visibility(
                            visible: position == 1,
                            child: MainCountdownWidget(
                                pageController: _pageController,
                                timerController: _timerController,
                                position: position)),
                      ],
                    ),
                  ),
                  // Middle Image
                  Image(
                      image: AssetImage(
                        widget.assetImage,
                      ),
                      width: 150,
                      height: 150),
                  // Holds the text seen on screen
                  Container(
                      margin: const EdgeInsets.all(50),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.orange[300]!.withOpacity(0.50),
                          // border: Border.all(color: Colors.black38, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Column(children: [
                        // Determines which AnimatedTextKit widget should be shown
                        (position == 0)
                            ? const Text('Relax and get ready...',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))
                            : (position == 1)
                                ? SizedBox(
                                    child: (widget.type == 'Breathing')
                                        ? const BreathingCycleWidget()
                                        : (widget.type == 'Walking')
                                            ? const WalkingCycleWidget()
                                            : const MeditationCycleWidget(),
                                    height: 30)
                                : const Text('Good job!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                        const Divider(
                          color: Colors.white,
                          height: 25,
                          thickness: 2,
                          indent: 5,
                          endIndent: 5,
                        ),
                        Text((position == 2) ? widget.reason : widget.prompt,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 19, color: Colors.white)),
                      ])),
                  // Button for the user to randomly generate a new exercise
                  (position == 1)
                      ? SizedBox(
                          width: 328,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.all(12),
                              primary: Colors.blue[400],
                            ),
                            onPressed: () {
                              var randomExercise =
                                  (otherExercises..shuffle()).first;
                              Get.toNamed('/exerciseScreen', arguments: {
                                "assetImage": randomExercise[0],
                                "prompt": randomExercise[1],
                                "reason": randomExercise[2],
                                "type": randomExercise[3]
                              });
                            },
                            child: const Text(
                              'I want another exercise',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ) // user to the createAccountScreen
                      : (position == 2)
                          ? SizedBox(
                              width: 328,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  primary: Colors.blue[400],
                                ),
                                onPressed: () {
                                  Get.toNamed('/accountScreen');
                                },
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ) // Empty Text widget because the ternary operator needs a widget to be returned
                          : const Text(''),
                  // Allows the user to skip the exercises -> proceeds to the createAccountScreen
                  Visibility(
                    visible: position <= 1,
                    child: TextButton(
                      // style: TextButton.styleFrom(primary: Colors.transparent),
                      onPressed: () {
                        Get.toNamed('/accountScreen');
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(color: Colors.blue[300], fontSize: 24),
                      ),
                    ),
                  )
                ]);
          })
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
                fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
            fadeInEnd: 0.2,
            fadeOutBegin: 0.3,
            duration: const Duration(seconds: 15)),
        FadeAnimatedText('Ground yourself...',
            textStyle: const TextStyle(
                fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
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
                fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
            fadeInEnd: 0.2,
            fadeOutBegin: 0.3,
            duration: const Duration(seconds: 15)),
        FadeAnimatedText('Pace yourself carefully',
            textStyle: const TextStyle(
                fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
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
                fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
            fadeInEnd: 0.2,
            fadeOutBegin: 0.3,
            duration: const Duration(seconds: 4)),
        FadeAnimatedText('Hold...',
            textStyle: const TextStyle(
                fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
            duration: const Duration(seconds: 4)),
        FadeAnimatedText('Exhale...',
            textStyle: const TextStyle(
                fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
            duration: const Duration(seconds: 4)),
        FadeAnimatedText('Hold...',
            textStyle: const TextStyle(
                fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
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
        ringColor: Colors.orange[300]!,
        fillColor: Colors.orange[100]!,
        backgroundColor: Colors.orange[500],
        backgroundGradient: null,
        strokeWidth: 20.0,
        strokeCap: StrokeCap.round,
        textStyle: const TextStyle(
            fontSize: 50.0, color: Colors.white, fontWeight: FontWeight.bold),

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
        duration: 60,
        initialDuration: 0,
        controller: widget.timerController,
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.height / 5,
        ringColor: Colors.orange[300]!,
        fillColor: Colors.orange[100]!,
        backgroundColor: Colors.orange[500],
        strokeWidth: 20.0,
        strokeCap: StrokeCap.round,
        textStyle: const TextStyle(
            fontSize: 50.0, color: Colors.white, fontWeight: FontWeight.bold),

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
