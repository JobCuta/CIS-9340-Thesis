import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../controllers/levelController.dart';
import '../../controllers/settingsController.dart';

class AdventureHomeScreen extends StatefulWidget {
  const AdventureHomeScreen({key}) : super(key: key);

  @override
  State<AdventureHomeScreen> createState() => _AdventureHomeScreenState();
}

class _AdventureHomeScreenState extends State<AdventureHomeScreen>{
  final LevelController _levelController = Get.put(LevelController());
  final SettingsController _settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_images/adventure_background.png',),
                  fit: BoxFit.cover))
            ),

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
                  const SizedBox(height: 10.0),
                  const Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  const SizedBox(height: 10.0),
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
                          Text('Welcome, Adventurer!',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.subtitle1?.copyWith(color: const Color(0xffFFC122), fontWeight: FontWeight.w600)),
                          const SizedBox(height: 12),
                          Text(
                              'Current Level: Level ${_levelController.currentLevel.value}',
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.sunflowerYellow01,)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: LinearPercentIndicator(
                              barRadius: const Radius.circular(24),
                              curve: Curves.easeIn,
                              lineHeight: 25,
                              percent: _levelController.currentXp / 1000,
                              progressColor: Theme.of(context).colorScheme.sunflowerYellow01,
                              backgroundColor: Theme.of(context).colorScheme.neutralWhite04,
                              animation: true,
                              animationDuration: 200,
                              animateFromLastPercent: true,
                              addAutomaticKeepAlive: true,
                            ),
                          ),
                          Text(
                            '${_levelController.currentXp} / ${_levelController.xpForNextLevel} to unlock next level',
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.neutralBlack02,),
                          ),
                          const SizedBox(height: 7),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                            decoration: const BoxDecoration(
                                color: Color(0xffFF8A00),
                                borderRadius: BorderRadius.all(Radius.circular(4))),
                            child:Text('"You may have to fight a battle more than once."- Margaret Thatcher',
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400)),
                          ),
                          const SizedBox(height: 7),
                          const Divider(
                            color: Color(0xffF0F1F1),
                            height: 25,
                            thickness: 1,
                          ),
                          InkWell(
                            onTap: () {
                              Get.offAndToNamed('/userJourney');
                            },
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Continue to Adventure',
                                    style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.neutralBlack02,)),
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Go',
                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w700,
                                            color: Theme.of(context).colorScheme.neutralGray02)),
                                    WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Icon(Icons.keyboard_arrow_right_sharp,
                                            size: 20,
                                            color: Theme.of(context).colorScheme.neutralGray02))
                                  ]),
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            color: Color(0xffF0F1F1),
                            height: 25,
                            thickness: 1,
                          ),
                          InkWell(
                            onTap: () {
                              Get.offAndToNamed('/achievementsScreen');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('View Achievements',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))),
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Go',
                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w700,
                                            color: Theme.of(context).colorScheme.neutralGray02)),
                                    WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Icon(Icons.keyboard_arrow_right_sharp,
                                            size: 20,
                                            color: Theme.of(context).colorScheme.neutralGray02))
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            ],
          ),
        ),),
        ),
      ],),
    );
  }
}
