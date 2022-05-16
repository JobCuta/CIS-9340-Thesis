import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/phqHive.dart';
import 'package:flutter_application_1/apis/sidasHive.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class AssessmentsContainer extends StatefulWidget {
  final bool phq;
  const AssessmentsContainer({Key? key, required this.phq}) : super(key: key);

  @override
  State<AssessmentsContainer> createState() => _AssessmentsContainerState();
}

class _AssessmentsContainerState extends State<AssessmentsContainer> {
  String boxName = '', title = '', prevAssessRoute = '', takeAssessRoute = '';
  late DateTime next = DateTime(0);
  int daysLeft = -1;

  var now = DateTime.now();
  var latestEntry;

  @override
  void initState() {
    super.initState();
    if (widget.phq) {
      boxName = 'phq';
      title = 'PHQ-9 Entry';
      prevAssessRoute = '/phqStatScreen';
      takeAssessRoute = '/phqScreen';
    } else {
      boxName = 'sidas';
      title = 'SIDAS';
      prevAssessRoute = '/sidasStatScreen';
      takeAssessRoute = '/sidasScreen';
    }
    Box box = Hive.box(boxName);
    // log('box info $boxName ${box.isEmpty} | ${box.length}');
    if (box.isNotEmpty) {
      var monthKey = box.keys.last;
      latestEntry = box.get(monthKey);
      if (widget.phq) {
        var p = latestEntry as phqHive;
        var pDate = DateTime(p.date.year, p.date.month, p.date.day);
        next = pDate.add(const Duration(days: 14));
      } else {
        var s = latestEntry as sidasHive;
        next = DateTime(s.date.year, s.date.month + 1, s.date.day);
      }
      // to only use the year, month, and day in the difference
      now = DateTime(now.year, now.month, now.day);
      daysLeft = next.difference(now).inDays;
      log('how am I here ${latestEntry.score}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.neutralWhite01,
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RichText(
                  text: daysLeft >= 2
                      ? TextSpan(
                          text: 'Upcoming Assessment: ${DateFormat("MMMM d").format(next)}',
                          style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.accentBlue02))
                      : daysLeft >= 0
                          ? TextSpan(children: <InlineSpan>[
                              TextSpan(
                                  text: 'Upcoming Assessment: ${DateFormat("MMMM d").format(next)} ',
                                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).colorScheme.sunflowerYellow01)),
                              WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(Icons.error, color: Theme.of(context).colorScheme.anzac01))
                            ])
                          : TextSpan(
                              text: 'Missing Assessment: ${DateFormat("MMMM d").format(next)}',
                              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                                  fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.accentRed02))),
              const SizedBox(
                height: 10,
              ),
              Text(
                  daysLeft >= 2
                      ? 'Due in $daysLeft days'
                      : daysLeft == 1
                          ? 'Your $title assessment is due tomorrow'
                          : daysLeft == 0
                              ? 'Your $title assessment is due today'
                              : 'It seems you’ve missed your assessment. Take the assessment now for accurate tracking of your mental wellness. ',
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.neutralGray02)),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  if (daysLeft <= 1 || latestEntry.score == -1) {
                    Get.toNamed(takeAssessRoute, arguments: {
                      'home': '/homepage',
                      'key': latestEntry.date.month.toString() + '-' + latestEntry.date.year.toString()
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.neutralBlack02)),
                    daysLeft >= 2
                        ? Text('Not Yet!',
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralGray02))
                        : daysLeft >= 0
                            ? RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Go',
                                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                          fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.anzac01)),
                                  WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Icon(Icons.keyboard_arrow_right_sharp,
                                          color: Theme.of(context).colorScheme.anzac01))
                                ]),
                              )
                            : RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Go',
                                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).colorScheme.accentRed02)),
                                  WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Icon(Icons.keyboard_arrow_right_sharp,
                                          color: Theme.of(context).colorScheme.accentRed02))
                                ]),
                              )
                  ],
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.neutralWhite03,
                height: 25,
                thickness: 1,
              ),
              InkWell(
                child: Text('Show previous assessments',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.neutralGray03)),
                onTap: () {
                  Get.toNamed(prevAssessRoute);
                },
              )
            ],
          )),
    );
  }
}
