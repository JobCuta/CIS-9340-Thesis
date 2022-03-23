
import 'SideMenu.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_application_1/apis/emotionEntryHive.dart';
import 'package:flutter_application_1/controllers/emotionController.dart';
import 'package:flutter_application_1/enums/PartOfTheDay.dart';
import 'package:flutter_application_1/models/Mood.dart';
import 'package:get/get.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CalendarScreenState();
}

final EmotionController _emotionController = Get.put(EmotionController());

class _CalendarScreenState extends State<CalendarScreen>{
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  String displayedDate = DateFormat('EEEE, MMMM d').format(DateTime.now());
  List<EmotionEntryHive> emotionEntries = _emotionController.getAllEmotionEntries();

  TextEditingController missedDays = TextEditingController();
  TextEditingController emotionCounter = TextEditingController();
  TextEditingController moodController = TextEditingController();

  //Emotion colors
  Color color1 = const Color.fromRGBO(78, 72, 146, 1);
  Color color2 = const Color.fromRGBO(69, 69, 69, 1);
  Color color3 = const Color.fromRGBO(17, 172, 221, 1);
  Color color4 = const Color.fromRGBO(255, 178, 89, 1);
  Color color5 = const Color.fromRGBO(0, 191, 88, 1);

  //Status colors
  Color? filled = Colors.grey[700];
  Color? unfilled = Colors.grey[400];
  Color? timeFilled = Colors.grey[400];

  //Image paths
  String happyPath = 'assets/images/face_happy_selected.png';
  String addPath = 'assets/images/add.png';
  String neutralPath = 'assets/images/face_neutral_selected.png';
  Image happy = Image.asset('assets/images/face_happy_selected.png', height: 60, width: 60);

