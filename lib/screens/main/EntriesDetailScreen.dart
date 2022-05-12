import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/emotionEntryHive.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/emotionController.dart';
import 'package:flutter_application_1/enums/PartOfTheDay.dart';
import 'package:flutter_application_1/models/Mood.dart';
import 'package:flutter_application_1/screens/main/HomepageScreen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../SideMenu/SideMenu.dart';

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
                              _emotionController.updateDateTime(
                                      emotionEntry.month,
                                      emotionEntry.day,
                                      emotionEntry.year);
                              _emotionController.deleteEmotionEntry(part);
                              
                              Get.back();
                              Get.offAndToNamed('/entriesDetailScreen');
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const SideMenu(),
      appBar: AppBar(
          primary: true,
          elevation: 1,
          leading: BackButton(
            onPressed: () {
              Get.to(HomePageScreen(0));
            },
          ),
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
        SafeArea(
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEmotionContainer(emotionEntry.eveningCheck,
                  PartOfTheDay.Evening, 'Evening Check  '),
              _buildEmotionContainer(emotionEntry.afternoonCheck,
                  PartOfTheDay.Afternoon, 'Afternoon Check  '),
              _buildEmotionContainer(emotionEntry.morningCheck,
                  PartOfTheDay.Morning, 'Morning Check  '),
              const SizedBox(height: 10.0),
              Visibility(
                visible: missedEntries > 0 && missedEntries < 3,
                child: Padding(
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
                              color: const Color(0xff216CB2).withOpacity(0.20),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Text(
                              'Make sure to add your missed entries to ensure that your wellness is being properly tracked by you and the app.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(color: Colors.white)),
                        )
                      ])),
                ),
              ),
              Visibility(
                visible: missedEntries == 3,
                child: Padding(
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
                ),
              )
            ],
          )),
        ),
      ]),
    );
  }

  PositiveEmotions(List positiveEmotions) {
    return positiveEmotions.isNotEmpty
        ? SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true, //just set this property
              padding: const EdgeInsets.all(10.0),
              itemCount: positiveEmotions.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 20,
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      color: Theme.of(context).colorScheme.accentBlue02),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(positiveEmotions[index].toString(),
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).colorScheme.neutralWhite01)),
                  ),
                );
              },
            ))
        : Text('None',
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.neutralGray01));
  }

  NegativeEmotions(List negativeEmotions) {
    return negativeEmotions.isNotEmpty
        ? SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true, //just set this property
              padding: const EdgeInsets.all(10.0),
              itemCount: negativeEmotions.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 20,
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      color: Theme.of(context).colorScheme.accentRed02),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(negativeEmotions[index].toString(),
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).colorScheme.neutralWhite01)),
                  ),
                );
              },
            ))
        : Text('None',
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.neutralGray01));
  }

  _buildEmotionContainer(entryCheck, partOfDay, title) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: ExpandablePanel(
          theme: const ExpandableThemeData(hasIcon: false),
          header: Column(children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image(
                image: moodMap[entryCheck.mood]!.icon,
                width: 62,
                height: 62,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: entryCheck.mood == 'NoData'
                          ? const EdgeInsets.only(top: 15.0)
                          : const EdgeInsets.all(0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: 'Overall Mood: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralGray04),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: (entryCheck.mood == 'NoData'
                                          ? 'Empty'
                                          : entryCheck.mood == 'VeryHappy'
                                              ? 'Very Happy'
                                              : entryCheck.mood == 'VeryBad'
                                                  ? 'Very Bad'
                                                  : entryCheck.mood),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: entryCheck.mood != 'NoData'
                                                  ? moodColor[entryCheck.mood]
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .neutralWhite04)),
                                ]),
                          ),
                          Visibility(
                            visible: entryCheck.mood != 'NoData',
                            child: PopupMenuButton(
                              icon: Icon(Icons.more_horiz,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralGray01),
                              onSelected: (value) {
                                if (value == 'Edit') {
                                  _emotionController
                                      .updatePartOfTheDayCheck(partOfDay);
                                  _emotionController
                                      .updateSelectedEmotionEntry(emotionEntry);
                                  _emotionController.updateEditMode(true);
                                  _emotionController
                                      .updateIfAddingFromDaily(false);
                                  _emotionController.updateDateTime(
                                      emotionEntry.month,
                                      emotionEntry.day,
                                      emotionEntry.year);

                                  Get.toNamed('/emotionStartScreen',
                                      arguments: {
                                        "route": 'details',
                                      });
                                } else if (value == 'Delete') {
                                  showDeleteConfirmation(partOfDay);
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
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralGray04),
                              children: <TextSpan>[
                                TextSpan(
                                    text: (entryCheck.mood != 'NoData')
                                        ? entryCheck.time
                                        : 'missed',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .neutralWhite04))
                              ]),
                        ),
                        (entryCheck.mood != 'NoData')
                            ? Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Image(
                                    image: moodMap[entryCheck.mood]!.icon,
                                    width: 24,
                                    height: 24),
                              )
                            : IconButton(
                                onPressed: () {
                                  _emotionController
                                      .updatePartOfTheDayCheck(partOfDay);
                                  _emotionController
                                      .updateIfAddingFromDaily(false);
                                  _emotionController.updateEditMode(false);
                                  _emotionController
                                      .updateIfAddingFromDaily(false);
                                  _emotionController.updateDateTime(
                                      emotionEntry.month,
                                      emotionEntry.day,
                                      emotionEntry.year);

                                  Get.toNamed('/emotionStartScreen',
                                      arguments: {
                                        "route": 'details',
                                      });
                                },
                                icon: const Icon(Icons.add_circle,
                                    color: Color(0xff4CA7FC)))
                      ],
                    )
                  ],
                ),
              ),
            ])
          ]),
          collapsed: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    height: 8.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.neutralWhite03,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)))),
                Container(
                  height: 4.5,
                  width: 75.0,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.neutralWhite01,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(24))),
                ),
              ],
            ),
          ),
          expanded: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Notes',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.neutralGray01)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                      entryCheck.note != ''
                          ? entryCheck.note
                          : 'Nothing written...',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.neutralGray01)),
                ),
                Text('Emotions you felt at this time:',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.neutralGray01)),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text('Positive',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w400,
                            color:
                                Theme.of(context).colorScheme.neutralGray04))),
                PositiveEmotions(entryCheck.positiveEmotions.toSet().toList()),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text('Negative',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w400,
                            color:
                                Theme.of(context).colorScheme.neutralGray04))),
                NegativeEmotions(entryCheck.negativeEmotions.toSet().toList()),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                          height: 8.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.neutralWhite03,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)))),
                      Container(
                        height: 4.5,
                        width: 75.0,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.neutralWhite01,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
