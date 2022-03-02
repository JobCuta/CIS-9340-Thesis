import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:get/get.dart';

import '../onboarding/intro/IntroductionScreen.dart';

void main() {
  runApp(DebugScreen());
}

class DebugScreen extends StatelessWidget {

  DebugScreen({Key? key}) : super(key: key);

  final PageController _pageController = PageController();
  final lc = [TextEditingController(), TextEditingController()];

  handleLogin() async {
    var response = await UserProvider().login(LoginForm(lc[0].text, lc[1].text));
    log("test $response");
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kasiyanna App',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/introScreen', page: () => const IntroductionScreen()),
      ],
      home: Scaffold(
        body: PageView.builder(
            controller: _pageController,
            itemBuilder: (context, position) {
              return Column(
                children: [
                  const Text("Login"),
                  TextField(
                    controller: lc[0],
                  ),
                  TextField(
                    controller: lc[1],
                  ),
                  TextButton(
                      onPressed: () {
                        handleLogin();
                      },
                      child: const Text("Submit"))
                ],
              );
            }),
      ),
    );
  }
}
