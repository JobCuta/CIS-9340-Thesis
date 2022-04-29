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
            title: Text(
              'PHQ9 Scores',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.neutralWhite01),
            ),
            leading: BackButton(onPressed: () {
              Get.back();
            }),
            elevation: 1,
            backgroundColor: Colors.transparent),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: ListView(
            shrinkWrap: true,
            children: splitMonths.map((month) {
              return Column(children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xff3290FF).withOpacity(0.60),
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('${month[0]}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.neutralWhite01)),
                ),
                ScoreCards(
                  lists: month,
                ),
              ]);
            }).toList(),
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
    double average = 0;

    for (phqHive item in lists) {
      average += item.score;
    }
    average /= lists.length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Your PHQ-9 score for this month',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  color: Theme.of(context).colorScheme.neutralBlack02,
                  fontWeight: FontWeight.w600),
            ),
          ),
          for (int i = 0; i < lists.length; i++)
            Container(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${getPosition(i)} Entry',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).colorScheme.neutralGray04)),
                    lists[i].score != -1
                        ? RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: lists[i].score.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .accentBlue02)),
                              TextSpan(
                                  text: ' / 27',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
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
                )),
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
          Text(getMainDescription(average),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.neutralBlack02)),
          const SizedBox(
            height: 8,
          ),
          Text(getDescription(average),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.neutralGray02))
        ],
      ),
    );
  }

  String getPosition(index) {
    switch (index) {
      case 0:
        return 'First';
      case 1:
        return 'Second';
      case 2:
        return 'Third';
      default:
        return '';
    }
  }

  String getMainDescription(average) {
    return average >= 20
        ? 'Severe Depression'
        : average >= 15
            ? 'Moderately Severe Depression'
            : average >= 10
                ? 'Moderate Depression'
                : average >= 5
                    ? 'Mild Depression'
                    : 'None - Minimal Depression';
  }

  String getDescription(average) {
    return average >= 20
        ? 'If you feel that your mental wellbeing is in danger, we recommend seeking therapy and consider pharmacotherapy. Seeking a case manager, therapist, or social worker is also recommended. '
        : average >= 15
            ? 'If you feel that your mental wellbeing is in danger, we recommend seeking therapy and consider pharmacotherapy. Seeking a case manager, therapist, or social worker is also recommended. '
            : average >= 10
                ? 'If you feel that your mental wellbeing is in danger, we recommend seeking therapy and consider pharmacotherapy. '
                : average >= 5
                    ? 'Watchful waiting; daily use of the app is highly recommended to further monitor and update the status of your mental well-being. '
                    : 'No treatment needed.';
  }
}
