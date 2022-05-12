import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/emotionEntryHive.dart';
import 'package:flutter_application_1/apis/phqHive.dart';
import 'package:flutter_application_1/apis/sidasHive.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/emotionController.dart';
import 'package:flutter_application_1/models/Mood.dart';
import 'package:flutter_application_1/screens/SideMenu/SideMenu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late EmotionController _emotionController;
  late List<EmotionEntryHive> latestEmotionEntries =
      _emotionController.getEmotionEntriesInTheLastDays(7);
  late int latestPHQScore;
  late int latestSIDASScore;

  DateTime now = DateTime.now();
  late int month = DateTime.now().month;
  late int year = DateTime.now().year;
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

  late final Box hiveBox;
  late final Box sidasBox;
  List phqList = [], sidasList = [], uniqueMonths = [];
  List<List<dynamic>> splitMonths = [];
  List<dynamic> phqEntries = [];
  List<dynamic> sidasEntries = [];

  List<FlSpot>? phqSpots = [];
  List<FlSpot>? sidasSpots = [];

  sortEntries() {
    var seenMonths = <DateTime>{};
    // number of months to divide entries by
    uniqueMonths = phqList
        .where((entry) =>
            seenMonths.add(DateTime(entry.date.year, entry.date.month)))
        .toList();

    uniqueMonths = List.from(uniqueMonths.reversed);

    // loop through unique months as each card.
    // filter entries where date matches the unique month
    for (var date in seenMonths) {
      List entries = phqList
          .where((entry) =>
              (entry.date.year == date.year) && entry.date.month == date.month)
          .toList();
      entries = List.from(entries.reversed);

      splitMonths.add(entries);
    }
    splitMonths = List.from(splitMonths.reversed);
    // final result is in splitMonths
    log('split months $splitMonths}');
  }

  getPHQEntriesForTheYear() {
    DateTime now = DateTime.now();
    for (List<dynamic> item in splitMonths) {
      for (phqHive value in item) {
        if (value.date.year == now.year) {
          phqEntries.add(value);
        }
      }
    }
    for (int i = 0; i < phqEntries.length; i++) {
      phqSpots!.add(FlSpot(i.toDouble(), phqEntries[i].score.toDouble()));
      if (i == 0) {
        latestPHQScore = phqEntries[i].score;
      }
    }
  }

  getSIDASEntriesForTheYear() {
    DateTime now = DateTime.now();
    for (sidasHive value in sidasList) {
      if (value.date.year == now.year) {
        sidasEntries.add(value);
      }
    }

    sidasEntries = List.from(sidasEntries.reversed);

    for (int i = 0; i < sidasEntries.length; i++) {
      sidasSpots!.add(FlSpot(i.toDouble(), sidasEntries[i].score.toDouble()));
      if (i == 0) {
        latestSIDASScore = sidasEntries[i].score;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // these methods will update days in a row, longest chain, and mood count for the month
    _emotionController = Get.put(EmotionController());
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _emotionController.updateLongestStreak();
      _emotionController.updateCurrentStreakAndMonthMoodCount(
          now.month, now.year);
    });
    month = now.month;
    year = now.year;
    hiveBox = Hive.box('phq');
    phqList = hiveBox.values.toList();
    sidasBox = Hive.box('sidas');
    sidasList = sidasBox.values.toList();
    sortEntries();
    getPHQEntriesForTheYear();
    getSIDASEntriesForTheYear();
  }

  @override
  Widget build(BuildContext context) {
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
        extendBodyBehindAppBar: true,
        drawer: const SideMenu(),
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
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
                                          left: 5.0, right: 5.0),
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
                                                      fontWeight:
                                                          FontWeight.w400,
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
                              _emotionController.currentStreak.value
                                      .toString() +
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
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
                                            _emotionController
                                                .monthMoodCount[1] +
                                            _emotionController
                                                .monthMoodCount[2] +
                                            _emotionController
                                                .monthMoodCount[3] +
                                            _emotionController
                                                .monthMoodCount[4])
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
                    ScoreCards(
                        title: 'Your latest PHQ-9 score for this month',
                        score: latestPHQScore,
                        total: 27,
                        link: '/phqStatScreen'),
                    Visibility(
                      visible: phqEntries.length > 1,
                      child: phqChart(),
                    ),
                    Visibility(
                        visible: phqEntries.length <= 1,
                        child: const SizedBox(height: 20)),
                    ScoreCards(
                        title:
                            'Your latest Suicidal Ideation score for this month',
                        score: latestSIDASScore,
                        total: 50,
                        link: '/sidasStatScreen'),
                    Visibility(
                      visible: sidasEntries.length > 1,
                      child: sidasChart(),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )
        ]));
  }

  phqChart() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 380,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'PHQ Graph',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    color: Theme.of(context).colorScheme.neutralBlack02,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  constraints:
                      const BoxConstraints(minWidth: 200, maxWidth: 600),
                  width: 350,
                  height: 300,
                  padding: const EdgeInsets.only(right: 30, top: 10),
                  child: LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                            maxContentWidth: 100,
                            tooltipBgColor:
                                Theme.of(context).colorScheme.neutralWhite04,
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots
                                  .map((LineBarSpot touchedSpot) {
                                final textStyle = TextStyle(
                                  color: touchedSpot.bar.gradient?.colors[0] ??
                                      touchedSpot.bar.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                );
                                return LineTooltipItem(
                                    touchedSpot.y.toStringAsFixed(0),
                                    textStyle);
                              }).toList();
                            }),
                        handleBuiltInTouches: true,
                        getTouchLineStart: (data, index) => 0,
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          color: Theme.of(context).colorScheme.accentBlue02,
                          spots: phqSpots,
                          isCurved: true,
                          isStrokeCapRound: true,
                          barWidth: 3,
                          belowBarData: BarAreaData(
                            show: false,
                          ),
                          dotData: FlDotData(show: true),
                        ),
                      ],
                      minY: 0,
                      maxY: 27,
                      titlesData: FlTitlesData(
                        show: true,
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          axisNameWidget: Text(
                            year.toString(),
                          ),
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            reservedSize: 40,
                            getTitlesWidget: phqBottomTitleWidgets,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          axisNameSize: 30,
                          axisNameWidget: const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text('PHQ Score'),
                          ),
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 3,
                            reservedSize: 40,
                            getTitlesWidget: leftTitleWidgets,
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          drawHorizontalLine: true,
                          verticalInterval: 1,
                          horizontalInterval: 5),
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
              )
            ]));
  }

  sidasChart() {
    return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'SIDAS Graph',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    color: Theme.of(context).colorScheme.neutralBlack02,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: const EdgeInsets.only(right: 30, top: 10),
                  constraints:
                      const BoxConstraints(minWidth: 200, maxWidth: 600),
                  width: 350,
                  height: 300,
                  child: LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                            maxContentWidth: 100,
                            tooltipBgColor:
                                Theme.of(context).colorScheme.neutralWhite04,
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots
                                  .map((LineBarSpot touchedSpot) {
                                final textStyle = TextStyle(
                                  color: touchedSpot.bar.gradient?.colors[0] ??
                                      touchedSpot.bar.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                );
                                return LineTooltipItem(
                                    touchedSpot.y.toStringAsFixed(0),
                                    textStyle);
                              }).toList();
                            }),
                        handleBuiltInTouches: true,
                        getTouchLineStart: (data, index) => 0,
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          color: Theme.of(context).colorScheme.accentBlue02,
                          spots: sidasSpots,
                          isCurved: true,
                          isStrokeCapRound: true,
                          barWidth: 3,
                          belowBarData: BarAreaData(
                            show: false,
                          ),
                          dotData: FlDotData(show: true),
                        ),
                      ],
                      minY: 0,
                      maxY: 50,
                      titlesData: FlTitlesData(
                        show: true,
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          axisNameWidget: Text(
                            year.toString(),
                          ),
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            reservedSize: 40,
                            getTitlesWidget: sidasBottomTitleWidgets,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          axisNameSize: 30,
                          axisNameWidget: const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text('SIDAS Score'),
                          ),
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 5,
                            reservedSize: 40,
                            getTitlesWidget: leftTitleWidgets,
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          drawHorizontalLine: true,
                          verticalInterval: 1,
                          horizontalInterval: 5),
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
              )
            ]));
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return Text(value.toInt().toString());
  }

  Widget phqBottomTitleWidgets(double value, TitleMeta meta) {
    return Padding(
        child: Text(
          '${DateFormat.MMMM().format(phqEntries[value.toInt()].date)} \n${DateFormat.d().format(phqEntries[value.toInt()].date)}',
          textAlign: TextAlign.center,
        ),
        padding: const EdgeInsets.only(top: 8.0));
  }

  Widget sidasBottomTitleWidgets(double value, TitleMeta meta) {
    return Padding(
        child: Text(
          '${DateFormat.MMMM().format(sidasEntries[value.toInt()].date)} \n${DateFormat.d().format(sidasEntries[value.toInt()].date)}',
          textAlign: TextAlign.center,
        ),
        padding: const EdgeInsets.only(top: 8.0));
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
          borderRadius: BorderRadius.all(Radius.circular(4))),
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
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontFamily: 'Inconsolata',
                      color: Theme.of(context).colorScheme.accentBlue02)),
              TextSpan(
                  text: '/' + total.toString(),
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontFamily: 'Inconsolata',
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
          link == '/phqStatScreen'
              ? Text(
                  score >= 20
                      ? 'Severe Depression'
                      : score >= 15
                          ? 'Moderately Severe Depression'
                          : score >= 10
                              ? 'Moderate Depression'
                              : score >= 5
                                  ? 'Mild Depression'
                                  : 'None - Minimal Depression',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.neutralBlack02),
                )
              : Text(
                  score >= 21
                      ? 'High Suicidal Ideation'
                      : 'Low Suicidal Ideation',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.neutralBlack02),
                ),
          const SizedBox(height: 10),
          Visibility(
            visible: link == '/sidasStatScreen',
            child: Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                score >= 21 ? 'Seek Treatment' : 'Good job! Keep it up!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.neutralGray02),
              ),
            ),
          ),
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
