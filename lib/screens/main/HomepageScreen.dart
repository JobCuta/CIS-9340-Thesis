import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/dailyHive.dart';
import 'package:flutter_application_1/controllers/dailyController.dart';
import 'package:flutter_application_1/controllers/emotionController.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:flutter_application_1/enums/DailyTask.dart';
import 'package:flutter_application_1/screens/MiniGames/Sudoku/SudokuScreen.dart';
import 'package:flutter_application_1/screens/main/AdventureHomeScreen.dart';
import 'package:flutter_application_1/screens/main/CalendarScreen.dart';
import 'package:flutter_application_1/screens/main/EntriesScreen.dart';
import 'package:flutter_application_1/widgets/LevelExperienceModal.dart';
import 'package:flutter_application_1/widgets/LevelTasksTodayModal.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/widgets/TalkingPersonDialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
    const AdventureHomeScreen(),
    // Temporary
    SudokuScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return
        // WillPopScope(
        // onWillPop: () async => false, //change to confirm exit modal
        // child:
        Scaffold(
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
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        backgroundColor: _selectedIndex < 3
            ? Theme.of(context).colorScheme.accentBlue02
            : Theme.of(context).colorScheme.sunflowerYellow01,
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
        selectedItemColor: Theme.of(context).colorScheme.neutralWhite01,
        unselectedItemColor: _selectedIndex < 3
            ? Theme.of(context).colorScheme.accentBlue04
            : const Color(0xffA36508),
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
      ),
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
  final LevelController _levelController = Get.put(LevelController());

  RichText displayBasedOnTaskCompleteness(bool isTaskDone) {
    return (isTaskDone)
        ? RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: 'Completed ',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.neutralGray02)),
              WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.check_circle,
                      color: Theme.of(context).colorScheme.accentGreen02))
            ]),
          )
        : RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: 'Go',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.accentBlue04)),
              WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.keyboard_arrow_right_sharp,
                      color: Theme.of(context).colorScheme.accentBlue04))
            ]),
          );
  }

  @override
  void initState() {
    print("ENTERED INIT OF HOMEPAGE --------------------");
    print("Level Controller (Recently added xp) = " +
        _levelController.recentlyAddedXp.value.toString());
    print("Daily Controller (Showed available tasks) = " +
        _dailyController.showedAvailableTasks.value.toString());

    if (_levelController.recentlyAddedXp.value) {
      Future.delayed(const Duration(seconds: 0)).then((_) {
        showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4), topRight: Radius.circular(4)),
            ),
            useRootNavigator: true,
            isScrollControlled: true,
            builder: (context) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: const LevelWidgets());
            });

        _levelController.updateRecentlyAddedXp(false);
      });
    } else if (!_dailyController.showedAvailableTasks.value &&
        (!_dailyController.isDailyEntryDone.value ||
            !_dailyController.isDailyExerciseDone.value)) {
      Future.delayed(const Duration(seconds: 0)).then((_) {
        showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4), topRight: Radius.circular(4)),
            ),
            useRootNavigator: true,
            isScrollControlled: true,
            builder: (context) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: const LevelTasksTodayWidgets());
            });

        _dailyController.updateShowedAvailableTasks(true);
      });
    }

    super.initState();
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
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
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralWhite01)),
                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 12.0),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .accentBlue04
                                  .withOpacity(0.20),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Text(
                              'Remember, all is well and all will be well.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralWhite01)),
                        )
                      ])),
                ),
                ElevatedButton(
                    child: const Text('Test transparent'),
                    onPressed: () {
                      // Sample of how to use the talking person alert dialog
                      // use then after the function to run code (redirect user, show another dialog like this, etc)
                      showTalkingPerson(
                        context: context,
                        dialog:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      ).then((value) {
                        Get.toNamed('/introScreen');
                      });
                    }),
                ElevatedButton(
                    child: const Text('Test LevelUp'),
                    onPressed: () {
                      _levelController.getLevelFromStorage();
                      _levelController.addXp(150);

                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4)),
                          ),
                          useRootNavigator: true,
                          // isScrollControlled: true,
                          builder: (context) {
                            return SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: const LevelWidgets());
                          });
                    }),
                ElevatedButton(
                    child: const Text("Test Today's Task"),
                    onPressed: () {
                      _levelController.getLevelFromStorage();
                      _levelController.addXp(150);

                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4)),
                          ),
                          useRootNavigator: true,
                          // isScrollControlled: true,
                          builder: (context) {
                            return SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: const LevelTasksTodayWidgets());
                          });
                    }),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 15.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // MORNING
                            CircleAvatar(
                              radius: 28.0,
                              backgroundColor: (_isMorningEntryDone
                                  ? const Color(0x00FFC122).withOpacity(1.0)
                                  : const Color(0xFFACB2B4).withOpacity(1.0)),
                              child: CircleAvatar(
                                  radius: 24.0,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .neutralWhite01,
                                  child: Image(
                                    image: const AssetImage(
                                        'assets/images/entry_morning.png'),
                                    color: !_isMorningEntryDone
                                        ? Colors.grey
                                        : null,
                                  )),
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 25.0),
                                width: 80,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: (_isMorningEntryDone &&
                                            _isAfternoonEntryDone)
                                        ? const Color(0x00FFC122)
                                            .withOpacity(1.0)
                                        : Theme.of(context)
                                            .colorScheme
                                            .neutralGray02)),

                            // AFTERNOON
                            CircleAvatar(
                              radius: 28.0,
                              backgroundColor: (_isAfternoonEntryDone
                                  ? const Color(0x00FFC122).withOpacity(1.0)
                                  : const Color(0xFFACB2B4).withOpacity(1.0)),
                              child: CircleAvatar(
                                  radius: 24.0,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .neutralWhite01,
                                  child: Image(
                                    image: const AssetImage(
                                        'assets/images/entry_afternoon.png'),
                                    color: !_isAfternoonEntryDone
                                        ? Colors.grey
                                        : null,
                                  )),
                            ),
                            Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 25.0),
                                width: 80,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: (_isAfternoonEntryDone &&
                                            _isEveningEntryDone)
                                        ? const Color(0x00FFC122)
                                            .withOpacity(1.0)
                                        : Theme.of(context)
                                            .colorScheme
                                            .neutralGray02)),

                            // EVENING
                            CircleAvatar(
                              radius: 28.0,
                              backgroundColor: (_isEveningEntryDone
                                  ? const Color(0x00FFC122).withOpacity(1.0)
                                  : const Color(0xFFACB2B4).withOpacity(1.0)),
                              child: CircleAvatar(
                                  radius: 24.0,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .neutralWhite01,
                                  child: Image(
                                    image: const AssetImage(
                                        'assets/images/entry_evening.png'),
                                    color: !_isEveningEntryDone
                                        ? Colors.grey
                                        : null,
                                  )),
                            ),
                          ],
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 15.0),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.neutralWhite01,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your dailies for today',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .accentBlue02)),
                        const SizedBox(height: 10.0),
                        Text('Start your journey to wellness!',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralBlack02)),
                        Divider(
                          color: Theme.of(context).colorScheme.neutralWhite03,
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .neutralBlack02)),
                              displayBasedOnTaskCompleteness(
                                  _isDailyExerciseDone)
                            ],
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.neutralWhite03,
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
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .neutralBlack02)),
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
                        padding: const EdgeInsets.only(left: 100),
                        child: SvgPicture.asset(
                          'assets/images/bahag.svg',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // would prefer to redirect to _selectedIndex = 3 instead
                          Get.toNamed('/adventureHome');
                        },
                        child: Container(
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
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .neutralWhite01)),
                                const SizedBox(height: 10.0),
                                Text('Start your journey to wellness!',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .neutralWhite01)),
                              ]),
                        ),
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
                      padding: const EdgeInsets.fromLTRB(290, 15, 0, 10),
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
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralWhite01)),
                          Text('Keep your mind and body in shape!',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralWhite01)),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
