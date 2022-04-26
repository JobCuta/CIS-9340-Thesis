import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../apis/phqHive.dart';

class PHQScoreScreen extends StatefulWidget {
  const PHQScoreScreen({Key? key}) : super(key: key);

  @override
  State<PHQScoreScreen> createState() => _PHQScoreScreenState();
}

class _PHQScoreScreenState extends State<PHQScoreScreen> {
  late final Box box;
  List list = [], uniqueMonths = [];
  List<List<dynamic>> splitMonths = [];

  sortEntries() {
    var seenMonths = <DateTime>{};
    // number of months to divide entries by
    uniqueMonths = list
        .where((entry) =>
            seenMonths.add(DateTime(entry.date.year, entry.date.month)))
        .toList();

    // loop through unique months as each card.
    // filter entries where date matches the unique month
    for (var date in seenMonths) {
      List entries = list
          .where((entry) =>
              (entry.date.year == date.year) && entry.date.month == date.month)
          .toList();
      splitMonths.add(entries);
    }
    // final result is in splitMonths
    log('split months $splitMonths}');
  }

  @override
  void initState() {
    super.initState();
    box = Hive.box('phq');
    list = box.values.toList();
    sortEntries();
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
              Get.back();
            }),
            elevation: 1,
            backgroundColor: Colors.transparent),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            child: ListView(
              shrinkWrap: true,
              children: splitMonths.map((month) {
                log('user $month');
                return Column(children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: ScoreCards(
                        lists: month,
                      )),
                  const SizedBox(height: 20),
                ]);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class ScoreCards extends StatelessWidget {
  final List lists;
  const ScoreCards({
    Key? key,
    required this.lists,
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
            DateFormat("MMMM-yyyy").format(lists[0].date).toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: Theme.of(context).colorScheme.neutralBlack02,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Color(0xffC4C4C4),
            thickness: 1,
          ),
          const SizedBox(
            height: 10,
          ),
          for (phqHive item in lists)
            Container(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: DateFormat("dd, ")
                                .format(item.date)
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralBlack04)),
                        TextSpan(
                            text: DateFormat("EEEE")
                                .format(item.date)
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .accentBlue04))
                      ]),
                    ),
                    item.score != -1
                        ? RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: item.score.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .accentBlue02)),
                              TextSpan(
                                  text: ' / 27',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .accentBlue04))
                            ]),
                          )
                        : InkWell(
                            onTap: () {
                              // Get.toNamed('/phqsomething');
                              log('missing');
                            },
                            child: Text('Missing',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .accentRed03)),
                          ),
                  ],
                ))
        ],
      ),
    );
  }
}
