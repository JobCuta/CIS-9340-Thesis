import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WellnessExercisesScreen extends StatefulWidget {
  const WellnessExercisesScreen({Key? key}) : super(key: key);

  @override
  State<WellnessExercisesScreen> createState() =>
      _WellnessExercisesScreenState();
}

class _WellnessExercisesScreenState extends State<WellnessExercisesScreen> {
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

    var exercises = [breathing, walking, meditation];
    var randomExercise = (exercises..shuffle()).first;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Get.toNamed('/homepage');
            },
          ),
          title: const Text('Wellness Exercises'),
          primary: true,
          backgroundColor: Colors.transparent,
          elevation: 0),
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
                const Text('Choose an exercise you want',
                    style: TextStyle(
                        color: Color(0xffF8A13C),
                        fontSize: 20,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w600)),
                const Text('Open your mind, relieve your body',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w400)),
                const Divider(
                  color: Color(0xffF0F1F1),
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
                          children: const [
                            Text('Breathing Exercise',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Proxima Nova',
                                    fontWeight: FontWeight.w400)),
                            Text("Relax and lower your body's stress",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Proxima Nova',
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffACB2B4))),
                          ],
                        ),
                        RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                                text: 'Go',
                                style: TextStyle(
                                    color: Color(0xffACB2B4),
                                    fontSize: 16,
                                    fontFamily: 'Proxima Nova',
                                    fontWeight: FontWeight.w600)),
                            WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(Icons.keyboard_arrow_right_sharp,
                                    color: Color(0xffACB2B4)))
                          ]),
                        )
                      ]),
                ),
                const Divider(
                  color: Color(0xffF0F1F1),
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
                          children: const [
                            Text('Walking Meditation',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Proxima Nova',
                                    fontWeight: FontWeight.w400)),
                            Text("Match your breathing with a steady pace",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Proxima Nova',
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffACB2B4))),
                          ],
                        ),
                        RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                                text: 'Go',
                                style: TextStyle(
                                    color: Color(0xffACB2B4),
                                    fontSize: 16,
                                    fontFamily: 'Proxima Nova',
                                    fontWeight: FontWeight.w600)),
                            WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(Icons.keyboard_arrow_right_sharp,
                                    color: Color(0xffACB2B4)))
                          ]),
                        )
                      ]),
                ),
                const Divider(
                  color: Color(0xffF0F1F1),
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
                              children: const [
                                Text('Grounding Exercise',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Proxima Nova',
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                            const Text(
                                "Pull away from all the noise in your mind",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Proxima Nova',
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffACB2B4))),
                          ],
                        ),
                        RichText(
                          text: const TextSpan(children: <InlineSpan>[
                            TextSpan(
                                text: 'Go',
                                style: TextStyle(
                                    color: Color(0xffACB2B4),
                                    fontSize: 16,
                                    fontFamily: 'Proxima Nova',
                                    fontWeight: FontWeight.w600)),
                            WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(Icons.keyboard_arrow_right_sharp,
                                    color: Color(0xffACB2B4)))
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
