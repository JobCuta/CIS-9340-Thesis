
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
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
  EmotionController _emotionCounterController = Get.put(EmotionController());

  TextEditingController missedDays = TextEditingController();
  TextEditingController emotionCounter = TextEditingController();
  TextEditingController moodController = TextEditingController();

  //Emotion colors
  Color veryBadColor = const Color.fromRGBO(78, 72, 146, 1);
  Color badColor = const Color.fromRGBO(69, 69, 69, 1);
  Color neutralColor = const Color.fromRGBO(17, 172, 221, 1);
  Color goodColor = const Color.fromRGBO(255, 178, 89, 1);
  Color veryGoodColor = const Color.fromRGBO(0, 191, 88, 1);

  //Status colors
  Color? filled = Colors.grey[700];
  Color? unfilled = Colors.grey[400];
  Color? timeFilled = Colors.grey[400];

  //Image paths
  String happyPath = 'assets/images/face_happy_selected.png';
  String addPath = 'assets/images/add.png';
  String neutralPath = 'assets/images/face_neutral_selected.png';
  Image happy = Image.asset('assets/images/face_happy_selected.png', height: 60, width: 60);

  //Calendar Carousel
  Widget _veryBad(String day) => CircleAvatar(
    backgroundColor: badColor,
    child: Text(
      day,
    ),
  );

  Widget _neutral(String day) => CircleAvatar(
    backgroundColor: neutralColor,
    child: Text(
      day,
    ),
  );

  Widget _bad(String day) => CircleAvatar(
    backgroundColor: veryBadColor,
    child: Text(
      day,
    ),
  );

  Widget _good(String day) => CircleAvatar(
    backgroundColor: goodColor,
    child: Text(
      day,
    ),
  );

  Widget _veryGood(String day) => CircleAvatar(
    backgroundColor: veryGoodColor,
    child: Text(
      day,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {}
  );

  CalendarCarousel _calendarCarouselNoHeader = CalendarCarousel<Event>(
    height: 400,
    weekendTextStyle: const TextStyle(fontSize: 11),
    weekdayTextStyle: const TextStyle(fontSize: 11),
    selectedDateTime: DateTime.now(),
    markedDateShowIcon: true,
    markedDateMoreShowTotal: null,
    dayPadding: 0,
  );

  @override
  Widget build(BuildContext context) {
    List<EmotionEntryHive> emotionEntry = _emotionCounterController.getEmotionEntriesForMonth(focusedDay.month, focusedDay.year);
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
                      child: Column(
                        children: [
                          SizedBox(
                            child: _calendarCarouselNoHeader,
                            height: 200,
                          ),
                          /*SizedBox(
                            height: 200,
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
                          ),*/
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
                                  decoration: emotionCounterStyle(veryBadColor),
                                  child: Container(
                                      height: 39, width: 39, decoration: emotionBorder(),
                                      child: Center(child: Text('${_emotionCounterController.monthMoodCount[0]}', style: emotionCounterTextStyle()),)),
                                ),
                                Container(
                                  height: 50.0, width: 50.0,
                                  decoration: emotionCounterStyle(badColor),
                                  child: Container(
                                      height: 39, width: 39, decoration: emotionBorder(),
                                      child: Center(child: Text('${_emotionCounterController.monthMoodCount[1]}', style: emotionCounterTextStyle()))),
                                ),
                                Container(
                                  height: 50.0, width: 50.0,
                                  decoration: emotionCounterStyle(neutralColor),
                                  child: Container(
                                      height: 39, width: 39, decoration: emotionBorder(),
                                      child: Center(child: Text('${_emotionCounterController.monthMoodCount[2]}', style: emotionCounterTextStyle()))),
                                ),
                                Container(
                                  height: 50.0, width: 50.0,
                                  decoration: emotionCounterStyle(goodColor),
                                  child: Container(
                                      height: 39, width: 39, decoration: emotionBorder(),
                                      child: Center(child: Text('${_emotionCounterController.monthMoodCount[3]}', style: emotionCounterTextStyle()))),
                                ),
                                Container(
                                  height: 50.0, width: 50.0,
                                  decoration: emotionCounterStyle(veryGoodColor),
                                  child: Container(
                                      height: 39, width: 39, decoration: emotionBorder(),
                                      child: Center(child: Text('${_emotionCounterController.monthMoodCount[4]}', style: emotionCounterTextStyle()))),
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
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Image(
                                                  image: moodMap[emotionEntries[index].overallMood]!.icon,
                                                  width: 62,
                                                  height: 62,
                                                ),

                                                const SizedBox(width: 10.0),

                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text((emotionEntries[index].weekday + " " + emotionEntries[index].month + " " + emotionEntries[index].day.toString()).toUpperCase(),
                                                                style: Theme.of(context).textTheme.caption!.copyWith(color: const Color(0x00C7CBCC).withOpacity(1.0)),
                                                              ),
                                                              Text('Overall Mood: ' + (emotionEntries[index].overallMood != 'NoData' ? emotionEntries[index].overallMood : 'Empty'),
                                                                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600),
                                                              ),
                                                            ],
                                                          ),
                                                          Icon(Icons.more_horiz, color: Colors.grey[600],)
                                                        ],
                                                      ),

                                                      const SizedBox(height: 10.0),

                                                      SizedBox(
                                                        height: 35,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              width: 170,
                                                              child: RichText(
                                                                text: TextSpan(
                                                                    text: 'Evening check ',
                                                                    style: Theme.of(context).textTheme.bodyText2?.copyWith(color: (emotionEntries[index].eveningCheck.mood != 'NoData') ? const Color(0xff161818).withOpacity(1.0) : const Color(0x00C7CBCC).withOpacity(1.0)),
                                                                    children: <TextSpan>[
                                                                      TextSpan(text: (emotionEntries[index].eveningCheck.mood != 'NoData') ? emotionEntries[index].eveningCheck.time : 'missed', style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0x00C7CBCC).withOpacity(1.0))
                                                                      )]
                                                                ),
                                                              ),
                                                            ),

                                                            (emotionEntries[index].eveningCheck.mood != 'NoData')
                                                                ? Padding(
                                                              padding: const EdgeInsets.only(left: 15.0),
                                                              child: Image(
                                                                  image: moodMap[emotionEntries[index].eveningCheck.mood]!.icon,
                                                                  width: 24,
                                                                  height: 24
                                                              ),
                                                            )
                                                                : Padding(
                                                                padding: const EdgeInsets.only(left: 15.0),
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      _emotionController.updatePartOfTheDayCheck(PartOfTheDay.Evening);
                                                                      _emotionController.updateIfAddingFromDaily(false);
                                                                      _emotionController.updateEditMode(false);
                                                                      Get.toNamed('/emotionStartScreen');
                                                                    },
                                                                    child: Icon(Icons.add_circle, color: const Color(0x004CA7FC).withOpacity(1.0))
                                                                )
                                                            )
                                                          ],
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        height: 35,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              width: 170,
                                                              child: RichText(
                                                                text: TextSpan(
                                                                    text: 'Afternoon check ',
                                                                    style: Theme.of(context).textTheme.bodyText2?.copyWith(color: (emotionEntries[index].afternoonCheck.mood != 'NoData') ? const Color(0xff161818).withOpacity(1.0) : const Color(0x00C7CBCC).withOpacity(1.0)),
                                                                    children: <TextSpan>[
                                                                      TextSpan(text: (emotionEntries[index].afternoonCheck.mood != 'NoData') ? emotionEntries[index].afternoonCheck.time : 'missed', style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0x00C7CBCC).withOpacity(1.0))
                                                                      )]
                                                                ),
                                                              ),
                                                            ),

                                                            (emotionEntries[index].afternoonCheck.mood != 'NoData')
                                                                ? Padding(
                                                              padding: const EdgeInsets.only(left: 15.0),
                                                                child: Image(
                                                                  image: moodMap[emotionEntries[index].afternoonCheck.mood]!.icon,
                                                                  width: 24,
                                                                  height: 24
                                                              ),
                                                            )
                                                                : Padding(
                                                                padding: const EdgeInsets.only(left: 15.0),
                                                                  child: InkWell(
                                                                    onTap: () {
                                                                      _emotionController.updatePartOfTheDayCheck(PartOfTheDay.Afternoon);
                                                                      _emotionController.updateIfAddingFromDaily(false);
                                                                      _emotionController.updateEditMode(false);
                                                                      Get.toNamed('/emotionStartScreen');
                                                                    },
                                                                    child: Icon(Icons.add_circle, color: const Color(0x004CA7FC).withOpacity(1.0))
                                                                )
                                                            )
                                                          ],
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        height: 35,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              width: 150,
                                                              child: RichText(
                                                                text: TextSpan(
                                                                    text: 'Morning check ',
                                                                    style: Theme.of(context).textTheme.bodyText2?.copyWith(color: (emotionEntries[index].morningCheck.mood != 'NoData') ? const Color(0xff161818).withOpacity(1.0) : const Color(0x00C7CBCC).withOpacity(1.0)),
                                                                    children: <TextSpan>[
                                                                      TextSpan(text: (emotionEntries[index].morningCheck.mood != 'NoData') ? emotionEntries[index].morningCheck.time : 'missed', style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0x00C7CBCC).withOpacity(1.0))
                                                                      )]
                                                                ),
                                                              ),
                                                            ),

                                                            (emotionEntries[index].morningCheck.mood != 'NoData')
                                                                ? Padding(
                                                              padding: const EdgeInsets.only(left: 15.0),
                                                                child: Image(
                                                                  image: moodMap[emotionEntries[index].morningCheck.mood]!.icon,
                                                                  width: 24,
                                                                  height: 24
                                                              ),
                                                            )
                                                                : Padding(
                                                                padding: const EdgeInsets.only(left: 15.0),
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      _emotionController.updatePartOfTheDayCheck(PartOfTheDay.Morning);
                                                                      _emotionController.updateIfAddingFromDaily(false);
                                                                      _emotionController.updateEditMode(false);
                                                                      Get.toNamed('/emotionStartScreen');
                                                                    },
                                                                    child: Icon(Icons.add_circle, color: const Color(0x004CA7FC).withOpacity(1.0))
                                                                )
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ]
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