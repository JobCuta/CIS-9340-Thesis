import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/phqHive.dart';
import 'package:flutter_application_1/apis/phqHiveObject.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:hive/hive.dart';

class AssessmentsContainer extends StatefulWidget {
  final bool phq;
  const AssessmentsContainer({Key? key, required this.phq}) : super(key: key);

  @override
  State<AssessmentsContainer> createState() => _AssessmentsContainerState();
}

class _AssessmentsContainerState extends State<AssessmentsContainer> {
  String boxName = '', title = '', route = '';
  late Box box;

  final now = DateTime.now();
  var latestEntry;

  @override
  Future<void> initState() async {
    // super.initState();
    // if (widget.phq) {
    //   boxName = 'phq';
    //   title = 'PHQ9';
    //   route = '/phqScreen';
    // } else {
    //   boxName = 'sidas';
    //   title = 'SIDAS';
    //   route = '/sidasScreen';
    // }
    // box = Hive.box(boxName);
    // if (widget.phq) {
    //   var monthKey = box.keys.first;
    //   var latestMonth = box.get(monthKey);
    //   List<phqHiveObj> assessments = latestMonth.assessments;
    //   latestEntry = assessments.first;
    // } else {
    //   var monthKey = box.keys.first;
    //   latestEntry = box.get(monthKey);
    // }
    // log('how am I here $latestEntry');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text('Upcoming $title Assessment'),
        Text('Due in ${now.day} day/s'),
        Divider(
          color: Theme.of(context).colorScheme.neutralWhite03,
          height: 25,
          thickness: 1,
        ),
        const InkWell(
          child: Text('Show previous assessments'),
        )
      ],
    ));
  }
}
