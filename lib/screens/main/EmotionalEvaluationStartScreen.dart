import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Mood.dart';
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
  bool isEditMode = false;

  void updateEmotionValues(String mood) {
    if (mood == 'VeryHappy') {
      isVeryHappy = true;
      isHappy = false;
      isNeutral = false;
      isBad = false;
      isVeryBad = false;
    }

    else if (mood == 'Happy') {
      isVeryHappy = false;
      isHappy = true;
      isNeutral = false;
      isBad = false;
      isVeryBad = false;
    }

    else if (mood == 'Neutral') {
      isVeryHappy = false;
      isHappy = false;
      isNeutral = true;
      isBad = false;
      isVeryBad = false;
    } 

    else if (mood == 'Bad') {
      isVeryHappy = false;
      isHappy = false;
      isNeutral = false;
      isBad = true;
      isVeryBad = false;
    } 

    else if (mood == 'VeryBad') {
      isVeryHappy = false;
      isHappy = false;
      isNeutral = false;
      isBad = false;
      isVeryBad = true;
    }  
  }

  AssetImage getImageOfMood(String mood) {
    AssetImage image = const AssetImage('placeholder');

    if (mood == 'VeryBad') {
      image = (isVeryBad) ? moodMap[mood]!.icon : moodMap['VeryBadNotSelected']!.icon;
    }
    else if (mood == 'Bad') {
      image = (isBad) ? moodMap[mood]!.icon : moodMap['BadNotSelected']!.icon;
    }
    else if (mood == 'Neutral') {
      image = (isNeutral) ? moodMap[mood]!.icon : moodMap['NeutralNotSelected']!.icon;
    }
    else if (mood == 'Happy') {
      image = (isHappy) ? moodMap[mood]!.icon : moodMap['HappyNotSelected']!.icon;
    }
    else if (mood == 'VeryHappy') {
      image = (isVeryHappy) ? moodMap[mood]!.icon : moodMap['VeryHappyNotSelected']!.icon;
    }

    return image;
  }  

  Center _buildMoodComponent(String mood, EmotionController _emotionController) {
    return Center(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
        spacing: 5,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _emotionController.updateMainEmotion(mood);
                setState(() {
                  updateEmotionValues(mood);
                });
              }, // Image tapped
              splashColor: Colors.white12, // Splash color over image
              child: Ink.image(
                image: getImageOfMood(mood),
                width: 42,
                height: 42,
              ),
            ),
          ),
          Text((mood == 'VeryHappy') ? 'Very\nHappy' : (mood == 'VeryBad') ? 'Very\nBad' : mood,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16, color: Colors.white))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    EmotionController _emotionController = Get.put(EmotionController());

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
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMoodComponent('VeryBad', _emotionController),
                  _buildMoodComponent('Bad', _emotionController),
                  _buildMoodComponent('Neutral', _emotionController),
                  _buildMoodComponent('Happy', _emotionController),
                  _buildMoodComponent('VeryHappy', _emotionController),
              ]),

              const SizedBox(height: 45.0),

              RichText(
                text: TextSpan(
                  children: [
                    const WidgetSpan(child: Icon(Icons.description, size: 16)),
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
                    onChanged: _emotionController.updateNotes,
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