import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/dailyController.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:flutter_application_1/screens/SideMenu/SideMenu.dart';
import 'package:get/get.dart';

class WellnessExercisesScreen extends StatefulWidget {
  const WellnessExercisesScreen({Key? key}) : super(key: key);

  @override
  State<WellnessExercisesScreen> createState() =>
      _WellnessExercisesScreenState();
}

class _WellnessExercisesScreenState extends State<WellnessExercisesScreen> {
  DailyController _dailyController = Get.put(DailyController());
  LevelController _levelController = Get.put(LevelController());

  @override
  Widget build(BuildContext context) {
    var breathing = [
      'assets/images/breathing.svg',
      'Take a minute to breathe and meditate',
      'Meditating refreshes your mind and readies you for anything.',
      'Breathing'
    ];
    var meditation = [
      'assets/images/meditating.svg',
      'Notice your surroundings, relax your mind and body as you do so',
      'Being aware of your surroundings helps your mind and body focus more!',
      'Meditating'
    ];
    var walking = [
      'assets/images/walking.svg',
      'Pace around your environment and clear you mind',
      'Meditating as you walk helps reduce stress and anxiety!',
      'Walking'
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: const Text('Wellness Exercises'),
          primary: true,
          backgroundColor: Colors.transparent,
          elevation: 0),
      drawer: const SideMenu(),
      body: Stack(children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/background_images/orange_background.png',
                    ),
                    fit: BoxFit.cover))),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Wrap(
              runSpacing: 5,
              children: [
                Text('Choose an exercise you want',
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffF8A13C))),
                Text('Open your mind, relieve your body',
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.neutralBlack02)),
                Divider(
                  color: Theme.of(context).colorScheme.neutralWhite03,
                  height: 25,
                  thickness: 1,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(
                      '/exerciseScreen',
                      arguments: {
                        "assetImage": breathing[0],
                        "prompt": breathing[1],
                        "reason": breathing[2],
                        "type": breathing[3],
                        "initial?": false
                      },
                    );
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          spacing: 5,
                          direction: Axis.vertical,
                          children: [
                            Text('Breathing Exercise',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralBlack02)),
                            Text("Relax and lower your body's stress",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralGray02)),
                          ],
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Go',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralGray02)),
                            WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(Icons.keyboard_arrow_right_sharp,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralGray02))
                          ]),
                        )
                      ]),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.neutralWhite03,
                  height: 25,
                  thickness: 1,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(
                      '/exerciseScreen',
                      arguments: {
                        "assetImage": walking[0],
                        "prompt": walking[1],
                        "reason": walking[2],
                        "type": walking[3],
                        "initial?": false
                      },
                    );
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          spacing: 5,
                          direction: Axis.vertical,
                          children: [
                            Text('Walking Meditation',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralBlack02)),
                            Text("Match your breathing with a steady pace",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralGray02)),
                          ],
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Go',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralGray02)),
                            WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(Icons.keyboard_arrow_right_sharp,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralGray02))
                          ]),
                        )
                      ]),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.neutralWhite03,
                  height: 25,
                  thickness: 1,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(
                      '/exerciseScreen',
                      arguments: {
                        "assetImage": meditation[0],
                        "prompt": meditation[1],
                        "reason": meditation[2],
                        "type": meditation[3],
                        "initial?": false
                      },
                    );
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          spacing: 5,
                          direction: Axis.vertical,
                          children: [
                            Row(
                              children: [
                                Text('Grounding Exercise',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .neutralBlack02)),
                              ],
                            ),
                            Text("Pull away from all the noise in your mind",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralGray02)),
                          ],
                        ),
                        RichText(
                          text: TextSpan(children: <InlineSpan>[
                            TextSpan(
                                text: 'Go',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralGray02)),
                            WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(Icons.keyboard_arrow_right_sharp,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralGray02))
                          ]),
                        )
                      ]),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
