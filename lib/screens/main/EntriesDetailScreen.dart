import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/emotionEntryHive.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/emotionController.dart';
import 'package:flutter_application_1/enums/PartOfTheDay.dart';
import 'package:flutter_application_1/models/Mood.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'SideMenu.dart';

class EntriesDetailScreen extends StatefulWidget {
  const EntriesDetailScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EntriesDetailScreenState();
}

final EmotionController _emotionController = Get.put(EmotionController());

class _EntriesDetailScreenState extends State<EntriesDetailScreen> {
  EmotionEntryHive emotionEntry = _emotionController.getSelectedEmotionEntry();

  Map<int, String> month = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec'
  };

  int missedEntries = 0;

  void _checkForAnyMissedEntries() {
    if (emotionEntry.morningCheck.mood == 'NoData') missedEntries++;
    if (emotionEntry.afternoonCheck.mood == 'NoData') missedEntries++;
    if (emotionEntry.eveningCheck.mood == 'NoData') missedEntries++;
  }

  showDeleteConfirmation(PartOfTheDay part) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            insetPadding: const EdgeInsets.all(50.0),
            title: Text(
              'Are you sure?',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: Theme.of(context).colorScheme.neutralBlack02,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            content: Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Wrap(
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/delete_entry.svg'),
                    Text(
                        "Every entry is essential in tracking your life's well-being, are you sure you want to delete this entry?",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w400,
                            color:
                                Theme.of(context).colorScheme.neutralBlack02)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: Text(
                              'Delete',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .accentRed02,
                                      fontWeight: FontWeight.w600),
                            ),
                            onPressed: () async {
                              _emotionController.deleteEmotionEntry(part);
                              Get.offAllNamed('/homepage');
                            },
                          ),
                          TextButton(
                              child: Text(
                                'Nevermind',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralBlack02,
                                        fontWeight: FontWeight.w600),
                              ),
                              onPressed: () {
                                Get.back();
                              }),
                        ])
                  ]),
            )));
  }

  List<bool> _isOpen = [false];

  @override
  Widget build(BuildContext context) {
    _checkForAnyMissedEntries();

    PositiveEmotions(List positiveEmotions) {
      return positiveEmotions.isNotEmpty
          ? SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true, //just set this property
                padding: const EdgeInsets.all(8.0),
                itemCount: positiveEmotions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                        color: Theme.of(context).colorScheme.accentBlue02),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(positiveEmotions[index].toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralWhite01)),
                    ),
                  );
                },
              ))
          : Text('None', style: Theme.of(context).textTheme.bodyText2);
    }

    NegativeEmotions(List negativeEmotions) {
      return negativeEmotions.isNotEmpty
          ? SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true, //just set this property
                padding: const EdgeInsets.all(8.0),
                itemCount: negativeEmotions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                        color: Theme.of(context).colorScheme.accentRed02),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(negativeEmotions[index].toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralWhite01)),
                    ),
                  );
                },
              ))
          : Text('None', style: Theme.of(context).textTheme.bodyText2);
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const SideMenu(),
      appBar: AppBar(
          primary: true,
          elevation: 0,
          backgroundColor: const Color(0xff216CB2).withOpacity(0.40),
          title: Text(emotionEntry.month.substring(0, 3) +
              " " +
              emotionEntry.day.toString() +
              ", " +
              emotionEntry.year.toString())),
      body: Stack(children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/background_images/blue_background.png',
                    ),
                    fit: BoxFit.cover))),
        SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // EMOTION CONTAINER
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 120, 25, 25),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(hasIcon: false),
                  header: Column(children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            image:
                                moodMap[emotionEntry.eveningCheck.mood]!.icon,
                            width: 62,
                            height: 62,
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: 'Overall Mood: ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: (emotionEntry.eveningCheck
                                                            .mood ==
                                                        'NoData'
                                                    ? 'Empty'
                                                    : emotionEntry.eveningCheck
                                                                .mood ==
                                                            'VeryHappy'
                                                        ? 'Very Happy'
                                                        : emotionEntry
                                                                    .eveningCheck
                                                                    .mood ==
                                                                'VeryBad'
                                                            ? 'Very Bad'
                                                            : emotionEntry
                                                                .eveningCheck
                                                                .mood),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: moodColor[
                                                            emotionEntry
                                                                .eveningCheck
                                                                .mood])),
                                          ]),
                                    ),
                                    PopupMenuButton(
                                      onSelected: (value) {
                                        if (value == 'Edit') {
                                          _emotionController
                                              .updatePartOfTheDayCheck(
                                                  PartOfTheDay.Evening);
                                          _emotionController
                                              .updateSelectedEmotionEntry(
                                                  emotionEntry);
                                          _emotionController
                                              .updateEditMode(true);
                                          _emotionController
                                              .updateIfAddingFromDaily(false);
                                          _emotionController.updateDateTime(
                                              emotionEntry.month,
                                              emotionEntry.day,
                                              emotionEntry.year);

                                          Get.toNamed('/emotionStartScreen');
                                        } else if (value == 'Delete') {
                                          showDeleteConfirmation(
                                              PartOfTheDay.Evening);
                                        }
                                      },
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry<String>>[
                                        PopupMenuItem(
                                          value: 'Edit',
                                          child: Text('Edit',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2),
                                        ),
                                        PopupMenuItem(
                                          value: 'Delete',
                                          child: Text(
                                            'Delete',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .accentRed02),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: 'Evening check ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(
                                                  color: (emotionEntry
                                                              .eveningCheck
                                                              .mood !=
                                                          'NoData')
                                                      ? const Color(0xff161818)
                                                          .withOpacity(1.0)
                                                      : const Color(0x00C7CBCC)
                                                          .withOpacity(1.0)),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: (emotionEntry.eveningCheck
                                                            .mood !=
                                                        'NoData')
                                                    ? emotionEntry
                                                        .eveningCheck.time
                                                    : 'missed',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    ?.copyWith(
                                                        color: const Color(
                                                                0x00C7CBCC)
                                                            .withOpacity(1.0)))
                                          ]),
                                    ),
                                    (emotionEntry.eveningCheck.mood != 'NoData')
                                        ? Image(
                                            image: moodMap[emotionEntry
                                                    .eveningCheck.mood]!
                                                .icon,
                                            width: 24,
                                            height: 24)
                                        : IconButton(
                                            onPressed: () {
                                              _emotionController
                                                  .updatePartOfTheDayCheck(
                                                      PartOfTheDay.Evening);
                                              _emotionController
                                                  .updateIfAddingFromDaily(
                                                      false);
                                              _emotionController
                                                  .updateEditMode(false);
                                              _emotionController
                                                  .updateIfAddingFromDaily(
                                                      false);
                                              _emotionController.updateDateTime(
                                                  emotionEntry.month,
                                                  emotionEntry.day,
                                                  emotionEntry.year);

                                              Get.toNamed(
                                                  '/emotionStartScreen');
                                            },
                                            icon: Icon(Icons.add_circle,
                                                color: const Color(0x004CA7FC)
                                                    .withOpacity(1.0)))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ])
                  ]),
                  collapsed: const Divider(
                    color: Color(0xffF0F1F1),
                    height: 20.0,
                    thickness: 4,
                    indent: 35.0,
                    endIndent: 35.0,
                  ),
                  expanded: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 15.0),
                        Text('Notes',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: const Color(0x00C7CBCC)
                                        .withOpacity(1.0),
                                    fontWeight: FontWeight.w600)),
                        const SizedBox(height: 5.0),
                        Text(emotionEntry.eveningCheck.note,
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    color: const Color(0xff161818)
                                        .withOpacity(1.0))),
                        const SizedBox(height: 15.0),
                        Text('Emotions you felt at this time:',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: const Color(0x00C7CBCC)
                                        .withOpacity(1.0),
                                    fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10.0),
                        Text('Positive',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    color: const Color(0xff161818)
                                        .withOpacity(1.0))),
                        PositiveEmotions(emotionEntry
                            .eveningCheck.positiveEmotions
                            .toSet()
                            .toList()),
                        const SizedBox(height: 10.0),
                        Text('Negative',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    color: const Color(0xff161818)
                                        .withOpacity(1.0))),
                        NegativeEmotions(emotionEntry
                            .eveningCheck.negativeEmotions
                            .toSet()
                            .toList()),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(hasIcon: false),
                  header: Column(children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            image:
                                moodMap[emotionEntry.afternoonCheck.mood]!.icon,
                            width: 62,
                            height: 62,
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: 'Overall Mood: ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: (emotionEntry
                                                            .afternoonCheck
                                                            .mood ==
                                                        'NoData'
                                                    ? 'Empty'
                                                    : emotionEntry
                                                                .afternoonCheck
                                                                .mood ==
                                                            'VeryHappy'
                                                        ? 'Very Happy'
                                                        : emotionEntry
                                                                    .afternoonCheck
                                                                    .mood ==
                                                                'VeryBad'
                                                            ? 'Very Bad'
                                                            : emotionEntry
                                                                .afternoonCheck
                                                                .mood),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: moodColor[
                                                            emotionEntry
                                                                .afternoonCheck
                                                                .mood])),
                                          ]),
                                    ),
                                    PopupMenuButton(
                                      onSelected: (value) {
                                        if (value == 'Edit') {
                                          _emotionController
                                              .updatePartOfTheDayCheck(
                                                  PartOfTheDay.Afternoon);
                                          _emotionController
                                              .updateSelectedEmotionEntry(
                                                  emotionEntry);
                                          _emotionController
                                              .updateEditMode(true);
                                          _emotionController
                                              .updateIfAddingFromDaily(false);
                                          _emotionController.updateDateTime(
                                              emotionEntry.month,
                                              emotionEntry.day,
                                              emotionEntry.year);

                                          Get.toNamed('/emotionStartScreen');
                                        } else if (value == 'Delete') {
                                          showDeleteConfirmation(
                                              PartOfTheDay.Afternoon);
                                        }
                                      },
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry<String>>[
                                        PopupMenuItem(
                                          value: 'Edit',
                                          child: Text('Edit',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2),
                                        ),
                                        PopupMenuItem(
                                          value: 'Delete',
                                          child: Text(
                                            'Delete',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .accentRed02),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: 'Afternoon check ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(
                                                  color: (emotionEntry
                                                              .afternoonCheck
                                                              .mood !=
                                                          'NoData')
                                                      ? const Color(0xff161818)
                                                          .withOpacity(1.0)
                                                      : const Color(0x00C7CBCC)
                                                          .withOpacity(1.0)),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: (emotionEntry
                                                            .afternoonCheck
                                                            .mood !=
                                                        'NoData')
                                                    ? emotionEntry
                                                        .afternoonCheck.time
                                                    : 'missed',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    ?.copyWith(
                                                        color: const Color(
                                                                0x00C7CBCC)
                                                            .withOpacity(1.0)))
                                          ]),
                                    ),
                                    (emotionEntry.afternoonCheck.mood !=
                                            'NoData')
                                        ? Image(
                                            image: moodMap[emotionEntry
                                                    .afternoonCheck.mood]!
                                                .icon,
                                            width: 24,
                                            height: 24)
                                        : IconButton(
                                            onPressed: () {
                                              _emotionController
                                                  .updatePartOfTheDayCheck(
                                                      PartOfTheDay.Afternoon);
                                              _emotionController
                                                  .updateIfAddingFromDaily(
                                                      false);
                                              _emotionController
                                                  .updateEditMode(false);
                                              _emotionController
                                                  .updateIfAddingFromDaily(
                                                      false);
                                              _emotionController.updateDateTime(
                                                  emotionEntry.month,
                                                  emotionEntry.day,
                                                  emotionEntry.year);

                                              Get.toNamed(
                                                  '/emotionStartScreen');
                                            },
                                            icon: Icon(Icons.add_circle,
                                                color: const Color(0x004CA7FC)
                                                    .withOpacity(1.0)))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ])
                  ]),
                  collapsed: const Divider(
                    color: Color(0xffF0F1F1),
                    height: 20.0,
                    thickness: 4,
                    indent: 35.0,
                    endIndent: 35.0,
                  ),
                  expanded: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 15.0),
                        Text('Notes',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: const Color(0x00C7CBCC)
                                        .withOpacity(1.0),
                                    fontWeight: FontWeight.w600)),
                        const SizedBox(height: 5.0),
                        Text(emotionEntry.afternoonCheck.note,
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    color: const Color(0xff161818)
                                        .withOpacity(1.0))),
                        const SizedBox(height: 15.0),
                        Text('Emotions you felt at this time:',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: const Color(0x00C7CBCC)
                                        .withOpacity(1.0),
                                    fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10.0),
                        Text('Positive',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    color: const Color(0xff161818)
                                        .withOpacity(1.0))),
                        PositiveEmotions(
                            // removes duplicates
                            emotionEntry.afternoonCheck.positiveEmotions
                                .toSet()
                                .toList()),
                        const SizedBox(height: 10.0),
                        Text('Negative',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    color: const Color(0xff161818)
                                        .withOpacity(1.0))),
                        NegativeEmotions(emotionEntry
                            .afternoonCheck.negativeEmotions
                            .toSet()
                            .toList()),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(hasIcon: false),
                  header: Column(children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            image:
                                moodMap[emotionEntry.morningCheck.mood]!.icon,
                            width: 62,
                            height: 62,
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: 'Overall Mood: ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: (emotionEntry.morningCheck
                                                            .mood ==
                                                        'NoData'
                                                    ? 'Empty'
                                                    : emotionEntry.morningCheck
                                                                .mood ==
                                                            'VeryHappy'
                                                        ? 'Very Happy'
                                                        : emotionEntry
                                                                    .morningCheck
                                                                    .mood ==
                                                                'VeryBad'
                                                            ? 'Very Bad'
                                                            : emotionEntry
                                                                .morningCheck
                                                                .mood),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: moodColor[
                                                            emotionEntry
                                                                .morningCheck
                                                                .mood])),
                                          ]),
                                    ),
                                    PopupMenuButton(
                                      onSelected: (value) {
                                        if (value == 'Edit') {
                                          _emotionController
                                              .updatePartOfTheDayCheck(
                                                  PartOfTheDay.Morning);
                                          _emotionController
                                              .updateSelectedEmotionEntry(
                                                  emotionEntry);
                                          _emotionController
                                              .updateEditMode(true);
                                          _emotionController
                                              .updateIfAddingFromDaily(false);
                                          _emotionController.updateDateTime(
                                              emotionEntry.month,
                                              emotionEntry.day,
                                              emotionEntry.year);

                                          Get.toNamed('/emotionStartScreen');
                                        } else if (value == 'Delete') {
                                          showDeleteConfirmation(
                                              PartOfTheDay.Morning);
                                        }
                                      },
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry<String>>[
                                        PopupMenuItem(
                                          value: 'Edit',
                                          child: Text('Edit',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2),
                                        ),
                                        PopupMenuItem(
                                          value: 'Delete',
                                          child: Text(
                                            'Delete',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .accentRed02),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: 'Morning check ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(
                                                  color: (emotionEntry
                                                              .morningCheck
                                                              .mood !=
                                                          'NoData')
                                                      ? const Color(0xff161818)
                                                          .withOpacity(1.0)
                                                      : const Color(0x00C7CBCC)
                                                          .withOpacity(1.0)),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: (emotionEntry.morningCheck
                                                            .mood !=
                                                        'NoData')
                                                    ? emotionEntry
                                                        .morningCheck.time
                                                    : 'missed',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    ?.copyWith(
                                                        color: const Color(
                                                                0x00C7CBCC)
                                                            .withOpacity(1.0)))
                                          ]),
                                    ),
                                    (emotionEntry.morningCheck.mood != 'NoData')
                                        ? Image(
                                            image: moodMap[emotionEntry
                                                    .morningCheck.mood]!
                                                .icon,
                                            width: 24,
                                            height: 24)
                                        : IconButton(
                                            onPressed: () {
                                              _emotionController
                                                  .updatePartOfTheDayCheck(
                                                      PartOfTheDay.Morning);
                                              _emotionController
                                                  .updateIfAddingFromDaily(
                                                      false);
                                              _emotionController
                                                  .updateEditMode(false);
                                              _emotionController
                                                  .updateIfAddingFromDaily(
                                                      false);
                                              _emotionController.updateDateTime(
                                                  emotionEntry.month,
                                                  emotionEntry.day,
                                                  emotionEntry.year);

                                              Get.toNamed(
                                                  '/emotionStartScreen');
                                            },
                                            icon: Icon(Icons.add_circle,
                                                color: const Color(0x004CA7FC)
                                                    .withOpacity(1.0)))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ])
                  ]),
                  collapsed: const Divider(
                    color: Color(0xffF0F1F1),
                    height: 20.0,
                    thickness: 4,
                    indent: 35.0,
                    endIndent: 35.0,
                  ),
                  expanded: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 15.0),
                        Text('Notes',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: const Color(0x00C7CBCC)
                                        .withOpacity(1.0),
                                    fontWeight: FontWeight.w600)),
                        const SizedBox(height: 5.0),
                        Text(emotionEntry.morningCheck.note,
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    color: const Color(0xff161818)
                                        .withOpacity(1.0))),
                        const SizedBox(height: 15.0),
                        Text('Emotions you felt at this time:',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: const Color(0x00C7CBCC)
                                        .withOpacity(1.0),
                                    fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10.0),
                        Text('Positive',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    color: const Color(0xff161818)
                                        .withOpacity(1.0))),
                        PositiveEmotions(emotionEntry
                            .morningCheck.positiveEmotions
                            .toSet()
                            .toList()),
                        const SizedBox(height: 10.0),
                        Text('Negative',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    color: const Color(0xff161818)
                                        .withOpacity(1.0))),
                        NegativeEmotions(emotionEntry
                            .morningCheck.negativeEmotions
                            .toSet()
                            .toList()),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10.0),

            (missedEntries > 0 && missedEntries < 3)
                ? Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                        alignment: Alignment.center,
                        height: 140,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 18.0),
                        decoration: BoxDecoration(
                            color: const Color(0xff3290FF).withOpacity(0.60),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4))),
                        child: Column(children: [
                          Text('You missed some entries!',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(color: Colors.white)),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 12.0),
                            decoration: BoxDecoration(
                                color:
                                    const Color(0xff216CB2).withOpacity(0.20),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Text(
                                'Make sure to add your missed entries to ensure that your wellness is being properly tracked by you and the app.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(color: Colors.white)),
                          )
                        ])),
                  )
                : (missedEntries == 3)
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 70,
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 18.0),
                          decoration: BoxDecoration(
                              color: const Color(0xff3290FF).withOpacity(0.60),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4))),
                          child: Text('No entries found!',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(color: Colors.white)),
                        ),
                      )
                    : const SizedBox(height: 10.0),
          ],
        )),
      ]),
    );
  }
}