  Container _checkIfMonthLabelToDisplay(int index) {
    if (emotionEntries[index].month != emotionEntries[index--].month) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
            vertical: 12.0, horizontal: 12.0),
        decoration: BoxDecoration(
            color: const Color(0xff216CB2).withOpacity(1.00),
            borderRadius:
            const BorderRadius.all(Radius.circular(10))),
        child: Text(
            emotionEntries[index--].month + " " + emotionEntries[index--].day.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white)),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        primary: true,
        elevation: 0,
        backgroundColor: const Color(0xff216CB2).withOpacity(0.40),
      ),
      drawer: SideMenu(),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_images/blue_background.png'),
            fit: BoxFit.cover))),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16, top: 100, bottom: 16),
                    child: Container(
                      decoration: containerDecoration(),
                      height: 330.0,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 222,
                            child: Column(
                              children: [
                                TableCalendar(
                                  focusedDay: selectedDay,
                                  firstDay: DateTime(1, 1, 2022),
                                  lastDay: DateTime.now(),
                                  onFormatChanged: (CalendarFormat _format) {
                                    setState(() {
                                      format = _format;
                                    });
                                  },
                                  rowHeight: 25.0,

                                  //Day Changed
                                  onDaySelected: (DateTime selectDay, DateTime focusDay) {
                                    setState(() {
                                      selectedDay = selectDay;
                                      focusedDay = focusDay;
                                    });
                                  },
                                  selectedDayPredicate: (DateTime date) {
                                    return isSameDay(selectedDay, date);
                                  },

                                  //Header Design
                                  headerStyle: HeaderStyle(
                                    formatButtonVisible: false,
                                    titleCentered: true,
                                    titleTextStyle: const TextStyle(fontSize: 12.0),
                                    titleTextFormatter: (date, locale) => DateFormat.yMMM(locale).format(date),
                                    headerPadding: const EdgeInsets.all(0)
                                  ),

                                  daysOfWeekStyle: DaysOfWeekStyle(
                                    dowTextFormatter: (date, locale) => DateFormat.E(locale).format(date),
                                    weekendStyle: const TextStyle(fontSize: 11),
                                    weekdayStyle: const TextStyle(fontSize: 11),
                                  ),

                                  //Calendar Design
                                  calendarStyle: const CalendarStyle(
                                    defaultTextStyle: TextStyle(fontSize: 11),
                                    weekendTextStyle: TextStyle(fontSize: 11),
                                    todayTextStyle: TextStyle(fontSize: 11),
                                    selectedTextStyle: TextStyle(fontSize: 11),
                                    disabledTextStyle: TextStyle(fontSize: 11),
                                    outsideTextStyle: TextStyle(fontSize: 11),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Divider(
                              height: 10,
                              color: Color.fromRGBO(196, 196, 196, 1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 50.0, width: 50.0,
                                  decoration: emotionCounterStyle(color1),
                                  child: Container(
                                      height: 39, width: 39, decoration: emotionBorder(),
                                      child: Center(child: Text('0', style: emotionCounterTextStyle()),)),
                                ),
                                Container(
                                  height: 50.0, width: 50.0,
                                  decoration: emotionCounterStyle(color2),
                                  child: Container(
                                      height: 39, width: 39, decoration: emotionBorder(),
                                      child: Center(child: Text('0', style: emotionCounterTextStyle()))),
                                ),
                                Container(
                                  height: 50.0, width: 50.0,
                                  decoration: emotionCounterStyle(color3),
                                  child: Container(
                                      height: 39, width: 39, decoration: emotionBorder(),
                                      child: Center(child: Text('0', style: emotionCounterTextStyle()))),
                                ),
                                Container(
                                  height: 50.0, width: 50.0,
                                  decoration: emotionCounterStyle(color4),
                                  child: Container(
                                      height: 39, width: 39, decoration: emotionBorder(),
                                      child: Center(child: Text('0', style: emotionCounterTextStyle()))),
                                ),
                                Container(
                                  height: 50.0, width: 50.0,
                                  decoration: emotionCounterStyle(color5),
                                  child: Container(
                                      height: 39, width: 39, decoration: emotionBorder(),
                                      child: Center(child: Text('0', style: emotionCounterTextStyle()))),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'You missed ',
                                  style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                                  children: <TextSpan>[
                                    TextSpan(text: missedDays.text, style: const TextStyle(fontWeight: FontWeight.bold)),
                                    const TextSpan(text: ' days! '),
                                    TextSpan(
                                      text: 'Add an entry',
                                      style: TextStyle(color: Colors.blue[300]),
                                      recognizer: TapGestureRecognizer()..onTap = () {
                                        //navigation
                                      }
                                    )
                                  ]
                                )

                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                Column(
                  children: [
                    Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 40.0, width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(color: const Color.fromRGBO(50, 144, 255, 0.4), borderRadius: BorderRadius.circular(5)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text('Your overall mood for today',
                                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                ListView.builder(
                                    reverse: true,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: emotionEntries.length,
                                    itemBuilder: (context, index) {
                                    return Container(
                                      height: 220,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: containerDecoration(),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 20),
                                        child: InkWell(
                                          onTap: () {
                                            _emotionController.updateSelectedEmotionEntry(emotionEntries[index]);
                                            Get.toNamed('/entriesDetailScreen');
                                          },
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Image(
                                                  image: moodMap[emotionEntries[index].overallMood]!.icon,
                                                  width: 60, height: 60,),],
                                              ),
                                              const SizedBox(width: 10.0),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width - 122,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(displayedDate.toUpperCase(),
                                                                style: const TextStyle(
                                                                    color: Colors.grey,
                                                                    fontSize: 12)),
                                                            RichText(
                                                              text: TextSpan(
                                                                  text: 'Overall Mood: ',
                                                                  style: statusTextStyle(16.0, filled),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: emotionEntries[index].overallMood,
                                                                        style: TextStyle(color: color4))
                                                                  ]
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Icon(Icons.more_horiz,
                                                            color: Colors.grey[600])
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        RichText(
                                                          text: TextSpan(
                                                              text: 'Evening check ',
                                                              style: statusTextStyle(14.0, checkIfFilledDay(emotionEntries[index].eveningCheck.time)),
                                                              children: <
                                                                  TextSpan>[
                                                                TextSpan(
                                                                    text: checkIfFilledTime(emotionEntries[index].eveningCheck.time),
                                                                    style: statusTextStyle(12.0, timeFilled))
                                                              ]
                                                          ),
                                                        ),
                                                        (emotionEntries[index].eveningCheck.mood != 'NoData')
                                                            ? Image(
                                                            image: moodMap[emotionEntries[index].eveningCheck.mood]!.icon, width: 24, height: 24
                                                        )
                                                            : IconButton(onPressed: () {
                                                                _emotionController.updatePartOfTheDayCheck(PartOfTheDay.Evening);
                                                                _emotionController.updateIfAddingFromDaily(false);
                                                                _emotionController.updateEditMode(false);
                                                                Get.toNamed('/emotionStartScreen');
                                                              }, icon: Icon(Icons.add_circle, color: const Color(0x004CA7FC).withOpacity(1.0)))
                                                      ],
                                                    ),
                                                    //const SizedBox(height: 15),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        RichText(
                                                          text: TextSpan(
                                                              text: 'Afternoon check ',
                                                              style: statusTextStyle(14.0, checkIfFilledDay(emotionEntries[index].afternoonCheck.time)),
                                                              children: <TextSpan>[
                                                                TextSpan(
                                                                    text: checkIfFilledTime(emotionEntries[index].afternoonCheck.time),
                                                                    style: statusTextStyle(12.0, timeFilled))
                                                              ]
                                                          ),
                                                        ),
                                                        (emotionEntries[index].afternoonCheck.mood != 'NoData')
                                                            ? Image(
                                                            image: moodMap[emotionEntries[index].afternoonCheck.mood]!.icon, width: 24, height: 24)
                                                            : IconButton(onPressed: () {
                                                                _emotionController.updatePartOfTheDayCheck(PartOfTheDay.Afternoon);
                                                                _emotionController.updateIfAddingFromDaily(false);
                                                                _emotionController.updateEditMode(false);
                                                                Get.toNamed('/emotionStartScreen');
                                                              }, icon: Icon(Icons.add_circle, color: const Color(0x004CA7FC).withOpacity(1.0)))
                                                      ],
                                                    ),
                                                    // const SizedBox(height: 15),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        RichText(
                                                          text: TextSpan(
                                                              text: 'Morning check ',
                                                              style: statusTextStyle(14.0, checkIfFilledDay(emotionEntries[index].morningCheck.time)),
                                                              children: <TextSpan>[
                                                                TextSpan(
                                                                    text: checkIfFilledTime(emotionEntries[index].morningCheck.time),
                                                                    style: statusTextStyle(12.0, timeFilled))
                                                              ]
                                                          ),
                                                        ),
                                                        (emotionEntries[index].morningCheck.mood != 'NoData')
                                                            ? Image(
                                                            image: moodMap[emotionEntries[index].morningCheck.mood]!.icon, width: 24, height: 24
                                                        )
                                                            : IconButton(onPressed: () {
                                                                _emotionController.updatePartOfTheDayCheck(PartOfTheDay.Morning);
                                                                _emotionController.updateIfAddingFromDaily(false);
                                                                _emotionController.updateEditMode(false);
                                                                Get.toNamed('/emotionStartScreen');
                                                              }, icon: Icon(Icons.add_circle, color: const Color(0x004CA7FC).withOpacity(1.0)))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  ),
                                const SizedBox(height: 100.0),
                              ],
                            ),
                          )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  emotionCounterStyle(color) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: color,
      border: Border.all(width: 2.0, color: color)
    );
  }

  emotionBorder() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(width: 2.0, color: Colors.white)
    );
  }

  emotionCounterTextStyle() {
    return const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'Proxima Nova'
    );
  }

  containerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  statusTextStyle(size, color) {
    return TextStyle(
        fontSize: size, fontWeight: FontWeight.w600, color: color, fontFamily: 'Proxima Nova'
    );
  }
  
  emotionImage(path, height, width) {
    return Image.asset(
      path, height: height, width: width);
  }

  checkIfFilledDay (String check) {
    if (check.isEmpty) {
      return unfilled;
    } else {
      return filled;
    }
  }

  checkIfFilledTime(String check) {
    if (check.isEmpty) {
      return 'missed';
    } else {
      return check;
    }
  }
}