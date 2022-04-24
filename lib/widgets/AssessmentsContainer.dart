import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/phqHive.dart';
import 'package:flutter_application_1/apis/phqHiveObject.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/phqController.dart';
import 'package:flutter_application_1/controllers/sidasController.dart';
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
  int daysLeft = -1;
  late Box box;

  final now = DateTime.now();
  var latestEntry;

  @override
  void initState() {
    super.initState();
    if (widget.phq) {
      boxName = 'phq';
      title = 'PHQ9';
      prevAssessRoute = '/phqStatScreen';
      takeAssessRoute = '/phqScreen';
    } else {
      boxName = 'sidas';
      title = 'SIDAS';
      prevAssessRoute = '/sidasStatScreen';
      takeAssessRoute = '/sidasScreen';
    }
    box = Hive.box(boxName);
    if (box.isNotEmpty) {
      if (widget.phq) {
        log('keys? ${box.keys}');
        var monthKey = box.keys.last;
        phqHive latestMonth = box.get(monthKey);
        log('latest month ${latestMonth.assessments.last.score}');
        List<phqHiveObj> assessments = latestMonth.assessments;
        log('assessments ${assessments.first.score}');
        latestEntry = assessments.first;
      } else {
        var monthKey = box.keys.last;
        latestEntry = box.get(monthKey);
      }
    }
    daysLeft = latestEntry.date.difference(now).inDays;
    log('how am I here ${latestEntry.score}');
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
              Text('Upcoming $title Assessment: ${DateFormat("MMMM-dd").format(latestEntry.date)}',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: daysLeft > 1
                          ? Theme.of(context).colorScheme.accentBlue02
                          : Theme.of(context).colorScheme.sunflowerYellow01)),
              const SizedBox(
                height: 10,
              ),
              Text(daysLeft != 0 ? 'Due in $daysLeft day/s' : 'Your $title assessment is due today',
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
                  if (daysLeft < 1 || latestEntry.score == -1) {
                    Get.toNamed(takeAssessRoute, arguments: {
                      'home': '/homepage',
                      'key': latestEntry.date.month.toString() + '-' + latestEntry.date.year.toString()
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Take Assessment Now',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.neutralBlack02)),
                    daysLeft < 1
                        ? latestEntry.score == -1
                            ? RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Go',
                                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).colorScheme.accentBlue04)),
                                  WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Icon(Icons.keyboard_arrow_right_sharp,
                                          color: Theme.of(context).colorScheme.accentBlue04))
                                ]),
                              )
                            : RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Completed ',
                                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).colorScheme.neutralGray02)),
                                  WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child:
                                          Icon(Icons.check_circle, color: Theme.of(context).colorScheme.accentGreen02))
                                ]),
                              )
                        : Text('Not Yet!',
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralGray02))
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
                    textAlign: TextAlign.center,
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
