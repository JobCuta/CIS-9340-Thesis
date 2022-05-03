import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/Emotion.dart';
import 'package:flutter_application_1/apis/EmotionEntryDetail.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/dailyController.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:flutter_application_1/screens/main/HomepageScreen.dart';
import 'package:flutter_application_1/widgets/SetNotifsDialog.dart';
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
  String route = Get.arguments['route']!;

  @override
  void initState() {
    super.initState();
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
                      isEmpty: true,
                      timeOfDay: 'unknown'
                      );

      isEditMode = _emotionController.isEditMode.value;
      _emotionController.selectedPositiveEmotions.value =
          emotionEntryDetail.positiveEmotions;
      _emotionController.selectedNegativeEmotions.value =
          emotionEntryDetail.negativeEmotions;
    }
    _emotionController.isPositiveNotEmpty.value =
        _emotionController.selectedPositiveEmotions.value.isNotEmpty;
    _emotionController.isNegativeNotEmpty.value =
        _emotionController.selectedNegativeEmotions.value.isNotEmpty;
    _emotionController.isValid.value =
        _emotionController.isPositiveNotEmpty.value ||
            _emotionController.isNegativeNotEmpty.value;
  }

  determineNextRoute() {
    switch (route) {
      case 'onboarding':
        return Get.offAllNamed('/entriesDetailScreen');
      case 'details':
        return Get.offAllNamed('/entriesDetailScreen');
      case 'calendar':
        return Get.off(HomePageScreen(1));
      case 'entry':
        return Get.off(HomePageScreen(0));
      default:
        return Get.off(HomePageScreen(2));
    }
  }

  @override
  Widget build(BuildContext context) {
    print(route);
    print(_emotionController.isEditMode.value);

    final List<Emotion> positiveEmotionsList = [
      Emotion(id: 1, name: 'Good'),
      Emotion(id: 2, name: 'Happy'),
      Emotion(id: 3, name: 'Confident'),
      Emotion(id: 4, name: 'Enthusiastic'),
      Emotion(id: 5, name: 'Interested'),
      Emotion(id: 6, name: 'Proud'),
      Emotion(id: 7, name: 'Active'),
      Emotion(id: 8, name: 'Relaxed')
    ];

    final List<Emotion> negativeEmotionsList = [
      Emotion(id: 1, name: 'Unmotivated'),
      Emotion(id: 2, name: 'Depressed'),
      Emotion(id: 3, name: 'Tired'),
      Emotion(id: 4, name: 'Afraid'),
      Emotion(id: 5, name: 'Isolated'),
      Emotion(id: 6, name: 'Lonely'),
      Emotion(id: 7, name: 'Upset')
    ];

    final _positiveEmotionsItems = positiveEmotionsList
        .map((emotion) => MultiSelectItem<Emotion>(emotion, emotion.name))
        .toList();

    final _negativeEmotionsItems = negativeEmotionsList
        .map((emotion) => MultiSelectItem<Emotion>(emotion, emotion.name))
        .toList();

    DateTime dateTime = _emotionController.dateTime.value;

    String partOfDay = (_emotionController.isMorningCheck.value)
        ? 'Morning'
        : (_emotionController.isAfternoonCheck.value)
            ? 'Afternoon'
            : (_emotionController.isEveningCheck.value)
                ? 'Evening'
                : dateTime.hour <= 11
                    ? 'Morning'
                    : dateTime.hour > 11 && dateTime.hour < 18
                        ? 'Afternoon'
                        : 'Evening';
    return Scaffold(
      primary: true,
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
          backgroundColor: const Color(0xff216CB2).withOpacity(0.40)),
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
                              GetBuilder<EmotionController>(
                                builder: (value) => Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24)),
                                  ),
                                  child: ExpandablePanel(
                                    theme: const ExpandableThemeData(
                                        hasIcon: true),
                                    header: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text('Positive Emotions',
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: _emotionController
                                                          .isPositiveNotEmpty
                                                          .value
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .accentBlue02
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .neutralGray03)),
                                    ),
                                    collapsed: Container(),
                                    expanded: MultiSelectChipField<Emotion?>(
                                      showHeader: false,
                                      scroll: false,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .accentBlue02),
                                      selectedChipColor: Theme.of(context)
                                          .colorScheme
                                          .accentBlue02,
                                      selectedTextStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .neutralWhite01),
                                      initialValue: List.castFrom(
                                          _emotionController
                                              .selectedPositiveEmotions.value),
                                      items: _positiveEmotionsItems,
                                      onTap: (values) {
                                        _emotionController
                                            .updatePositiveEmotions(values);
                                        print(_emotionController
                                            .selectedPositiveEmotions.value);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 50),
                                child: GetBuilder<EmotionController>(
                                  builder: (value) => Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(24)),
                                    ),
                                    child: ExpandablePanel(
                                      theme: const ExpandableThemeData(
                                          hasIcon: true),
                                      header: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Text('Negative Emotions',
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: _emotionController
                                                            .isNegativeNotEmpty
                                                            .value
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .accentRed02
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .neutralGray03)),
                                      ),
                                      collapsed: Container(),
                                      expanded: MultiSelectChipField<Emotion?>(
                                        showHeader: false,
                                        scroll: false,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white)),
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .accentRed02),
                                        selectedChipColor: Theme.of(context)
                                            .colorScheme
                                            .accentRed02,
                                        selectedTextStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .neutralWhite01),
                                        initialValue: List.castFrom(
                                            _emotionController
                                                .selectedNegativeEmotions
                                                .value),
                                        items: _negativeEmotionsItems,
                                        onTap: (values) {
                                          _emotionController
                                              .updateNegativeEmotions(values);
                                          print(_emotionController
                                              .selectedNegativeEmotions.value);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          )
                        ]),
                  ],
                ),
              )),
        ),
      ]),
      bottomSheet: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: GetBuilder<EmotionController>(
              builder: (value) => ElevatedButton(
                  child: Text(
                    'Save',
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.neutralWhite01),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.all(10),
                    primary: (_emotionController.isValid.value)
                        ? Theme.of(context).colorScheme.sunflowerYellow01
                        : Theme.of(context).colorScheme.neutralWhite04,
                  ),
                  onPressed: () {
                    if (_emotionController.isValid.value) {
                      bool isAddingFromOnboarding =
                          _emotionController.isAddingFromOnboarding.value;
                      _emotionController.updateEntryInStorage();

                      if (!_dailyController.isDailyEntryDone.value) {
                        _dailyController
                            .setDailyTaskToDone(DailyTask.EmotionEntry);
                        _levelController.initializeTaskWithXp('Daily Entry', 5);
                        _levelController.finalizeAddingOfXp();
                      }

                      if (_dailyController.isMorningEntryDone.value &&
                          _dailyController.isAfternoonEntryDone.value &&
                          _dailyController.isEveningEntryDone.value) {
                        _levelController.addXp('All 3 Entries', 20);
                      }
                      (isAddingFromOnboarding)
                          ? setNotificationsAlert(context)
                          : determineNextRoute();
                    }
                  }),
            )),
      ),
    );
  }
}
