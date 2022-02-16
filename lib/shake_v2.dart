import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(const shake());
}

class shake extends StatefulWidget {
  const shake({Key? key}) : super(key: key);

  @override
  _shakeState createState() => _shakeState();
}

class _shakeState extends State<shake> {
  bool _startExercise = false;

  // variables for the PageView.builder
  final PageController _pageController = PageController();
  final CountDownController _timerController = CountDownController();
  var random = Random();
  var counter = 0;

  List<String> screenTitle = [
    'Shake your phone!',
    'Randomising...',
    'Take a minute and breathe and meditate',
    'Take a minute and breathe and meditate',
    "Pay attention to an object's movement",
    "Pay attention to an object's movement",
    'Go for a short, mindful walk',
    'Go for a short, mindful walk'
  ];

  List<String> screenDescription = [
    'Randomize the first exercise you will do!',
    "Let’s see what you’ll get!",
    'Get comfortable and focus on your breathing',
    'Get comfortable and focus on your breathing',
    'Keep your attention on the present',
    'Keep your attention on the present',
    '"With each step, a gentle wind blows"',
    '"With each step, a gentle wind blows"'
  ];

  List<String> screenImages = [
    'assets/images/phone.png',
    'assets/images/phone.png',
    'assets/images/meditating.png',
    'assets/images/meditating.png',
    'assets/images/breathing.png',
    'assets/images/breathing.png',
    'assets/images/walking.png',
    'assets/images/walking.png'
  ];

  // random colors for now
  List<dynamic> colors = [
    Colors.blue[300],
    Colors.red[500],
    Colors.yellow[700],
    Colors.yellow[700],
    Colors.purple[900],
    Colors.purple[900],
    Colors.green[800],
    Colors.green[800]
  ];

  late ShakeDetector detector;

  @override
  void initState() {
    super.initState();

    // function for the detector (only starts after initialization)
    detector = ShakeDetector.waitForStart(onPhoneShake: () {
      print('shake');
      _pageController.jumpToPage(1);
      // _pageController.nextPage(
      //     duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
      // disables the detector
      detector.stopListening();
      startTime();
    });
    detector.startListening();
  }

  startTime() async {
    var randomExercises = [2, 4, 6];
    var randomExercise = (randomExercises..shuffle()).first;
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      counter = randomExercise;
      print('counter: ' + counter.toString());
      _pageController.jumpToPage(randomExercise);
      // duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    var _initialCountdown = false;
    // var _duration = 10;

    return MaterialApp(
        home: Scaffold(
            body: PageView.builder(
      // NeverScrollableScrollPhysics to ensure the user can only navigate through the pageviews with the expected interactions
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      itemBuilder: (context, position) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: position == 2 || position == 4 || position == 6,
                child: Column(
                  children: [
                    const Text('Relax and get ready...'),
                    CircularCountDownTimer(
                        duration: 10,
                        initialDuration: 0,
                        controller: _timerController,
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.height / 2.5,
                        ringColor: Colors.orange[300]!,
                        fillColor: Colors.orange[100]!,
                        backgroundColor: Colors.orange[500],
                        backgroundGradient: null,
                        strokeWidth: 20.0,
                        strokeCap: StrokeCap.round,
                        textStyle: const TextStyle(
                            fontSize: 33.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),

                        // Format for the Countdown Text.
                        textFormat: CountdownTextFormat.MM_SS,
                        isReverse: true,
                        isReverseAnimation: false,
                        isTimerTextShown: true,
                        autoStart: true,
                        onComplete: () {
                          _pageController.jumpToPage(position + 1);
                        }),
                  ],
                ),
              ),
              Visibility(
                visible: position == 3 || position == 5 || position == 7,
                child: CircularCountDownTimer(
                    duration: 60,
                    initialDuration: 0,
                    controller: _timerController,
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.height / 2.5,
                    ringColor: Colors.orange[300]!,
                    fillColor: Colors.orange[100]!,
                    backgroundColor: Colors.orange[500],
                    strokeWidth: 20.0,
                    strokeCap: StrokeCap.round,
                    textStyle: const TextStyle(
                        fontSize: 33.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),

                    // Format for the Countdown Text.
                    textFormat: CountdownTextFormat.MM_SS,
                    isReverse: true,
                    isReverseAnimation: false,
                    isTimerTextShown: true,
                    autoStart: true,
                    onComplete: () {}),
              ),
              CircleAvatar(
                radius: 100,
                backgroundColor: colors[position],
                child: Image(
                    image: AssetImage(screenImages[position]),
                    width: 200,
                    height: 200),
              ),
              Container(
                  margin: const EdgeInsets.all(50),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Text(screenTitle[position],
                          style: const TextStyle(fontSize: 20)),
                      Text(screenDescription[position],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18)),
                    ],
                  )),
            ],
          ),
        );
      },
      itemCount: screenTitle.length,
    )));
  }
}
