import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/Emotion.dart';
import 'package:flutter_application_1/apis/EmotionEntryDetail.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/dailyController.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../controllers/emotionController.dart';
import '../../enums/DailyTask.dart';

void main() {
  runApp(const GetMaterialApp(home: EmotionalEvaluationEndScreen()));
}

class EmotionalEvaluationEndScreen extends StatefulWidget {
  const EmotionalEvaluationEndScreen({key}) : super(key: key);

  @override
  _EmotionalEvaluationEndScreenState createState() =>
      _EmotionalEvaluationEndScreenState();
}

final EmotionController _emotionController = Get.put(EmotionController());
final DailyController _dailyController = Get.put(DailyController());
final LevelController _levelController = Get.put(LevelController());

class _EmotionalEvaluationEndScreenState
    extends State<EmotionalEvaluationEndScreen> {
  bool isEditMode = false;
  List<dynamic> positiveEmotions = [];
  List<dynamic> negativeEmotions = [];

  void checkIfEditMode() {
    if (_emotionController.isEditMode.value) {
      EmotionEntryDetail emotionEntryDetail = (_emotionController
              .isMorningCheck.value)
          ? _emotionController.getSelectedEmotionEntry().morningCheck
          : (_emotionController.isAfternoonCheck.value)
              ? _emotionController.getSelectedEmotionEntry().afternoonCheck
              : (_emotionController.isEveningCheck.value)
                  ? _emotionController.getSelectedEmotionEntry().eveningCheck
                  : EmotionEntryDetail(
                      mood: '',
                      positiveEmotions: [],
                      negativeEmotions: [],
                      isEmpty: true);

      isEditMode = _emotionController.isEditMode.value;
      positiveEmotions = emotionEntryDetail.positiveEmotions;
      negativeEmotions = emotionEntryDetail.negativeEmotions;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkIfEditMode();

    final List<Emotion> positiveEmotionsList = [
      Emotion(id: 1, name: 'Good'),
      Emotion(id: 2, name: 'Happy'),
      Emotion(id: 3, name: 'Confident'),
      Emotion(id: 4, name: 'Proud'),
      Emotion(id: 5, name: 'Test'),
      Emotion(id: 6, name: 'Test1'),
      Emotion(id: 7, name: 'Test2'),
      Emotion(id: 5, name: 'Test'),
      Emotion(id: 6, name: 'Test1'),
      Emotion(id: 7, name: 'Test2'),
      Emotion(id: 5, name: 'Test'),
      Emotion(id: 6, name: 'Test1'),
      Emotion(id: 7, name: 'Test2'),
    ];

    final List<Emotion> negativeEmotionsList = [
      Emotion(id: 1, name: 'Unmotivated'),
      Emotion(id: 2, name: 'Depressed'),
      Emotion(id: 3, name: 'Tired'),
      Emotion(id: 4, name: 'Isolated'),
    ];

    final _positiveEmotionsItems = positiveEmotionsList
        .map((emotion) => MultiSelectItem<Emotion>(emotion, emotion.name))
        .toList();

    final _negativeEmotionsItems = negativeEmotionsList
        .map((emotion) => MultiSelectItem<Emotion>(emotion, emotion.name))
        .toList();

    DateTime dateTime = _emotionController.dateTime.value;
    String partOfDay = (dateTime.hour < 12 && dateTime.hour > 23)
        ? 'Morning'
        : dateTime.hour > 11 && dateTime.hour < 18
            ? 'Afternoon'
            : 'Evening';

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: Text(
              'Add an Entry',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  color: Theme.of(context).colorScheme.neutralWhite01,
                  fontWeight: FontWeight.w400),
            ),
            leading: BackButton(onPressed: () {
              Get.back();
            }),
            elevation: 0,
            backgroundColor: const Color(0xff216CB2).withOpacity(0.40)),
        body: Stack(children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/background_images/blue_background.png',
                      ),
                      fit: BoxFit.cover))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Container(
                alignment: Alignment.center,
                child: ListView(
                  children: [
                    Text(
                      'Date & Time',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Theme.of(context).colorScheme.neutralWhite01,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 35.0),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralWhite01,
                                    fontWeight: FontWeight.w400),
                          ),
                          Text(
                            DateFormat.E().format(dateTime) +
                                ', ' +
                                DateFormat.MMMMd().format(dateTime),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralWhite01,
                                    fontWeight: FontWeight.w600),
                          ),
                        ]),
                    const SizedBox(height: 25.0),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Time',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralWhite01,
                                    fontWeight: FontWeight.w400),
                          ),
                          Text(
                            DateFormat.Hm().format(dateTime) + ", " + partOfDay,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralWhite01,
                                    fontWeight: FontWeight.w600),
                          ),
                        ]),
                    const SizedBox(height: 20.0),
                    Divider(
                      color: Theme.of(context).colorScheme.neutralWhite01,
                      thickness: 1,
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 18.0),
                      decoration: BoxDecoration(
                          color: const Color(0xff3290FF).withOpacity(0.60),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4))),
                      child: Text('Which emotion best apply to you now?',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralWhite01,
                                  fontWeight: FontWeight.w400)),
                    ),
                    Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 20,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 0),
                            width: double.infinity,
                            child: Wrap(runSpacing: 10, children: [
                              // DROPDOWNS
                              GetBuilder<EmotionController>(
                                builder: (value) => Container(
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralWhite01,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(24))),
                                    child: MultiSelectBottomSheetField<dynamic>(
                                      initialChildSize: 0.3,
                                      listType: MultiSelectListType.CHIP,
                                      searchable: true,
                                      buttonText: Text("Positive Emotions",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: (_emotionController
                                                          .isPositiveNotEmpty
                                                          .value)
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .accentBlue02
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .neutralGray03)),
                                      title: Text("Search for your emotion",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                      items: _positiveEmotionsItems,
                                      initialValue:
                                          isEditMode ? positiveEmotions : [],
                                      onConfirm: (values) {
                                        _emotionController
                                            .updatePositiveEmotion(values);
                                      },
                                      chipDisplay: MultiSelectChipDisplay(
                                        chipColor: Theme.of(context)
                                            .colorScheme
                                            .accentBlue02,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .neutralWhite01),
                                        onTap: (item) {
                                          setState(() {
                                            _emotionController
                                                .removePositive(item);
                                          });
                                        },
                                      ),
                                    )),
                              ),

                              GetBuilder<EmotionController>(
                                builder: (value) => Container(
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralWhite01,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(24))),
                                    child: MultiSelectBottomSheetField<dynamic>(
                                      initialChildSize: 0.3,
                                      listType: MultiSelectListType.CHIP,
                                      searchable: true,
                                      buttonText: Text("Negative Emotions",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: (_emotionController
                                                          .isNegativeNotEmpty
                                                          .value)
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .accentRed02
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .neutralGray03)),
                                      title: Text("Search for your emotion",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                      initialValue:
                                          isEditMode ? negativeEmotions : [],
                                      items: _negativeEmotionsItems,
                                      onConfirm: (values) {
                                        _emotionController
                                            .updateNegativeEmotion(values);
                                      },
                                      chipDisplay: MultiSelectChipDisplay(
                                        chipColor: Theme.of(context)
                                            .colorScheme
                                            .accentRed02,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .neutralWhite01),
                                        onTap: (item) {
                                          _emotionController
                                              .removeNegative(item);
                                        },
                                      ),
                                    )),
                              ),
                            ]),
                          )
                        ]),
                    Container(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: GetBuilder<EmotionController>(
                              builder: (value) => ElevatedButton(
                                  child: Text(
                                    'Save',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .neutralWhite01),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    primary: (_emotionController.isValid.value)
                                        ? Theme.of(context)
                                            .colorScheme
                                            .sunflowerYellow01
                                        : Theme.of(context)
                                            .colorScheme
                                            .neutralWhite04,
                                  ),
                                  onPressed: () {
                                    if (_emotionController.isValid.value) {
                                      bool isAddingFromOnboarding = _emotionController.isAddingFromOnboarding.value;
                                      _emotionController.updateEntryInStorage();

                                      if (!_dailyController.isDailyEntryDone.value) {
                                        _dailyController.setDailyTaskToDone(DailyTask.EmotionEntry);
                                        _levelController.initializeTaskWithXp('Daily Entry', 50);
                                        _levelController.finalizeAddingOfXp();
                                      }

                                      (isAddingFromOnboarding)
                                        ? Get.offAllNamed('/notifScreen')
                                        : Get.offAllNamed('/homepage');
                                    }

                                  }),
                            )),
                      ),
                    ),
                  ],
                ),
              )),
        ]));
  }
}
