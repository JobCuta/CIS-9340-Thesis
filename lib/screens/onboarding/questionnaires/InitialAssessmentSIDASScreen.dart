import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';

void main() {
  runApp(const GetMaterialApp(home: InitialAssessmentSIDASScreen()));
}

class InitialAssessmentSIDASScreen extends StatefulWidget {
  const InitialAssessmentSIDASScreen({Key? key}) : super(key: key);

  @override
  _InitialAssessmentSIDASScreenState createState() =>
      _InitialAssessmentSIDASScreenState();
}

class _InitialAssessmentSIDASScreenState
    extends State<InitialAssessmentSIDASScreen> {
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
      SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
            child: Center(
                child: Wrap(
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                  Text(
                      "We are going to ask you 5 questions about any suicidal ideation present",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: Theme.of(context).colorScheme.neutralWhite01,
                          fontWeight: FontWeight.w600)),
                  Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          color: const Color(0xff3290FF).withOpacity(0.60),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4))),
                      child: Text(
                        'These questions will help determine any presence of suicidal ideation and will assess your severity of such mindset.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w400,
                            color:
                                Theme.of(context).colorScheme.neutralWhite01),
                      ))
                ]))),
      ),
      Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                    child: Text("I'm ready!",
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: Theme.of(context).colorScheme.neutralWhite01,
                            fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: const Color(0xffFFBE18),
                    ),
                    onPressed: () {
                      Get.toNamed('/sidasScreen');
                    }),
              )))
    ]));
  }
}
