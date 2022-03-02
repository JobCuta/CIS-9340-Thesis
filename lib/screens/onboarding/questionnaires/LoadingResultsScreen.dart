import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

void main() {
  runApp(const LoadingResultsScreen());
}

class LoadingResultsScreen extends StatelessWidget {
  const LoadingResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: LoadingResultsScreenWidget(),
          ),
        ),
    );
  }
}

class LoadingResultsScreenWidget extends StatefulWidget {
  const LoadingResultsScreenWidget({Key? key}) : super(key: key);

  @override
  State<LoadingResultsScreenWidget> createState() =>
      _LoadingResultsScreenState();
}

class _LoadingResultsScreenState extends State<LoadingResultsScreenWidget> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() {
    Get.to(nextScreen(), transition: Transition.fadeIn, duration: const Duration(seconds: 1),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 145.0,
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Image.asset(
                'assets/images/flower_fill.gif',
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              'Evaluating your answers, your results are now being prepared...',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Proxima Nova',
                fontWeight: FontWeight.w600,
                color: Color(0xff737879),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class nextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 145.0,
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Image.asset(
                'assets/images/flower_filled.png',
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              'Your results for your first evaluation is ready!',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Proxima Nova',
                fontWeight: FontWeight.w600,
                color: Color(0xff737879),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
