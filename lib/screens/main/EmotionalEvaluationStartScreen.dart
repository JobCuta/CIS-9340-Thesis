import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/emotionController.dart';


void main() {
  runApp(const GetMaterialApp(home: EmotionalEvaluationStartScreen()));
}

class Emotion {
  final int id;
  final String name;

  Emotion({
    required this.id,
    required this.name,
  });

  @override
  toString() => name;
}

class EmotionalEvaluationStartScreen extends StatefulWidget {
  const EmotionalEvaluationStartScreen({key}) : super(key: key);

  @override
  _EmotionalEvaluationStartScreenState createState() =>
      _EmotionalEvaluationStartScreenState();
}

class _EmotionalEvaluationStartScreenState extends State<EmotionalEvaluationStartScreen> {
  bool isVeryHappy = false;
  bool isHappy = false;
  bool isNeutral = false;
  bool isBad = false;
  bool isVeryBad = false;

  @override
  Widget build(BuildContext context) {
    final EmotionController _emotionController = Get.put(EmotionController());

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: Text(
              'Add an Entry',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
          ),

          leading: BackButton(onPressed: () {Get.toNamed('.homepage');}),
          elevation: 0,
          backgroundColor: Colors.transparent
      ),

      body: Stack(children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/background_images/blue_background.png',
                    ),
                    fit: BoxFit.cover))),

        Padding(
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                height: 66,
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                decoration: BoxDecoration(
                    color: const Color(0xff3290FF).withOpacity(0.60),
                    borderRadius: const BorderRadius.all(Radius.circular(4))),
                child: Text('How do you feel in this moment?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 20, color: Colors.white)),
              ),

              const SizedBox(height: 30.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _emotionController.updateMainEmotion('Very Happy');
                            setState(() {
                              isVeryHappy = true;
                              isHappy = false;
                              isNeutral = false;
                              isBad = false;
                              isVeryBad = false;
                            });
                          }, // Image tapped
                          splashColor: Colors.white12, // Splash color over image
                          child: Ink.image(
                            image: (isVeryHappy)
                                ? const AssetImage(
                                    'assets/images/face_very_happy_selected.png',
                                  )
                                : const AssetImage(
                                    'assets/images/face_very_happy.png'),
                            width: 42,
                            height: 42,
                          ),
                        ),
                      ),

                      const SizedBox(height: 5.0),

                      Text('Very\nHappy',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16, color: Colors.white))
                    ],
                  ),

                  Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.vertical,
                      spacing: 5,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              _emotionController.updateMainEmotion('Happy');
                              setState(() {
                                isVeryHappy = false;
                                isHappy = true;
                                isNeutral = false;
                                isBad = false;
                                isVeryBad = false;
                              });
                            }, // Image tapped
                            splashColor: Colors.white12, // Splash color over image
                            child: Ink.image(
                              image: (isHappy)
                                  ? const AssetImage(
                                      'assets/images/face_happy_selected.png',
                                    )
                                  : const AssetImage('assets/images/face_happy.png'),
                              width: 42,
                              height: 42,
                            ),
                          ),
                        ),
                        Text('Happy',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16, color: Colors.white))
                      ],
                    ),
                  ),

                Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    spacing: 5,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _emotionController.updateMainEmotion('Neutral');
                            setState(() {
                              isVeryHappy = false;
                              isHappy = false;
                              isNeutral = true;
                              isBad = false;
                              isVeryBad = false;
                            });
                          }, // Image tapped
                          splashColor: Colors.white12, // Splash color over image
                          child: Ink.image(
                            image: (isNeutral)
                                ? const AssetImage(
                                    'assets/images/face_neutral_selected.png',
                                  )
                                : const AssetImage('assets/images/face_neutral.png'),
                            width: 42,
                            height: 42,
                          ),
                        ),
                      ),
                      Text('Neutral',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16, color: Colors.white))
                    ],
                  ),
                ),

                Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    spacing: 5,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _emotionController.updateMainEmotion('Bad');
                            setState(() {
                              isVeryHappy = false;
                              isHappy = false;
                              isNeutral = false;
                              isBad = true;
                              isVeryBad = false;
                            });
                          },
                          splashColor: Colors.white12,
                          child: Ink.image(
                            image: (isBad)
                                ? const AssetImage(
                                    'assets/images/face_bad_selected.png',
                                  )
                                : const AssetImage('assets/images/face_bad.png'),
                            width: 42,
                            height: 42,
                          ),
                        ),
                      ),
                      Text('Bad',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16, color: Colors.white))
                    ],
                  ),
                ),

                Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    spacing: 5,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _emotionController.updateMainEmotion('Very Bad');
                            setState(() {
                              isVeryHappy = false;
                              isHappy = false;
                              isNeutral = false;
                              isBad = false;
                              isVeryBad = true;
                            });
                          }, // Image tapped
                          splashColor: Colors.white12, // Splash color over image
                          child: Ink.image(
                            image: (isVeryBad)
                                ? const AssetImage(
                                    'assets/images/face_very_bad_selected.png',
                                  )
                                : const AssetImage(
                                    'assets/images/face_very_bad.png'),
                            width: 42,
                            height: 42,
                          ),
                        ),
                      ),
                      Text('Very\nBad',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16, color: Colors.white))
                    ],
                  ),
                ),
              ]),

              const SizedBox(height: 45.0),

              RichText(
                text: TextSpan(
                  children: [
                    const WidgetSpan(child: Icon(Icons.note_add_outlined, size: 16)),
                    TextSpan(text: " Notes", style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14, color: Colors.white)),
                  ],
                ),
              ),

              const SizedBox(height: 5.0),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: Material(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: TextField(
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0x005E6668).withOpacity(1.0)),
                    // controller: controller,
                    maxLines: null,
                    // onChanged: onChanged,
                    decoration: InputDecoration(
                      hintText: 'Write something you wanna mention here',
                      hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0x00C7CBCC).withOpacity(1.0)),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 13.0),

                    ),
                  ),
                ),
              ),

            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                  child: Text('Next',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(color: const Color(0xFFFFFFFF).withOpacity(1.0)),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.all(10),
                    primary: (isVeryHappy ||
                            isHappy ||
                            isNeutral ||
                            isBad ||
                            isVeryBad)
                        ? const Color(0xffFFBE18)
                        : const Color(0xffE2E4E4),
                  ),
                  onPressed: () {
                    (isVeryHappy || isHappy || isNeutral || isBad || isVeryBad)
                        ? Get.toNamed('/emotionEndScreen')
                        : null;
                  }),
            ),
          ),
        ),
      ]),
    );
  }
}