import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/EmotionEntryDetail.dart';
import 'package:flutter_application_1/apis/emotionEntryHive.dart';
import 'package:flutter_application_1/constants/colors.dart';
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

class _EmotionalEvaluationStartScreenState
    extends State<EmotionalEvaluationStartScreen> {
  final EmotionController _emotionController = Get.put(EmotionController());
  late EmotionEntryDetail emotionEntryDetail;
  final TextEditingController _noteController = TextEditingController();
  bool isEditMode = false;
  bool isVeryHappy = false;
  bool isHappy = false;
  bool isNeutral = false;
  bool isBad = false;
  bool isVeryBad = false;

  void updateEmotionValues(String mood) {
    if (mood == 'VeryHappy') {
      isVeryHappy = true;
      isHappy = false;
      isNeutral = false;
      isBad = false;
      isVeryBad = false;
    } else if (mood == 'Happy') {
      isVeryHappy = false;
      isHappy = true;
      isNeutral = false;
      isBad = false;
      isVeryBad = false;
    } else if (mood == 'Neutral') {
      isVeryHappy = false;
      isHappy = false;
      isNeutral = true;
      isBad = false;
      isVeryBad = false;
    } else if (mood == 'Bad') {
      isVeryHappy = false;
      isHappy = false;
      isNeutral = false;
      isBad = true;
      isVeryBad = false;
    } else if (mood == 'VeryBad') {
      isVeryHappy = false;
      isHappy = false;
      isNeutral = false;
      isBad = false;
      isVeryBad = true;
    }
  }

  @override
  void initState() {
    final EmotionController _emotionController = Get.put(EmotionController());
    if (_emotionController.isEditMode.value) {
      emotionEntryDetail = (_emotionController.isMorningCheck.value)
          ? _emotionController.getSelectedEmotionEntry().morningCheck
          : (_emotionController.isAfternoonCheck.value)
              ? _emotionController.getSelectedEmotionEntry().afternoonCheck
              : (_emotionController.isEveningCheck.value)
                  ? _emotionController.getSelectedEmotionEntry().eveningCheck
                  : EmotionEntryDetail(
                      mood: '',
                      positiveEmotions: [],
                      negativeEmotions: [],
                      isEmpty: true,
                      timeOfDay: 'unknown'
                      );

      isEditMode = _emotionController.isEditMode.value;
      _noteController.text =
          _emotionController.isEditMode.value ? emotionEntryDetail.note : '';
      updateEmotionValues(emotionEntryDetail.mood);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AssetImage getImageOfMood(String mood) {
      AssetImage image = const AssetImage('placeholder');

      if (mood == 'VeryBad') {
        image = (isVeryBad)
            ? moodMap[mood]!.icon
            : moodMap['VeryBadNotSelected']!.icon;
      } else if (mood == 'Bad') {
        image = (isBad) ? moodMap[mood]!.icon : moodMap['BadNotSelected']!.icon;
      } else if (mood == 'Neutral') {
        image = (isNeutral)
            ? moodMap[mood]!.icon
            : moodMap['NeutralNotSelected']!.icon;
      } else if (mood == 'Happy') {
        image =
            (isHappy) ? moodMap[mood]!.icon : moodMap['HappyNotSelected']!.icon;
      } else if (mood == 'VeryHappy') {
        image = (isVeryHappy)
            ? moodMap[mood]!.icon
            : moodMap['VeryHappyNotSelected']!.icon;
      }

      return image;
    }

    Center _buildMoodComponent(String mood) {
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
                splashColor: Theme.of(context)
                    .colorScheme
                    .neutralGray02, // Splash color over image
                child: Ink.image(
                  image: getImageOfMood(mood),
                  width: 42,
                  height: 42,
                ),
              ),
            ),
            Text(
                (mood == 'VeryHappy')
                    ? 'Very\nHappy'
                    : (mood == 'VeryBad')
                        ? 'Very\nBad'
                        : mood,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Theme.of(context).colorScheme.neutralWhite01))
          ],
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          _emotionController.isEditMode.value
              ? 'Edit an Entry'
              : 'Add an Entry',
          style: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: Theme.of(context).colorScheme.neutralWhite01,
              fontWeight: FontWeight.w400),
        ),
        leading: BackButton(onPressed: () {
          Get.back();
        }),
        elevation: 0,
        backgroundColor: const Color(0xff216CB2).withOpacity(0.40),
      ),
      body: Stack(children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/background_images/blue_background.png',
                    ),
                    fit: BoxFit.cover))),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                      color: const Color(0xff3290FF).withOpacity(0.60),
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  child: Text('How do you feel in this moment?',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: Theme.of(context).colorScheme.neutralWhite01)),
                ),
                const SizedBox(height: 30.0),
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMoodComponent('VeryBad'),
                      _buildMoodComponent('Bad'),
                      _buildMoodComponent('Neutral'),
                      _buildMoodComponent('Happy'),
                      _buildMoodComponent('VeryHappy'),
                    ]),
                const SizedBox(height: 45.0),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(Icons.description_outlined,
                              size: 20,
                              color:
                                  Theme.of(context).colorScheme.accentBlue04)),
                      TextSpan(
                          text: "  Notes",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                    ],
                  ),
                ),
                const SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 5.0),
                  child: Material(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: TextFormField(
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: const Color(0xff5E6668)),
                      controller: _noteController,
                      decoration: InputDecoration(
                        hintText: 'Write something you wanna mention here',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: const Color(0xffC7CBCC)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 13.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
      resizeToAvoidBottomInset: false,
      bottomSheet: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: ElevatedButton(
            child: Text(
              'Next',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  color: Theme.of(context).colorScheme.neutralWhite01,
                  fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0,
                primary:
                    (isVeryHappy || isHappy || isNeutral || isBad || isVeryBad)
                        ? Theme.of(context).colorScheme.sunflowerYellow01
                        : Theme.of(context).colorScheme.neutralWhite04),
            onPressed: () {
              if (isVeryHappy || isHappy || isNeutral || isBad || isVeryBad) {
                _emotionController.updateNotes(_noteController.text);
                Get.toNamed('/emotionEndScreen',
                    arguments: {'route': Get.arguments["route"]!});
              }
            }),
      ),
    );
  }
}
