import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/sidasHive.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SIDASScoreScreen extends StatefulWidget {
  const SIDASScoreScreen({Key? key}) : super(key: key);

  @override
  State<SIDASScoreScreen> createState() => _SIDASScoreScreenState();
}

class _SIDASScoreScreenState extends State<SIDASScoreScreen> {
  late final Box box;
  List list = [];

  @override
  void initState() {
    super.initState();
    box = Hive.box('sidas');
    list = box.values.toList();
    log('list ${list}');
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
            title: Text('Suicidal Ideation Scores',
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.neutralWhite01)),
            leading: BackButton(onPressed: () {
              Get.back();
            }),
            elevation: 1,
            backgroundColor: Colors.transparent),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: ListView(
              shrinkWrap: true,
              children: list.map((userone) {
                return Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xff3290FF).withOpacity(0.60),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4))),
                      margin: const EdgeInsets.symmetric(vertical: 30.0),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(userone.toString(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralWhite01)),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Your Suicidal Ideation score for this month',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralBlack02,
                                    fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 20),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: userone.score != -1
                                      ? userone.score.toString()
                                      : '--',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(
                                          fontFamily: 'Inconsolata',
                                          color: Theme.of(context)
                                              .colorScheme
                                              .accentBlue02)),
                              TextSpan(
                                  text: '/50',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(
                                          fontFamily: 'Inconsolata',
                                          color: Theme.of(context)
                                              .colorScheme
                                              .accentBlue04)),
                            ]),
                          ),
                          const SizedBox(height: 20),
                          userone.score >= 0
                              ? LinearPercentIndicator(
                                  lineHeight: 30,
                                  percent: (userone.score / 50),
                                  progressColor: Theme.of(context)
                                      .colorScheme
                                      .accentBlue02,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .accentBlue04,
                                  barRadius: const Radius.circular(4),
                                )
                              : const SizedBox(),
                          const SizedBox(height: 20),
                          Text(
                            userone.score > 21
                                ? 'High Ideation'
                                : 'Low Ideation',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralBlack02),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            userone.score > 21
                                ? 'Seek Treatment'
                                : 'Good job! Keep it up!',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralGray02),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList()),
        ),
      ),
    );
  }
}
