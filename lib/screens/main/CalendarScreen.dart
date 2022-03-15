
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

  TextEditingController missedDays = TextEditingController();
  TextEditingController emotionCounter = TextEditingController();

  //Emotion colors
  Color color1 = const Color.fromRGBO(78, 72, 146, 1);
  Color color2 = const Color.fromRGBO(69, 69, 69, 1);
  Color color3 = const Color.fromRGBO(17, 172, 221, 1);
  Color color4 = const Color.fromRGBO(255, 178, 89, 1);
  Color color5 = const Color.fromRGBO(0, 191, 88, 1);

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
                        decoration: const BoxDecoration(color: Color.fromRGBO(50, 144, 255, 0.6)),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Your overall mood for today',
                            style: TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        height: 184, width: MediaQuery.of(context).size.width , decoration: containerDecoration(),
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
}