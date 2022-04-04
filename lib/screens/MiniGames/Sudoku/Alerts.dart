import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

import 'Styles.dart';

class AlertGameOver extends StatelessWidget {
  static bool newGame = false;
  static bool restartGame = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      title: Text(
        'Game Over',
        style: TextStyle(color: Styles.foregroundColor),
      ),
      content: Text(
        'You successfully solved the Sudoku',
        style: TextStyle(color: Styles.foregroundColor),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(Styles.foregroundColor)),
          onPressed: () {
            Get.back();
            restartGame = true;
          },
          child: const Text('Restart Game'),
        ),
        TextButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                  Styles.primaryBackgroundColor)),
          onPressed: () {
            Get.back();
            newGame = true;
          },
          child: const Text('New Game'),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class AlertDifficultyState extends StatefulWidget {
  late String currentDifficultyLevel;

  AlertDifficultyState(this.currentDifficultyLevel, {Key? key})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  AlertDifficulty createState() => AlertDifficulty(currentDifficultyLevel);

  static String get difficulty {
    return AlertDifficulty.difficulty;
  }

  static set difficulty(String level) {
    AlertDifficulty.difficulty = level;
  }
}

class AlertDifficulty extends State<AlertDifficultyState> {
  static String difficulty = '';
  static final List<String> difficulties = [
    'beginner',
    'easy',
    'medium',
    'hard'
  ];
  late String currentDifficultyLevel;

  AlertDifficulty(this.currentDifficultyLevel);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
          child: Text(
        'Select Difficulty Level',
        style: TextStyle(color: Styles.foregroundColor),
      )),
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      children: <Widget>[
        for (String level in difficulties)
          SimpleDialogOption(
            onPressed: () {
              if (level != this.currentDifficultyLevel) {
                setState(() {
                  difficulty = level;
                });
              }
              Get.back();
            },
            child: Text(level[0].toUpperCase() + level.substring(1),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color: level == this.currentDifficultyLevel
                        ? Styles.secondaryBackgroundColor
                        : Styles.foregroundColor)),
          ),
      ],
    );
  }
}

class AlertExit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      title: Text(
        'Exit Game',
        style: TextStyle(color: Styles.foregroundColor),
      ),
      content: Text(
        'Are you sure you want to exit the game ?',
        style: TextStyle(color: Styles.foregroundColor),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(Styles.primaryColor)),
          onPressed: () {
            Get.back();
          },
          child: const Text('No'),
        ),
        TextButton(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(Styles.primaryColor)),
          onPressed: () {
            Get.back();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}

class AlertNumbersState extends StatefulWidget {
  @override
  AlertNumbers createState() => AlertNumbers();

  static int get number {
    return AlertNumbers.number;
  }

  static set number(int number) {
    AlertNumbers.number = number;
  }
}

class AlertNumbers extends State<AlertNumbersState> {
  static int number = 0;
  late int numberSelected;
  static final List<int> numberList1 = [1, 2, 3];
  static final List<int> numberList2 = [4, 5, 6];
  static final List<int> numberList3 = [7, 8, 9];

  List<SizedBox> createButtons(List<int> numberList) {
    return <SizedBox>[
      for (int numbers in numberList)
        SizedBox(
          width: 38,
          height: 38,
          child: TextButton(
            onPressed: () => {
              setState(() {
                numberSelected = numbers;
                number = numberSelected;
                Get.back();
              })
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              foregroundColor:
                  MaterialStateProperty.all<Color>(Styles.primaryColor),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
              side: MaterialStateProperty.all<BorderSide>(BorderSide(
                color: Styles.foregroundColor,
                width: 1,
                style: BorderStyle.solid,
              )),
            ),
            child: Text(
              numbers.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Styles.foregroundColor),
            ),
          ),
        )
    ];
  }

  Row oneRow(List<int> numberList) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: createButtons(numberList),
    );
  }

  List<Row> createRows() {
    List<List> numberLists = [numberList1, numberList2, numberList3];
    List<Row> rowList = List<Row>.filled(3, Row());
    for (var i = 0; i <= 2; i++) {
      rowList[i] = oneRow(numberLists[i] as List<int>);
    }
    return rowList;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
          'Choose a Number',
          style: TextStyle(color: Styles.foregroundColor),
        )),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: createRows(),
        ));
  }
}

class AlertThemeColor extends StatefulWidget {
  late String currentThemeColor;

  AlertThemeColor(String currentThemeColor) {
    this.currentThemeColor = currentThemeColor;
  }

