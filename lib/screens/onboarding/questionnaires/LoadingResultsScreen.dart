import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(const LoadingResultsScreen());
}

class LoadingResultsScreen extends StatelessWidget {
  const LoadingResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(home: LoadingResultsScreenWidget());
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
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 20,
      title: const Text(
        'Evaluating your answers, your \n results are now being prepared...',
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'Proxima Nova',
          fontWeight: FontWeight.w600,
          color: Color(0xff737879),
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.white,
      image: Image.asset('assets/images/flower_fill.gif'),
      loaderColor: Colors.white,
      photoSize: 100,
      navigateAfterSeconds: nextScreen(),
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
