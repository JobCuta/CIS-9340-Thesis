import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const GetMaterialApp(home: InitialAssessmentPHQ9Screen()));
}

class InitialAssessmentPHQ9Screen extends StatefulWidget {
  const InitialAssessmentPHQ9Screen({Key? key}) : super(key: key);

  @override
  _InitialAssessmentPHQ9ScreenState createState() =>
      _InitialAssessmentPHQ9ScreenState();
}

class _InitialAssessmentPHQ9ScreenState
    extends State<InitialAssessmentPHQ9Screen> {
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
      Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
          child: Center(
              child: Wrap(
                  runSpacing: 30,
                  alignment: WrapAlignment.center,
                  children: [
                Text(
                    "We are going to ask you 9 questions about your mental health",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.white)),
                Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: const Color(0xff3290FF).withOpacity(0.60),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                    child: Column(children: [
                      Text(
                          'The questions will be about yourself, how you go through with and your physical well-being...',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontSize: 18, color: Colors.white)),
                      const SizedBox(height: 50),
                      Text('Feedback will be given right after.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontSize: 18, color: Colors.white)),
                    ]))
              ]))),
      Container(
          padding: const EdgeInsets.all(20),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                    child: Text(
                      "I'm ready!",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.apply(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(12),
                      primary: const Color(0xffFFBE18),
                    ),
                    onPressed: () {
                      Get.toNamed('/phqScreen');
                    }),
              )))
    ]));
  }
}
