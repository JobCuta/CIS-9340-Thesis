import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const IntroductionScreen());
}

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/background_images/orange_circles_background.png"),
                fit: BoxFit.cover)),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 25.0, left: 15.0, right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Text(
                    'Welcome to Kasiyanna!',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Proxima Nova'),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Kasiyanna is the app that will join you in your journey to reaching mindfulness and emotional comfort. Not only does Kasiyanna ask you daily questions about your emotional well-being but also lets you enrich the journey thorugh games and daily tasks!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: 'Proxima Nova',
                        height: 2.0,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: SvgPicture.asset(
                      'assets/images/meditate.svg',
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        primary: Colors.blue,
                      ),
                      onPressed: () {
                        Get.toNamed("/shakeScreen",
                            arguments: {"initial?": true});
                      },
                      child: const Text(
                        'Start your journey',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Proxima Nova'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text:
                            'Your privacy matters to us. You can learn how we can handle your information when you use our Services by reading our ',
                        style: const TextStyle(
                            fontSize: 14,
                            height: 2.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Proxima Nova',
                            color: Color.fromRGBO(82, 78, 88, 1)),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(
                              color: Colors.green,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                //go to privacy policy page
                              },
                          ),
                          const TextSpan(text: '.')
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
