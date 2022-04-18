import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

void main() => runApp(const LevelUpRewardWidgets());

class LevelUpRewardWidgets extends StatefulWidget {
  const LevelUpRewardWidgets({Key? key}) : super(key: key);

  @override
  State<LevelUpRewardWidgets> createState() => _LevelUpRewardWidgetsState();
}

final LevelController _levelController = Get.put(LevelController());

class _LevelUpRewardWidgetsState extends State<LevelUpRewardWidgets> {
  Map<dynamic, dynamic> levelUpRewards = _levelController.levelUpRewards.value;
  int currentLevel = _levelController.currentLevel.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: true,
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
                  'You leveled up to level $currentLevel',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.accentBlue04),
                ),
              ),
              SvgPicture.asset(
                  'assets/images/levelUp.svg',
              ),
              Center(
                child: Text(
                  "Here's what you unlock",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.accentBlue04),
                ),
              ),
              
              // TODO: place list of rewards here

              const SizedBox(height: 20.0),
             
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
