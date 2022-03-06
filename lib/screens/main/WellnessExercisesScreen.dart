import 'package:flutter/material.dart';

class WellnessExercisesScreen extends StatefulWidget {
  const WellnessExercisesScreen({Key? key}) : super(key: key);

  @override
  State<WellnessExercisesScreen> createState() =>
      _WellnessExercisesScreenState();
}

class _WellnessExercisesScreenState extends State<WellnessExercisesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
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
                      Get.toNamed('/')
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
                    onTap: () {},
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
                    onTap: () {},
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
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Proxima Nova',
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                              Text("Pull away from all the noise in your mind",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Proxima Nova',
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xffACB2B4))),
                            ],
                          ),
                          RichText(
                            text: TextSpan(children: <InlineSpan>[
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
        ]));
  }
}
