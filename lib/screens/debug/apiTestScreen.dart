import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:get/get.dart';

void main() {
  runApp(const GetMaterialApp(home: DebugScreen()));
}

class DebugScreen extends StatefulWidget {
  const DebugScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DebugState();
}

class DebugState extends State {
  final PageController _pageController = PageController();
  final lc = [TextEditingController(), TextEditingController()];

  handleLogin() async {
    var response = await UserProvider().login(LoginForm(lc[0].text, lc[1].text));
    log("test $response");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
