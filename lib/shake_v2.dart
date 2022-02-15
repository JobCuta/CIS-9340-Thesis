import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
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
  // variables for the PageView.builder
  PageController _pageController = PageController();
  var random = new Random();
  var currentPageValue = 0.0;
  List<String> screenTitle = [
    'Shake your phone!',
    'Randomising...',
    'Take a minute and breathe and meditate',
    'Listen to the relaxing sounds of rain',
    'PLACEHOLDER 3rd EXERCISE'
  ];

  List<String> screenDescription = [
    'Randomize the first exercise you will do!',
    "Let’s see what you’ll get!",
    '',
    '',
    ''
  ];

  List<String> screenImages = [
    'assets/images/phone.png',
    'assets/images/phone.png',
    'assets/images/sample.png',
    'assets/images/sample.png',
    'assets/images/sample.png'
  ];

  // random colors for now
  List<dynamic> colors = [
    Colors.blue[300],
    Colors.red[500],
    Colors.yellow[700],
    Colors.purple[900],
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
    // random number 1 to 3, changes page after 5 seconds
    int randomExercise = random.nextInt(3) + 2;
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      _pageController.jumpToPage(randomExercise);
      // duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
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
              CircleAvatar(
                radius: 60,
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
