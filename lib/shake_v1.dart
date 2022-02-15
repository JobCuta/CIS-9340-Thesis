import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(home: ShakeFeature()));
}

class ShakeFeature extends StatefulWidget {
  const ShakeFeature({Key? key}) : super(key: key);

  @override
  _ShakeFeatureState createState() => _ShakeFeatureState();
}

class _ShakeFeatureState extends State<ShakeFeature> {
  late ShakeDetector detector;

  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.waitForStart(onPhoneShake: () {
      print('shake');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RandomizingScreen()),
      );
    });
    detector.startListening();
  }

  @override
  void dispose() {
    // makes the detector stop listening to shaking after leaving the page
    detector.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 60,
                child: Image(
                    image: AssetImage('assets/images/sample.png'),
                    width: 200,
                    height: 200),
              ),
              const Text('Shake me!')
            ],
          ),
        ),
      ),
    );
  }
}

class RandomizingScreen extends StatefulWidget {
  const RandomizingScreen({Key? key}) : super(key: key);

  @override
  _RandomizingScreenState createState() => _RandomizingScreenState();
}

class _RandomizingScreenState extends State<RandomizingScreen> {
  @override
  initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: initScreen(context),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const Recommendation()));
    });
  }

  initScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 60,
              child: Image(
                  image: AssetImage('assets/images/sample.png'),
                  width: 200,
                  height: 200),
            ),
            const Text('Randomizing...')
          ],
        ),
      ),
    );
  }
}

class Recommendation extends StatefulWidget {
  const Recommendation({Key? key}) : super(key: key);

  @override
  _RecommendationState createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 60,
                child: Image(
                    image: AssetImage('assets/images/sample.png'),
                    width: 200,
                    height: 200),
              ),
              const Text('Exercise')
            ],
          ),
        ),
      ),
    );
  }
}
