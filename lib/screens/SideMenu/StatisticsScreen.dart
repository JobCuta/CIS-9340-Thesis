import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/emotionEntryHive.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/emotionController.dart';
import 'package:flutter_application_1/models/Mood.dart';
import 'package:flutter_application_1/screens/main/SideMenu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  EmotionController _emotionController = Get.put(EmotionController());
  int month = DateTime.now().month;
  int year = DateTime.now().year;
  int currentWeekDay = DateTime.now().weekday;
  Map<int, String> weekdayString = {
    1: 'Mon',
    2: 'Tue',
    3: 'Wed',
    4: 'Thu',
    5: 'Fri',
    6: 'Sat',
    7: 'Sun'
  };

  @override
  Widget build(BuildContext context) {
    // these 3 methods will update days in a row, longest chain, and mood count for the month
    List<EmotionEntryHive> latestEmotionEntries = _emotionController.getEmotionEntriesInTheLastDays(7);
    _emotionController.updateLongestStreak();
    _emotionController.updateCurrentStreakAndMonthMoodCount(DateTime.now().month, DateTime.now().year);
    

    return Scaffold(
        appBar: AppBar(
          primary: true,
          elevation: 1,
          backgroundColor: const Color(0xff216CB2).withOpacity(0.40),
          title: Text('Your statistics',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.neutralWhite01)),
        ),
        drawer: const SideMenu(),
        extendBodyBehindAppBar: true,
        body: Stack(children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/background_images/blue_background.png',
                      ),
                      fit: BoxFit.cover))),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 120, 25, 0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Days in a row',
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralBlack02,
                                  fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(height: 10.0),

                        Center(
                          child: SizedBox(
                            height: 50,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: latestEmotionEntries.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        latestEmotionEntries[index]
                                                    .overallMood !=
                                                'NoData'
                                            ? SvgPicture.asset(
                                                'assets/images/blue_checkmark.svg',
                                                width: 30)
                                            : SvgPicture.asset(
                                                'assets/images/gray_x.svg',
                                                width: 32),
                                        Text(
                                            (latestEmotionEntries[index]
                                                    .weekday)
                                                .substring(0, 3),
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
                                  );
                                }),
                          ),
                        ),

                        const SizedBox(height: 10.0),
                        Center(
                          child: Text(
                            _emotionController.currentStreak.value.toString() +
                                ' ' +
                                ((_emotionController.currentStreak.value > 1)
                                    ? 'days'
                                    : 'day') +
                                ' in a row',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralBlack02,
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Divider(
                          color: Color(0xffF0F1F1),
                          height: 25,
                          thickness: 1,
                        ),

                        RichText(
                          text: TextSpan(children: [
                            WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Icon(Icons.emoji_events_outlined,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .sunflowerYellow03,
                                      size: 28.0),
                                )),
                            TextSpan(
                                text:
                                    'Longest chain: ${_emotionController.longestStreak.value}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralGray03)),
                          ]),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 0.0),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mood Count for the Month',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralBlack02,
                                    fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Image(
                                        image: moodMap['VeryBad']!.icon,
                                        width: 42.0),
                                  ),
                                  Text(
                                      '${_emotionController.monthMoodCount[0]}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .moodVeryBad)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Image(
                                        image: moodMap['Bad']!.icon,
                                        width: 42.0),
                                  ),
                                  Text(
                                      '${_emotionController.monthMoodCount[1]}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .moodBad)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Image(
                                        image: moodMap['Neutral']!.icon,
                                        width: 42.0),
                                  ),
                                  Text(
                                      '${_emotionController.monthMoodCount[2]}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .moodNeutral)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Image(
                                        image: moodMap['Happy']!.icon,
                                        width: 42.0),
                                  ),
                                  Text(
                                      '${_emotionController.monthMoodCount[3]}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .moodHappy)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Image(
                                        image: moodMap['VeryHappy']!.icon,
                                        width: 42.0),
                                  ),
                                  Text(
                                      '${_emotionController.monthMoodCount[4]}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .moodVeryHappy)),
                                ],
                              ),
                            ],
                          ),
                          const Divider(
                            color: Color(0xffF0F1F1),
                            height: 25,
                            thickness: 1,
                          ),
                          Text(
                              'Total moods: ' +
                                  (_emotionController.monthMoodCount[0] +
                                          _emotionController.monthMoodCount[1] +
                                          _emotionController.monthMoodCount[2] +
                                          _emotionController.monthMoodCount[3] +
                                          _emotionController.monthMoodCount[4])
                                      .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralGray03)),
                        ],
                      ),
                    ),
                  ),
                  const ScoreCards(
                      title: 'Your latest PHQ-9 score for this month',
                      score: 5,
                      total: 28,
                      link: '/phqStatScreen'),
                  const SizedBox(height: 20),
                  const ScoreCards(
                      title:
                          'Your latest Suicidal Ideation score for this month',
                      score: 34,
                      total: 50,
                      link: '/sidasStatScreen'),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
        ]));
  }
}

class ScoreCards extends StatelessWidget {
  final String title, link;
  final int score, total;
  const ScoreCards({
    required this.title,
    required this.score,
    required this.total,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: Theme.of(context).colorScheme.neutralBlack02,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: score.toString(),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Theme.of(context).colorScheme.accentBlue02)),
              TextSpan(
                  text: '/' + total.toString(),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Theme.of(context).colorScheme.accentBlue04)),
            ]),
          ),
          const SizedBox(height: 20),
          LinearPercentIndicator(
            lineHeight: 30,
            percent: (score / total),
            progressColor: Theme.of(context).colorScheme.accentBlue02,
            backgroundColor: Theme.of(context).colorScheme.accentBlue04,
            barRadius: const Radius.circular(4),
          ),
          const SizedBox(height: 20),
          Text(
            'High Ideation',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
            'Seek Treatment',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.neutralGray01),
          ),
          const SizedBox(height: 10),
          const Divider(
            color: Color(0xffF0F1F1),
            thickness: 1,
          ),
          TextButton(
            onPressed: () {
              log('link $link');
              Get.toNamed(link);
            },
            style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                primary: Theme.of(context).colorScheme.neutralGray03),
            child: const Text(
              'Show past assessments',
            ),
          ),
        ],
      ),
    );
  }
}
