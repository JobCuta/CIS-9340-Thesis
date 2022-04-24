import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/dailyController.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:get/get.dart';

void main() => runApp(const LevelTasksTodayModal());

class LevelTasksTodayModal extends StatelessWidget {
  const LevelTasksTodayModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: LevelTasksTodayWidgets(),
    );
  }
}

class LevelTasksTodayWidgets extends StatefulWidget {
  const LevelTasksTodayWidgets({Key? key}) : super(key: key);

  @override
  State<LevelTasksTodayWidgets> createState() => _LevelTasksTodayWidgetsState();
}

class _LevelTasksTodayWidgetsState extends State<LevelTasksTodayWidgets> {
  final LevelController _levelController = Get.put(LevelController());
  final DailyController _dailyController = Get.put(DailyController());
  Map<String, int> experiences = {};

  @override
  Widget build(BuildContext context) {
    if (!_dailyController.isDailyEntryDone.value)
      experiences.putIfAbsent('Daily Entry', () => 50);
    if (!_dailyController.isDailyExerciseDone.value)
      experiences.putIfAbsent('Exercise', () => 100);
    print("SHOW AVAILABLE TASKS = " + experiences.toString());
    print("AVILABLE TASKS SIZE = " + experiences.length.toString());
    List<String> experienceKeys = experiences.keys.toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                  child: Text('Hey there!',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.accentBlue04))),
              const SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(
                  "Here's what we can do today!",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.accentBlue04),
                ),
              ),
              const Divider(
                color: Color(0xffF0F1F1),
                height: 25,
                thickness: 1,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: experiences.length,
                  itemBuilder: (context, index) {
                    String key = experienceKeys[index];
                    int xp = experiences[key] as int;

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              key,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralBlack02),
                            ),
                            Text(
                              xp.toString() + ' ' + 'xp',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .accentBlue04),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Color(0xffF0F1F1),
                          height: 25,
                          thickness: 1,
                        ),
                      ],
                    );
                  }),
              Container(
                padding: const EdgeInsets.only(top: 25.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: GetBuilder<LevelController>(
                        builder: (value) => ElevatedButton(
                            child: Text(
                              'Got it!',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.all(10),
                                primary: const Color(0xffFFBE18)),
                            onPressed: () {
                              Get.back();
                            }),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
