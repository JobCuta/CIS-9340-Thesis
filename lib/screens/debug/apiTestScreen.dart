// ignore: unnecessary_import
import 'dart:developer';
import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/apis/sidasHive.dart';
import 'package:flutter_application_1/apis/tableSecureStorage.dart';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import '../../apis/phqHive.dart';
import '../onboarding/intro/IntroductionScreen.dart';

Future<void> main() async {
  Hive.registerAdapter(phqHiveAdapter());
  Hive.registerAdapter(sidasHiveAdapter());
  await Hive.initFlutter();
  await Hive.openBox('sidas');
  await Hive.openBox('phq');
  runApp(DebugScreen());
}

class DebugScreen extends StatelessWidget {
  DebugScreen({Key? key}) : super(key: key);

  final PageController _pageController = PageController();
  final lc = [TextEditingController(), TextEditingController()];

  List list = [];

  handleLogin() async {
    var response =
        await UserProvider().login(LoginForm(lc[0].text, lc[1].text));
    log("test $response");
  }

  sortEntries() {
    List<List<dynamic>> splitMonths = [];
    var seenMonths = <DateTime>{};
    // number of months to divide entries by
    List uniqueMonths = list
        .where((entry) =>
            seenMonths.add(DateTime(entry.date.year, entry.date.month)))
        .toList();
    log('unqiue months $uniqueMonths');
    log('seen months $seenMonths');
    // loop through unique months as each card.
    // filter entries where date matches the unique month
    for (var date in seenMonths) {
      List entries = list
          .where((entry) =>
              (entry.date.year == date.year) && entry.date.month == date.month)
          .toList();
      splitMonths.add(entries);
    }
    log('splti months $splitMonths ${splitMonths[0][1].date} | ${splitMonths[1][0].date}');
  }

  @override
  Widget build(BuildContext context) {
    Math.Random random = Math.Random();
    Hive.openBox('sidas');

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
                        var phq = Hive.box('phq');
                        phqHive entry = phqHive(
                            index: -1,
                            date: DateTime(2022, 5, 15),
                            score: random.nextInt(27));
                        // Map scores = await UserProvider().createPHQ(entry);
                        // entry.index = scores["body"]["id"];
                        phq.add(entry);
                        log('created phq entry.');
                      }),
                  ElevatedButton(
                      child: const Text('Create SIDAS Entry'),
                      onPressed: () async {
                        var sidas = Hive.box('sidas');
                        sidasHive entry = sidasHive(
                            index: -1,
                            date: DateTime(2022, 5, 1),
                            answerValues: [],
                            score: random.nextInt(50));
                        sidas.add(entry);
                        // Map scores = await UserProvider().createSIDAS(entry);
                        // log('entry made? ${scores}');
                      }),
                  ElevatedButton(
                      child: const Text('Get PHQ9 Hive'),
                      onPressed: () async {
                        var phq = Hive.box('phq');
                        list = phq.values.toList();
                        log('phq ${phq.keys.toList()}');
                      }),
                  ElevatedButton(
                      child: const Text('Get SIDAS Hive'),
                      onPressed: () async {
                        var sidas = Hive.box('sidas');
                        list = sidas.values.toList();
                        log('sidas ${sidas.toMap()}');
                      }),
                  ElevatedButton(
                      child: const Text('Delete PHQ Hive'),
                      onPressed: () async {
                        var phq = Hive.box('phq');
                        phq.deleteAll(phq.keys);
                        log('phq ${phq.keys.toList()}');
                      }),
                  ElevatedButton(
                      child: const Text('Delete SIDAS Hive'),
                      onPressed: () async {
                        var sidas = Hive.box('sidas');
                        sidas.deleteAll(sidas.keys);
                        log('sidas ${sidas.keys.toList()}');
                      }),
                  ElevatedButton(
                      child: const Text('Group SIDAS Hive'),
                      onPressed: () async {
                        var sidas = Hive.box('sidas');
                        sortEntries();
                      }),
                  ElevatedButton(
                      child: const Text('Update First Time'),
                      onPressed: () async {
                        bool result = await UserProvider().firstLogin();
                      }),
                  ElevatedButton(
                      child: const Text('Save latest scores'),
                      onPressed: () async {
                        await TableSecureStorage.setLatestPHQ(
                            DateTime.now().toUtc().toString());
                        await TableSecureStorage.setLatestSIDAS(
                            DateTime.now().toUtc().toString());
                        log('saved, ${DateTime.now().toUtc().toString()}');
                      }),
                  ElevatedButton(
                      child: const Text('Check latest scores'),
                      onPressed: () async {
                        late String latestPhq = '', latestSidas = '';
                        await TableSecureStorage.getLatestPHQ()
                            .then((value) => latestPhq = value.toString());
                        await TableSecureStorage.getLatestSIDAS()
                            .then((value) => latestSidas = value.toString());
                        log('these dates $latestPhq, $latestSidas');
                      }),
                  ElevatedButton(
                      child: const Text('Update Database'),
                      onPressed: () async {
                        late String latestPhq = '';
                        await TableSecureStorage.getLatestPHQ().then((value) => latestPhq = value.toString());
                        List phqList = await UserProvider().phqScores();
                        log('list $phqList');
                        DateTime phqServer = DateFormat('dd/MM/yyyy HH:mm:ss').parse(phqList.first["date_created"]);
                        DateTime phqLocal = DateTime.parse(latestPhq);
                        phqList.first["date_created"] = phqServer.toUtc().toString();
                        log('these dates $phqServer | $phqLocal');
                        if (phqServer.isBefore(phqLocal)) {
                          log('server is outdated');
                          UserProvider().bulkPhqUpdate(phqList);
                        } else {}
                      }),
                ],
              );
            }),
      ),
    );
  }
}
