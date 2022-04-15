import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/widgets/StatisticsWidgets/monthWidget.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../apis/phqHive.dart';

class PHQScoreScreen extends StatefulWidget {
  const PHQScoreScreen({Key? key}) : super(key: key);

  @override
  State<PHQScoreScreen> createState() => _PHQScoreScreenState();
}

class _PHQScoreScreenState extends State<PHQScoreScreen> {
  late final Box box;
  List list = [];
  List entries = [];

  @override
  void initState() {
    super.initState();
    box = Hive.box('phq');
    list = box.values.toList();
    // log('list ${list.first.date}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/background_images/blue_background.png',
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            title: const Text(
              'PHQ9 Scores',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Proxima Nova',
                  fontWeight: FontWeight.w400),
            ),
            leading: BackButton(onPressed: () {
              Get.offAndToNamed('/statisticsScreen');
            }),
            elevation: 1,
            backgroundColor: Colors.transparent),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(shrinkWrap: true, children: [
            ElevatedButton(
                child: const Text('Log Box'),
                onPressed: () {
                  log('box ${list}');
                }),
            ElevatedButton(
                child: const Text('Add Month'),
                onPressed: () {
                  log('test');
                }),
            ElevatedButton(
                child: const Text('Delete scores'),
                onPressed: () {
                  box.deleteAll(box.keys);
                  log('box ${list}');
                }),
            ListView(
              shrinkWrap: true,
              children: list.map((userone) {
                return Container(
                  child: ListTile(
                    title: Text('test ${userone.date}'),
                    subtitle: Text("Address: "),
                  ),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  color: Colors.green[100],
                );
              }).toList(),
            )
          ]),
        ),
      ),
    );
  }
}

//                 MonthBar(date: 'January 2022'),
//                 Padding(
//                     padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
//                     child: ScoreCards(
//                       first: 21,
//                       second: 13,
//                     )),
//                 SizedBox(height: 20),

class ScoreCards extends StatelessWidget {
  final int first, second;
  const ScoreCards({
    Key? key,
    this.first = 0,
    this.second = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Your Average PHQ-9 score for this month',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: Theme.of(context).colorScheme.neutralBlack02,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: ((first + second) / 2).toStringAsFixed(1),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Theme.of(context).colorScheme.accentBlue02)),
              TextSpan(
                  text: '/27',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Theme.of(context).colorScheme.accentBlue04)),
            ]),
          ),
          const SizedBox(height: 20),
          LinearPercentIndicator(
            lineHeight: 30,
            percent: (((first + second) / 2) / 27),
            progressColor: Theme.of(context).colorScheme.accentBlue02,
            backgroundColor: Theme.of(context).colorScheme.accentBlue04,
            barRadius: const Radius.circular(4),
          ),
          const SizedBox(height: 20),
          Text(
            'High Ideation',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          const Divider(
            color: Color(0xffC4C4C4),
            thickness: 1,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('First Entry'), Text(first.toString() + '/27')],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Second Entry'), Text(second.toString() + '/27')],
          ),
        ],
      ),
    );
  }
}
