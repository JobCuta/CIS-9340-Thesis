import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/dailyHive.dart';
import 'package:flutter_application_1/controllers/dailyController.dart';
import 'package:flutter_application_1/controllers/emotionController.dart';
import 'package:flutter_application_1/enums/DailyTask.dart';
import 'package:flutter_application_1/screens/main/CalendarScreen.dart';
import 'package:flutter_application_1/screens/main/EntriesScreen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../constants/notificationService.dart';
import 'SideMenu.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _selectedIndex = 2;

  static final List<Widget> _widgetOptions = <Widget>[
    const EntriesScreen(),
    const CalendarScreen(),
    const HomePage(),
    const Text('Adventure Mode'),
    const Text('Mini-games')
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, //change to confirm exit modal
      child: Scaffold(
        body: PageTransitionSwitcher(
          transitionBuilder: (Widget child, Animation<double> primaryAnimation,
                  Animation<double> secondaryAnimation) =>
              SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          ),
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomSheet: bottomNavigationBar(),
      ),
    );
  }

  //Bottom Navigation Bar
  bottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 0.0,
      backgroundColor: const Color.fromRGBO(76, 167, 252, 1.0),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Icon(Icons.notes),
          ),
          label: 'Entries',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Icon(Icons.calendar_today_outlined),
          ),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Icon(Icons.home),
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Icon(Icons.directions_walk),
            ),
            label: 'Adventure Mode'),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Icon(Icons.widgets_outlined),
          ),
          label: 'Mini-games',
        )
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: const Color.fromRGBO(33, 108, 178, 1.0),
      iconSize: 32.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: Theme.of(context)
          .textTheme
          .caption
          ?.copyWith(fontSize: 8, fontWeight: FontWeight.bold),
      unselectedLabelStyle: Theme.of(context)
          .textTheme
          .caption
          ?.copyWith(fontSize: 8, fontWeight: FontWeight.bold),
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DailyController _dailyController = Get.put(DailyController());
  final EmotionController _emotionController = Get.put(EmotionController());

  RichText displayBasedOnTaskCompleteness(bool isTaskDone) {
    return (isTaskDone)
        ? RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: 'Completed ',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: const Color(0xFFACB2B4).withOpacity(1.0))),
              WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.check_circle,
                      color: const Color(0xFF87E54C).withOpacity(1.0)))
            ]),
          )
        : RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: 'Go',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: const Color(0xFF216CB2).withOpacity(1.0))),
              WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.keyboard_arrow_right_sharp,
                      color: const Color(0xFF216CB2).withOpacity(1.0)))
            ]),
          );
  }

  @override
  Widget build(BuildContext context) {
    _dailyController.checkIfEntriesDone();
    bool _isDailyExerciseDone = _dailyController.isDailyExerciseDone.value;
    bool _isDailyEntryDone = _dailyController.isDailyEntryDone.value;
    bool _isMorningEntryDone = _dailyController.isMorningEntryDone.value;
    bool _isAfternoonEntryDone = _dailyController.isAfternoonEntryDone.value;
    bool _isEveningEntryDone = _dailyController.isEveningEntryDone.value;

    return Scaffold(
      appBar: AppBar(
        primary: true,
        elevation: 0,
        backgroundColor: const Color(0xff216CB2).withOpacity(0.40),
      ),
      extendBodyBehindAppBar: true,
      drawer: SideMenu(),
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
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 100, 25, 0),
                child: Container(
                    alignment: Alignment.center,
                    height: 110,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 18.0),
                    decoration: BoxDecoration(
                        color: const Color(0xff3290FF).withOpacity(0.60),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                    child: Column(children: [
                      Text('Welcome!',
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
                            'Remember, all is well and all will be well.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(color: Colors.white)),
                      )
                    ])),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 15.0),
                  child: Container(
                    width: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // MORNING
                        CircleAvatar(
                          radius: 24.0,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.brightness_7_sharp,
                              size: 24.0,
                              color: (_isMorningEntryDone)
                                  ? const Color(0x00FFC122).withOpacity(1.0)
                                  : const Color(0xFFACB2B4).withOpacity(1.0)),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25.0),
                            width: 100,
                            height: 15,
                            decoration: BoxDecoration(
                                color: (_isAfternoonEntryDone)
                                    ? const Color(0x00FFC122).withOpacity(1.0)
                                    : const Color(0xFFACB2B4)
                                        .withOpacity(1.0))),

                        // AFTERNOON
                        CircleAvatar(
                          radius: 24.0,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.sunny,
                              size: 24.0,
                              color: (_isAfternoonEntryDone)
                                  ? const Color(0x00FFC122).withOpacity(1.0)
                                  : const Color(0xFFACB2B4).withOpacity(1.0)),
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25.0),
                            width: 100,
                            height: 15,
                            decoration: BoxDecoration(
                                color: (_isEveningEntryDone)
                                    ? const Color(0x00FFC122).withOpacity(1.0)
                                    : const Color(0xFFACB2B4)
                                        .withOpacity(1.0))),

                        // EVENING
                        CircleAvatar(
                          radius: 24.0,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.brightness_2_sharp,
                              size: 24.0,
                              color: (_isEveningEntryDone)
                                  ? const Color(0x00FFC122).withOpacity(1.0)
                                  : const Color(0xFFACB2B4).withOpacity(1.0)),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your dailies for today',
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(
                                  color: const Color(0x004CA7FC)
                                      .withOpacity(1.0))),
                      const SizedBox(height: 10.0),
                      Text('Start your journey to wellness!',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  color: const Color(0xff161818)
                                      .withOpacity(1.0))),
                      const Divider(
                        color: Color(0xffF0F1F1),
                        height: 25,
                        thickness: 1,
                      ),
                      InkWell(
                        onTap: () {
                          _dailyController
                              .setDailyTaskToDone(DailyTask.Exercise);
                          setState(() {
                            _isDailyExerciseDone = true;
                          });
                          Get.toNamed('/wellnessScreen');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Do your daily exercise',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                        color: const Color(0xff161818)
                                            .withOpacity(1.0))),
                            displayBasedOnTaskCompleteness(_isDailyExerciseDone)
                          ],
                        ),
                      ),
                      const Divider(
                        color: Color(0xffF0F1F1),
                        height: 25,
                        thickness: 1,
                      ),
                      InkWell(
                        onTap: () {
                          if (!_isDailyEntryDone) {
                            _emotionController.updateIfAddingFromDaily(true);
                            _emotionController.updateEditMode(false);
                            Get.toNamed('/emotionStartScreen');
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Add today's entry",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                        color: const Color(0xff161818)
                                            .withOpacity(1.0))),
                            displayBasedOnTaskCompleteness(_isDailyEntryDone)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  //Add navigation to the adventure page here
                },
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 100,
                  // padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xff216CB2).withOpacity(0.55),
                  ),
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 90),
                      child: SvgPicture.asset(
                        'assets/images/bahag.svg',
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          direction: Axis.vertical,
                          children: [
                            Text('Adventure Mode',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                            const SizedBox(height: 10.0),
                            Text('Start your journey to wellness!',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.apply(color: Colors.white)),
                          ]),
                    )
                  ]),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed('/shakeScreen', arguments: {'initial?': false});
                },
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(290, 15, 0, 75),
                    child: SvgPicture.asset(
                      'assets/images/meditating.svg',
                      height: 95,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 100,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xffFFC122).withOpacity(0.60),
                    ),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.vertical,
                      children: [
                        Text('Daily Wellness Exercise',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                        Text('Keep your mind and body in shape!',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.apply(color: Colors.white)),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
