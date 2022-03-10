import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      Container(
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
                        color: Colors.white,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w600)),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color(0xff3290FF).withOpacity(0.60),
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  child: Text(
                      'These questions will help determine any presence of suicidal ideation and will assess your severity of such mindset.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontFamily: 'Proxima Nova', color: Colors.white)),
                )
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
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Proxima Nova"),
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
                      Get.toNamed('/sidasScreen');
                    }),
              )))
    ]));
  }
}
