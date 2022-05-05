import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../SideMenu/SideMenu.dart';

class MinigamesScreen extends StatefulWidget {
  const MinigamesScreen({Key? key}) : super(key: key);

  @override
  State<MinigamesScreen> createState() => _MinigamesScreenState();
}

class _MinigamesScreenState extends State<MinigamesScreen> {
  final LevelController _levelController = Get.put(LevelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: const Text('Minigames'),
            primary: true,
            backgroundColor: Colors.transparent,
            elevation: 0),
        drawer: const SideMenu(),
        body: Stack(children: [
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 15),
                                  child: Wrap(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            bottom: 20, left: 50, right: 50),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                            'Take some time and play some minigames to increase your level!',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xffFFC122),
                                                )),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              'LEVEL ${_levelController.currentLevel.value}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .neutralGray03,
                                                  )),
                                          Text(
                                              '${_levelController.currentXp} / ${_levelController.xpForNextLevel} XP',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .neutralGray03,
                                                  )),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: LinearPercentIndicator(
                                          barRadius: const Radius.circular(24),
                                          curve: Curves.easeIn,
                                          lineHeight: 15,
                                          percent:
                                              _levelController.currentXp / 1000,
                                          progressColor: Theme.of(context)
                                              .colorScheme
                                              .sunflowerYellow01,
                                          backgroundColor:
                                              const Color(0xffFF9B26),
                                          animation: true,
                                          animationDuration: 200,
                                          animateFromLastPercent: true,
                                          addAutomaticKeepAlive: true,
                                        ),
                                      ),
                                    ],
                                  ))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              gameContainer(
                                  title: 'Sudoku',
                                  image: 'assets/images/sudoku.svg',
                                  onClicked: () => Get.toNamed('/sudoku',
                                      arguments: {'route': '/minigames'})),
                              gameContainer(
                                  title: 'Memory',
                                  image: 'assets/images/memory.svg',
                                  onClicked: () =>
                                      Get.toNamed('/memoryGameScreen'))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              gameContainer(
                                title: 'Coming\nSoon',
                                image: '',
                              ),
                              gameContainer(
                                title: 'Coming\nSoon',
                                image: '',
                              )
                            ],
                          )
                        ],
                      ))))
        ]));
  }

  gameContainer({
    required String title,
    required String image,
    VoidCallback? onClicked,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onClicked,
        child: Container(
          constraints: BoxConstraints(minHeight: 160),
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(4)),
          child: Wrap(
            runSpacing: 10,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('PLAY',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          decoration: TextDecoration.underline,
                          decorationThickness: 3,
                          fontWeight: FontWeight.w600,
                          color: title != 'Coming\nSoon'
                              ? Theme.of(context).colorScheme.accentBlue02
                              : Theme.of(context).colorScheme.neutralWhite04)),
                  Visibility(
                      visible: title != 'Coming\nSoon',
                      child: Text('+ 50xp',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .colorScheme
                                  .neutralWhite04)))
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(title,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.neutralBlack02)),
              ),
              Visibility(
                  visible: title != 'Coming\nSoon',
                  child: SvgPicture.asset(image))
            ],
          ),
        ),
      ),
    );
  }
}
