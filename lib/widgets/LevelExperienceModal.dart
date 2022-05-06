import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

void main() => runApp(const LevelWidgets());

class LevelWidgets extends StatefulWidget {
  const LevelWidgets({Key? key}) : super(key: key);

  @override
  State<LevelWidgets> createState() => _LevelWidgetsState();
}

class _LevelWidgetsState extends State<LevelWidgets> {
  // List<Experience> experiences = List.from(_levelController.experiences.value);
  final LevelController _levelController = Get.put(LevelController());

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> experiences = Map.from(_levelController.accomplishedWithXp.value);

    if (experiences.isEmpty) {
      experiences = {_levelController.taskName.value : _levelController.taskXp.value};
    }
    print("ACCOMPLISHED (in Modal) = " + _levelController.accomplishedWithXp.value.toString());
    print("EXPERIENCES = " + experiences.toString());
    print("EXPERIENCES SIZE = " + experiences.length.toString());
    List<dynamic> experienceKeys = experiences.keys.toList();
    _levelController.clearMapOfAccomplishedWithXp();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.close,
        //     color: Colors.black,
        //   ),
        //   onPressed: () {
        //     Get.back();
        //   },
        // ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                  child: Text('Congratulations',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.accentBlue02))),
              const SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(
                  'Your just gained experience!',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.accentBlue04),
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.neutralWhite03,
                height: 25,
                thickness: 1,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: experiences.length,
                  itemBuilder: (context, index) {
                    String key = experienceKeys[index].toString();
                    int xp = experiences[key] as int;
                    print("KEY = $key && XP = $xp");

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Column(
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
                          Divider(
                            color: Theme.of(context).colorScheme.neutralWhite03,
                            height: 25,
                            thickness: 1,
                          ),
                        ],
                      ),
                    );
                  }),
              Text(
                _levelController.currentLevel.value.toString(),
                style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.accentBlue04),
              ),
              Text(
                'LEVEL',
                style: Theme.of(context).textTheme.headline2?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.accentIndigo04),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearPercentIndicator(
                  barRadius: const Radius.circular(24),
                  curve: Curves.easeIn,
                  lineHeight: 30,
                  percent: _levelController.currentXp / 1000,
                  progressColor: Theme.of(context).colorScheme.accentBlue02,
                  backgroundColor: Theme.of(context).colorScheme.neutralWhite04,
                  animation: true,
                  animationDuration: 1000,
                  animateFromLastPercent: true,
                  addAutomaticKeepAlive: true,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    _levelController.currentXp.toString() +
                        "/" +
                        _levelController.xpForNextLevel().toString() +
                        " till next level up",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.accentBlue04),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: GetBuilder<LevelController>(
                      builder: (value) => ElevatedButton(
                          child: Text(
                            'Great!',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: const EdgeInsets.all(10),
                              primary: const Color(0xffFFBE18)),
                          onPressed: () {
                            Get.back();
                          }),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
