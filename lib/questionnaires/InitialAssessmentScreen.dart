import 'package:flutter/material.dart';
import 'package:flutter_application_1/questionnaires/PHQ9Screen.dart';

void main() {
  runApp(const MaterialApp(home: InitialAssessmentScreen()));
}

class InitialAssessmentScreen extends StatefulWidget {
  const InitialAssessmentScreen({Key? key}) : super(key: key);

  @override
  _InitialAssessmentScreenState createState() =>
      _InitialAssessmentScreenState();
}

class _InitialAssessmentScreenState extends State<InitialAssessmentScreen> {
  // Currently can't figure out how to display the hint text (Pick an option) with the current implementation
  // thus 'Pick an option' was added as an option (countermeasure added to ensure the user cannot proceed unless they choose a different option)

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
      Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
          child: Center(
              child: Wrap(
                  runSpacing: 30,
                  alignment: WrapAlignment.center,
                  children: const [
                Text("We're going to ask you X questions about mental health",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                Text(
                    'The questions will be about yourself, how you go through with and your physical well-being...',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                Text('Feedback will be given right after.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    )),
              ]))),
      // Bottombar
      Container(
          padding: const EdgeInsets.all(20),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 328,
                height: 50,
                child: ElevatedButton(
                    child: const Text('Next',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(12),
                      primary: const Color(0xffFFBE18),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MaterialApp(
                                      home: PHQ9Screen(
                                    initialAssessment: true,
                                  )))); // _pageController.jumpToPage(position + 1);
                    }),
              )))
    ]));
  }
}
