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

final LevelController _levelController = Get.put(LevelController());

class _LevelWidgetsState extends State<LevelWidgets> {
  Map<dynamic, dynamic> experiences = _levelController.accomplishedWithXp.value;

  @override
  Widget build(BuildContext context) {
    print("EXPERIENCES = " + experiences.toString());
    print("EXPERIENCES SIZE = " + experiences.length.toString());
    List<dynamic> experienceKeys = experiences.keys.toList();
    // _levelController.clearMapOfAccomplishedWithXp();

    return Scaffold(
      backgroundColor: Colors.transparent,
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
                  child: Text('Congratulations',
                      style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.accentBlue04))),
              const SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(
                  'Your just gained your first experience!',
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
                  String key = experienceKeys[index].toString();
                  int xp = experiences[key] as int;
                  print ("KEY = $key && XP = $xp");

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(key,
                                style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.neutralBlack02),
                            ),
                            Text(xp.toString() + ' ' + 'xp',
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.accentBlue04),
                            ),
                          ],
                        ),

                        const Divider(
                          color: Color(0xffF0F1F1),
                          height: 25,
                          thickness: 1,
                        ),
                      ],
                    ),
                  );
                }
              ),

              Text(_levelController.currentLevel.value.toString(),
                  style: Theme.of(context).textTheme.headline1?.copyWith(fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.accentBlue04),
              ),
              Text('LEVEL',
                  style: Theme.of(context).textTheme.headline2?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.accentIndigo04),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearPercentIndicator(
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  curve: Curves.easeIn,
                  lineHeight: 35,
                  percent: _levelController.currentXp / 1000,
                  progressColor:
                      Theme.of(context).colorScheme.accentBlue02,
                  backgroundColor:
                      Theme.of(context).colorScheme.neutralWhite03,
                  animation: true,
                  animationDuration: 1000,
                  animateFromLastPercent: true,
                  addAutomaticKeepAlive: true,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _levelController.currentXp.toString() + "/" + _levelController.xpForNextLevel().toString() + " till next level up",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.accentBlue04),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 50.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: GetBuilder<LevelController>(
                        builder: (value) => ElevatedButton(
                            child: Text(
                              'Great!',
                              style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.all(10),
                              primary:const Color(0xffFFBE18)
                            ),
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