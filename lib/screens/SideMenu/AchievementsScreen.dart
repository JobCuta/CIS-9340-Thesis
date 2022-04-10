import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:flutter_application_1/controllers/settingsController.dart';
import 'package:flutter_application_1/screens/main/SideMenu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  final LevelController _levelController = Get.put(LevelController());
  final SettingsController _settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: const Text('Achievements'),
          primary: true,
          backgroundColor: Colors.transparent,
          elevation: 0),
      drawer: const SideMenu(),
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/background_images/orange_background.png'),
                      fit: BoxFit.cover))),
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      height: 200,
                      child: (_settingsController.imagePath.value != '')
                          ? CircleAvatar(
                              radius: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(160),
                                child: Image.file(
                                  File(_settingsController.imagePath.value),
                                  width: 160.0,
                                  height: 160.0,
                                  fit: BoxFit.cover,
                                ),
                              ))
                          : SvgPicture.asset(
                              'assets/images/default_user_image.svg',
                              width: 160),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Divider(
                        indent: 10,
                        endIndent: 10,
                        color: Colors.white,
                        thickness: 1.5,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text('Achievements',
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralWhite01,
                                  )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Current Level: Level ${_levelController.currentLevel.value}',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .sunflowerYellow01,
                                    )),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: LinearPercentIndicator(
                                barRadius: const Radius.circular(24),
                                curve: Curves.easeIn,
                                lineHeight: 25,
                                percent: _levelController.currentXp / 1000,
                                progressColor: Theme.of(context)
                                    .colorScheme
                                    .sunflowerYellow01,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .neutralWhite04,
                                animation: true,
                                animationDuration: 200,
                                animateFromLastPercent: true,
                                addAutomaticKeepAlive: true,
                              ),
                            ),
                            Text(
                              '${_levelController.currentXp} / ${_levelController.xpForNextLevel} to unlock next level',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralBlack02,
                                  ),
                            ),
                            const SizedBox(height: 7),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Continue Adventure',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .neutralBlack02,
                                        )),
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Go',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .neutralGray02)),
                                    WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Icon(
                                            Icons.keyboard_arrow_right_sharp,
                                            size: 30,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .neutralGray02))
                                  ]),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        achievementContainers(
                            'assets/achievements/general_adventure_achievements.svg',
                            'General Achievements',
                            '40',
                            '60'),
                        achievementContainers(
                            'assets/achievements/apayao_adventure_achievements.svg',
                            'Apayao Adventure',
                            '10',
                            '10')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        achievementContainers(
                            'assets/achievements/kalinga_adventure_achievements.svg',
                            'Kalinga Adventure',
                            '5',
                            '10'),
                        achievementContainers(
                            'assets/achievements/abra_adventure_achievements.svg',
                            'Abra Adventure',
                            '7',
                            '10'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        achievementContainers(
                            'assets/achievements/mtprovince_adventure_achievements.svg',
                            'Mt. Province Adventure',
                            '9',
                            '10'),
                        achievementContainers(
                            'assets/achievements/ifugao_adventure_achievements.svg',
                            'Ifugao Adventure',
                            '1',
                            '10'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        achievementContainers(
                            'assets/achievements/benguet_adventure_achievements.svg',
                            'Benguet Adventure',
                            '5',
                            '10'),
                        achievementContainers(
                            'assets/achievements/warrior_adventure_achievements.svg',
                            'Mini Games Warrior',
                            '3',
                            '10'),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  achievementContainers(path, String title, String noOfCurrAchievements,
      String noOfTotalAchievements) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.neutralWhite01,
                          Theme.of(context).colorScheme.sunflowerYellow04,
                        ],
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(path, width: 45, height: 45),
                  )),
              const SizedBox(height: 6.0),
              Text(title,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.neutralBlack02)),
              const SizedBox(height: 6.0),
              LinearPercentIndicator(
                barRadius: const Radius.circular(24),
                curve: Curves.easeIn,
                lineHeight: 10,
                percent: int.parse(noOfCurrAchievements) /
                    int.parse(noOfTotalAchievements),
                progressColor: Theme.of(context).colorScheme.intGreen05,
                backgroundColor: const Color(0xffC4C4C4),
                animation: true,
                animationDuration: 1500,
                animateFromLastPercent: true,
                addAutomaticKeepAlive: true,
              ),
              const SizedBox(height: 6.0),
              Text(noOfCurrAchievements + ' out of ' + noOfTotalAchievements,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.neutralBlack02))
            ],
          ),
        ),
      ),
    );
  }
}
