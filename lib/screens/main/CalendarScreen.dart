
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
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
List<DateTime> veryBadDates = [];
List<DateTime> badDates = [];
List<DateTime> neutralDates = [];
List<DateTime> goodDates = [];
List<DateTime> veryGoodDates = [];

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
  Widget _veryBadIcon(String day) => CircleAvatar(
    backgroundColor: veryBadColor,
    child: Text(day, style: const TextStyle(fontSize: 11, color: Colors.white),),
  );

  Widget _neutralIcon(String day) => CircleAvatar(
    backgroundColor: neutralColor,
    child: Text(day, style: const TextStyle(fontSize: 11, color: Colors.black),),
  );

  Widget _badIcon(String day) => CircleAvatar(
    backgroundColor: badColor,
    child: Text(day, style: const TextStyle(fontSize: 11, color: Colors.white),),
  );

  Widget _goodIcon(String day) => CircleAvatar(
    backgroundColor: goodColor,
    child: Text(day, style: const TextStyle(fontSize: 11, color: Colors.black),),
  );

  Widget _veryGoodIcon(String day) => CircleAvatar(
    backgroundColor: veryGoodColor,
    child: Text(day, style: const TextStyle(fontSize: 11, color: Colors.black),),
  );

  EventList<Event> markedDateMap = EventList<Event>(
      events: {}
  );

  @override
  Widget build(BuildContext context) {
    List<EmotionEntryHive> emotionEntry = _emotionCounterController.getEmotionEntriesForMonth(focusedDay.month, focusedDay.year);
    EmotionEntryHive selectedDayEntry = _emotionController.getEmotionEntryForDate(selectedDay);

    for (int i = 0; i < emotionEntry.length; i++) {
      var date = DateTime(emotionEntry[i].year, convertMonth(emotionEntry[i].month), emotionEntry[i].day);
      if (emotionEntry[i].overallMood == 'VeryBad') {
        markedDateMap.add(date, Event(date: date, icon: _veryBadIcon(date.day.toString())));
      } else if (emotionEntry[i].overallMood == 'Bad') {
        markedDateMap.add(date, Event(date: date, icon: _badIcon(date.day.toString())));
      } else if (emotionEntry[i].overallMood == 'Neutral') {
        markedDateMap.add(date, Event(date: date, icon: _neutralIcon(date.day.toString())));
      } else if (emotionEntry[i].overallMood == 'Happy') {
        markedDateMap.add(date, Event(date: date, icon: _goodIcon(date.day.toString())));
      } else if (emotionEntry[i].overallMood == 'VeryHappy'){
        markedDateMap.add(date, Event(date: date, icon: _veryGoodIcon(date.day.toString())));
      }
    }

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
                            child: CalendarCarousel<Event>(
                              height: 400,
                              maxSelectedDate: DateTime.now(),
                              weekendTextStyle: const TextStyle(fontSize: 11, color: Colors.black),
                              daysTextStyle: const TextStyle(fontSize: 11, color: Colors.black),
                              nextDaysTextStyle: const TextStyle(fontSize: 11, color: Colors.grey),
                              prevDaysTextStyle: const TextStyle(fontSize: 11, color: Colors.grey),
                              weekdayTextStyle: const TextStyle(fontSize: 11, color: Colors.black),
                              inactiveDaysTextStyle: const TextStyle(fontSize: 11, color: Colors.black),
                              inactiveWeekendTextStyle: const TextStyle(fontSize: 11, color: Colors.black),
                              selectedDateTime: selectedDay,
                              todayButtonColor: Colors.transparent,
                              todayBorderColor: Colors.grey,
                              daysHaveCircularBorder: true,
                              todayTextStyle: const TextStyle(fontSize: 11, color: Colors.black),
                              selectedDayBorderColor: Colors.black,
                              selectedDayButtonColor: Colors.transparent,
                              markedDateShowIcon: true,
                              markedDateMoreShowTotal: null,
                              markedDatesMap: markedDateMap,
                              markedDateIconBuilder: (event) {
                                  return event.icon;},
                              onDayPressed: (date, event) {
                                setState(() {
                                  selectedDay = date;
                                });},
                              ),
                            height: 425,
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
                                Container(
                                  decoration: containerDecoration(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: InkWell(
                                      onTap: () {
                                        _emotionController.updateSelectedEmotionEntry(selectedDayEntry);
                                        Get.toNamed('/entriesDetailScreen');
                                      },
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image(image: moodMap[selectedDayEntry.overallMood]!.icon, width: 61, height: 61,),

                                          const SizedBox(width: 10.0,),

                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                //For Date and Overall Mood
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text((selectedDayEntry.weekday.toUpperCase() + ', ' + selectedDayEntry.month.toUpperCase() + ' ' + selectedDayEntry.day.toString().toUpperCase()),
                                                          style: TextStyle(fontSize: 12.0, color: const Color(0x00C7CBCC).withOpacity(1.0)),
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                            text: 'Overall Mood: ', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.grey[800]),
                                                            children: <TextSpan> [TextSpan(text: (selectedDayEntry.overallMood != 'NoData' ? selectedDayEntry.overallMood : 'Empty'),
                                                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: overallMoodFontColor(selectedDayEntry.overallMood)))
                                                            ]
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Icon(Icons.more_horiz, color: Colors.grey[600],)
                                                  ],
                                                ),

                                                const SizedBox(height: 8.0),

                                                //For Evening Check
                                                SizedBox(
                                                  height: 30,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 170,
                                                        child: RichText(
                                                          text: TextSpan(
                                                            text: 'Evening Check ',
                                                              style: Theme.of(context).textTheme.bodyText2?.copyWith(color: (selectedDayEntry.eveningCheck.mood != 'NoData') ? const Color(0xff161818).withOpacity(1.0) : const Color(0x00C7CBCC).withOpacity(1.0)),
                                                            children: <TextSpan> [
                                                              TextSpan(text: (selectedDayEntry.eveningCheck.mood != 'NoData') ? selectedDayEntry.eveningCheck.time : 'missed',
                                                                style: TextStyle(fontSize: 12, color: const Color(0x00C7CBCC).withOpacity(1.0))
                                                              ),
                                                            ]
                                                          ),
                                                        ),
                                                      ),
                                                      (selectedDayEntry.eveningCheck.mood != 'NoData') ? Padding(
                                                        padding: const EdgeInsets.only(left: 15.0),
                                                        child: Image(
                                                            image: moodMap[selectedDayEntry.eveningCheck.mood]!.icon,
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

                                                const SizedBox(height: 8.0),

                                                //For Afternoon Check
                                                SizedBox(
                                                  height: 30,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 170,
                                                        child: RichText(
                                                          text: TextSpan(
                                                              text: 'Afternoon Check ',
                                                              style: Theme.of(context).textTheme.bodyText2?.copyWith(color: (selectedDayEntry.afternoonCheck.mood != 'NoData') ? const Color(0xff161818).withOpacity(1.0) : const Color(0x00C7CBCC).withOpacity(1.0)),
                                                              children: <TextSpan> [
                                                                TextSpan(text: (selectedDayEntry.afternoonCheck.mood != 'NoData') ? selectedDayEntry.afternoonCheck.time : 'missed',
                                                                    style: TextStyle(fontSize: 12, color: const Color(0x00C7CBCC).withOpacity(1.0))
                                                                ),
                                                              ]
                                                          ),
                                                        ),
                                                      ),
                                                      (selectedDayEntry.afternoonCheck.mood != 'NoData') ? Padding(
                                                        padding: const EdgeInsets.only(left: 15.0),
                                                        child: Image(
                                                            image: moodMap[selectedDayEntry.afternoonCheck.mood]!.icon,
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

                                                const SizedBox(height: 8.0),

                                                //For Morning Check
                                                SizedBox(
                                                  height: 30,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 170,
                                                        child: RichText(
                                                          text: TextSpan(
                                                              text: 'Morning Check ',
                                                              style: Theme.of(context).textTheme.bodyText2?.copyWith(color: (selectedDayEntry.morningCheck.mood != 'NoData') ? const Color(0xff161818).withOpacity(1.0) : const Color(0x00C7CBCC).withOpacity(1.0)),
                                                              children: <TextSpan> [
                                                                TextSpan(text: (selectedDayEntry.morningCheck.mood != 'NoData') ? selectedDayEntry.morningCheck.time : 'missed',
                                                                    style: TextStyle(fontSize: 12, color: const Color(0x00C7CBCC).withOpacity(1.0))
                                                                ),
                                                              ]
                                                          ),
                                                        ),
                                                      ),
                                                      (selectedDayEntry.morningCheck.mood != 'NoData') ? Padding(
                                                        padding: const EdgeInsets.only(left: 15.0),
                                                        child: Image(
                                                            image: moodMap[selectedDayEntry.morningCheck.mood]!.icon,
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
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
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

  convertMonth(String month) {
    if (month == 'January') {return 1;}
    else if (month == 'February') {return 2;}
    else if (month == 'March') {return 3;}
    else if (month == 'April') {return 4;}
    else if (month == 'May') {return 5;}
    else if (month == 'June') {return 6;}
    else if (month == 'July') {return 7;}
    else if (month == 'August') {return 8;}
    else if (month == 'September') {return 9;}
    else if (month == 'October') {return 10;}
    else if (month == 'November') {return 11;}
    else if (month == 'December') {return 12;}
  }

  overallMoodFontColor(String mood) {
    if (mood == 'VeryBad') {
      return veryBadColor;
    } else if (mood == 'Bad') {
      return badColor;
    } else if (mood == 'Neutral') {
      return neutralColor;
    } else if (mood == 'Good') {
      return goodColor;
    } else if (mood == 'VeryGood') {
      return veryGoodColor;
    } else {
      return Colors.black;
    }
  }
}