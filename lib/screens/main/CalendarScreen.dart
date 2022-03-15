

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>{
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  String displayedDate = DateFormat('EEEE, MMMM d').format(DateTime.now());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: Colors.transparent,
      ),
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
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: containerDecoration(),
                      height: 330.0,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 222,
                            child: TableCalendar(
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
                      const SizedBox(height: 15.0),
                      Container(
                        height: 188, width: MediaQuery.of(context).size.width , decoration: containerDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                          child: Row(
                            children: [
                              Column(
                                children: [happy],
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(displayedDate.toUpperCase(), style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                          RichText(
                                            text: TextSpan(
                                              text: 'Overall Mood: ',
                                              style: statusTextStyle(16.0, filled),
                                              children: <TextSpan>[
                                                TextSpan(text: 'Happy', style: TextStyle(color: color4))
                                              ]
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(width: 100.0),
                                      Icon(Icons.more_horiz, color: Colors.grey[600])
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: <Widget>[
                                      RichText(
                                        text: TextSpan(
                                          text: 'Evening check ', style: statusTextStyle(14.0, filled),
                                          children: <TextSpan>[
                                            TextSpan(text: '22:21', style: statusTextStyle(12.0, timeFilled))
                                          ]
                                        ),
                                      ),
                                      emotionImage(happyPath, 24.0, 24.0)
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: <Widget>[
                                      RichText(
                                        text: TextSpan(
                                            text: 'Afternoon check ', style: statusTextStyle(14.0, unfilled),
                                            children: <TextSpan>[
                                              TextSpan(text: 'missed', style: statusTextStyle(12.0, timeFilled))
                                            ]
                                        ),
                                      ),
                                      emotionImage(addPath, 24.0, 24.0)
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: <Widget>[
                                      RichText(
                                        text: TextSpan(
                                            text: 'Morning check ', style: statusTextStyle(14.0, filled),
                                            children: <TextSpan>[
                                              TextSpan(text: '6:42', style: statusTextStyle(12.0, timeFilled))
                                            ]
                                        ),
                                      ),
                                      emotionImage(neutralPath, 24.0, 24.0)
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 100.0),
                    ],
                  ),
                )
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
}