import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/userSecureStorage.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';

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
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
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
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: [
                    Text(
                        "We are going to ask you 9 questions about your mental health",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: Theme.of(context).colorScheme.neutralWhite01,
                            fontWeight: FontWeight.w600)),
                    Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 0),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        decoration: BoxDecoration(
                            color: const Color(0xff3290FF).withOpacity(0.60),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4))),
                        child: Column(children: [
                          Text(
                              'The questions will be about yourself, how you go through with these experiences, and your own well-being.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralWhite01)),
                          const SizedBox(height: 30),
                          Text('Feedback will be given right after.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralWhite01)),
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
                              .subtitle2
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralWhite01,
                                  fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: const Color(0xffFFBE18),
                        ),
                        onPressed: () {
                          Get.toNamed('/phqScreen');
                        }),
                  )))
        ])),
      ),
    );
  }
}