  static String get themeColor {
    return _AlertThemeColorState.themeColor;
  }

  static set themeColor(String color) {
    _AlertThemeColorState.themeColor = color;
  }

  @override
  State<AlertThemeColor> createState() =>
      _AlertThemeColorState(this.currentThemeColor);
}

class _AlertThemeColorState extends State<AlertThemeColor> {
  static String themeColor = '';
  static final List<String> theme = [...Styles.themeColors.keys];
  static final List<MaterialColor> colors = [...Styles.themeColors.values];
  late String color;

  _AlertThemeColorState(String themeColor) {
    this.color = themeColor;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
          child: Text(
        'Select Color',
        style: TextStyle(color: Styles.foregroundColor),
      )),
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      children: <Widget>[
        for (String color in theme)
          SimpleDialogOption(
            onPressed: () {
              if (color != this.color) {
                setState(() {
                  themeColor = color;
                });
              }
              Get.back();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    backgroundColor: Styles.themeColors[color],
                    maxRadius: 10,
                  ),
                ),
                Text(color,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        color: color == this.color
                            ? Styles.themeColors[color]
                            : Styles.foregroundColor)),
              ],
            ),
          ),
      ],
    );
  }
}

// ignore: must_be_immutable
class AlertAccentColorsState extends StatefulWidget {
  late String currentAccentColor;

  AlertAccentColorsState(String currentAccentColor) {
    this.currentAccentColor = currentAccentColor;
  }

  static String get accentColor {
    return AlertAccentColors.accentColor;
  }

  static set accentColor(String color) {
    AlertAccentColors.accentColor = color;
  }

  @override
  AlertAccentColors createState() => AlertAccentColors(this.currentAccentColor);
}

class AlertAccentColors extends State<AlertAccentColorsState> {
  static String accentColor = '';
  static final List<String> accentColors = [...Styles.accentColors.keys];
  late String currentAccentColor;

  AlertAccentColors(String currentAccentColor) {
    this.currentAccentColor = currentAccentColor;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
          child: Text(
        'Select Color',
        style: TextStyle(color: Styles.foregroundColor),
      )),
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      children: <Widget>[
        for (String color in accentColors)
          SimpleDialogOption(
            onPressed: () {
              if (color != this.currentAccentColor) {
                setState(() {
                  accentColor = color;
                });
              }
              Get.back();
            },
            child: Text(color,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color: color == this.currentAccentColor
                        ? Styles.primaryColor
                        : Styles.foregroundColor)),
          ),
      ],
    );
  }
}

class AlertAbout extends StatelessWidget {
  static const String authorURL = "https://www.github.com/VarunS2002/";
  static const String releasesURL =
      "https://github.com/VarunS2002/Flutter-Sudoku/releases/";
  static const String sourceURL =
      "https://github.com/VarunS2002/Flutter-Sudoku/";
  static const String licenseURL =
      "https://github.com/VarunS2002/Flutter-Sudoku/blob/master/LICENSE";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      title: Center(
        child: Text(
          'About',
          style: TextStyle(color: Styles.foregroundColor),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sudoku Source Code',
                style: TextStyle(
                    color: Styles.foregroundColor,
                    fontFamily: 'roboto',
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '                ',
                style: TextStyle(
                    color: Styles.foregroundColor,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '                ',
                style: TextStyle(
                    color: Styles.foregroundColor,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Author: ',
                style: TextStyle(
                    color: Styles.foregroundColor,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
              InkWell(
                onTap: () async {
                  await launch(AlertAbout.authorURL);
                },
                child: Text(
                  'VarunS2002',
                  style: TextStyle(
                      color: Styles.primaryBackgroundColor,
                      fontFamily: 'roboto',
                      fontSize: 15),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '                ',
                style: TextStyle(
                    color: Styles.foregroundColor,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'License: ',
                style: TextStyle(
                    color: Styles.foregroundColor,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
              InkWell(
                onTap: () async {
                  await launch(AlertAbout.licenseURL);
                },
                child: Text(
                  'GNU GPLv3',
                  style: TextStyle(
                      color: Styles.primaryBackgroundColor,
                      fontFamily: 'roboto',
                      fontSize: 15),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '                ',
                style: TextStyle(
                    color: Styles.foregroundColor,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  await launch(AlertAbout.sourceURL);
                },
                child: Text(
                  'Source Code',
                  style: TextStyle(
                      color: Styles.primaryBackgroundColor,
                      fontFamily: 'roboto',
                      fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
