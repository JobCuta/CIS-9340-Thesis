import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/SideMenu/SideMenu.dart';
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

class _AdventureHomeScreenState extends State<AdventureHomeScreen> {
  final LevelController _levelController = Get.put(LevelController());
  final SettingsController _settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: const Text('Adventure Home'),
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
                        'assets/background_images/adventure_background.png',
                      ),
                      fit: BoxFit.cover))),
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          height: 200,
                          child: (_settingsController.imagePath.value != '')
                              ? CircleAvatar(
                                  radius: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
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
                        Visibility(
                          visible: _settingsController.framePath.value != '',
                          child: SvgPicture.asset(
                              _settingsController.framePath.value,
                              width: 160,
                              height: 160),
                        ),
                      ],
                    ),
                    const Divider(
                        color: Colors.white,
                        indent: 5,
                        endIndent: 5,
                        thickness: 2,
                        height: 25),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 15),
                        child: Wrap(
                          runSpacing: 10,
                          children: [
                            Text('Welcome, Adventurer!',
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        color: const Color(0xffFFC122),
                                        fontWeight: FontWeight.w600)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Current Level: Level ${_levelController.currentLevel.value}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .sunflowerYellow01,
                                        )),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: LinearPercentIndicator(
                                    barRadius: const Radius.circular(24),
                                    curve: Curves.easeIn,
                                    lineHeight: 20,
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
                                            .neutralGray02,
                                      ),
                                ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 10.0),
                              margin:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xffFF8A00).withOpacity(0.80),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12))),
                              child: Text(
                                  '"You may have to fight a battle more than once."\n - Margaret Thatcher',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .neutralWhite01,
                                          fontWeight: FontWeight.w400)),
                            ),
                            _buildFieldComponent(
                              title: 'Continue Adventure',
                              onTap: () {
                                Get.toNamed('/userJourney');
                              },
                            ),
                            Divider(
                              color:
                                  Theme.of(context).colorScheme.neutralWhite03,
                              height: 10,
                              thickness: 1,
                            ),
                            _buildFieldComponent(
                              title: 'View Achievements',
                              onTap: () {
                                Get.toNamed('/achievementsScreen');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildFieldComponent({title, onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.neutralBlack02)),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: 'Go',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.neutralGray02)),
              WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.keyboard_arrow_right_sharp,
                      color: Theme.of(context).colorScheme.neutralGray02))
            ]),
          ),
        ],
      ),
    );
  }
}
