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
                  Text(
                    'Welcome to Kasiyanna!',
                    style: Theme.of(context).textTheme.headline1?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Kasiyanna is the app that will join you in your journey to reaching mindfulness and emotional comfort. Not only does Kasiyanna ask you daily questions about your emotional well-being but also lets you enrich the journey thorugh games and daily tasks!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(height: 2.0, color: Colors.white),
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
                      style:Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () {
                        Get.toNamed("/shakeScreen");
                      },
                      child: Text(
                        'Start your journey',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text:
                            'Your privacy matters to us. You can learn how we can handle your information when you use our Services by reading our ',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(height: 2.0, color: const Color.fromRGBO(82, 78, 88, 1)),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Privacy Policy',
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.green),
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
