// ignore: unnecessary_import
import 'dart:developer';
import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/apis/phqHiveObject.dart';
import 'package:flutter_application_1/apis/sidasHive.dart';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../apis/phqHive.dart';
import '../onboarding/intro/IntroductionScreen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(phqHiveAdapter());
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
    Math.Random random = Math.Random();

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
                      child: const Text("Submit")),
                  ElevatedButton(
                      child: const Text('Get PHQ9 Scores'),
                      onPressed: () {
                        var scores = UserProvider().phqScores();
                        log('scores $scores');
                      }),
                  ElevatedButton(
                      child: const Text('Get SIDAS Scores'),
                      onPressed: () {
                        var scores = UserProvider().sidasScores();
                        log('scores $scores');
                      }),
                  ElevatedButton(
                      child: const Text('Create PHQ9 Entry'),
                      onPressed: () async {
                        phqHiveObj entry = phqHiveObj(date: DateTime.now(), score: random.nextInt(27));
                        bool scores = await UserProvider().createPHQ(entry);
                        log('entry made? $scores');
                      }),
                  ElevatedButton(
                      child: const Text('Create SIDAS Entry'),
                      onPressed: () async {
                        sidasHive entry = sidasHive(date: DateTime.now(), answerValues: [], sum: random.nextInt(50));
                        bool scores = await UserProvider().createSIDAS(entry);
                        log('entry made? ${scores}');
                      }),
                  ElevatedButton(
                      child: const Text('Get PHQ9 Hive'),
                      onPressed: () async {
                        var phq = await Hive.openLazyBox('phq');
                        log('phq ${phq.keys.toList()}');
                      }),
                  ElevatedButton(
                      child: const Text('Get SIDAS Hive'),
                      onPressed: () async {
                        var sidas = await Hive.openLazyBox('sidas');
                        log('sidas ${sidas.keys.toList()}');
                      }),
                  ElevatedButton(
                      child: const Text('Delete PHQ Hive'),
                      onPressed: () async {
                        var phq = await Hive.openLazyBox('phq');
                        phq.deleteAll(phq.keys);
                        log('phq ${phq.keys.toList()}');
                      }),
                  ElevatedButton(
                      child: const Text('Delete SIDAS Hive'),
                      onPressed: () async {
                        var sidas = await Hive.openLazyBox('sidas');
                        sidas.deleteAll(sidas.keys);
                        log('sidas ${sidas.keys.toList()}');
                      }),
                ],
              );
            }),
      ),
    );
  }
}
