// Source Code taken from Github, modified to suit the needs of our project.
// Author: VarunS2002
// Title: Flutter-Sudoku
// Code Version: e0449ec
// Type: Source Code
// URL: https://github.com/VarunS2002/Flutter-Sudoku
// GitHub - VarunS2002/Flutter-Sudoku: This is a fully fledged Sudoku game written in Dart using Flutter. (2022). Retrieved 2 April 2022, from https://github.com/VarunS2002/Flutter-Sudoku

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/sudokuController.dart';
import 'package:flutter_application_1/widgets/talkingPersonDialog.dart';
import 'package:get/get.dart';

import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';
import 'Styles.dart';
import 'Alerts.dart';

class SudokuScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SudokuScreenState();
}

class SudokuScreenState extends State<SudokuScreen> {
  bool firstRun = true;
  bool gameOver = false;
  int timesCalled = 0;
  bool isButtonDisabled = false;
  late List<List<List<int>>> gameList;
  late List<List<int>> game;
  late List<List<int>> gameCopy;
  late List<List<int>> gameSolved;
  static String currentDifficultyLevel = '';
  static String currentTheme = '';
  static String currentAccentColor = '';
  final SudokuController _sudokuController = Get.put(SudokuController());

  @override
  void initState() {
    super.initState();

    getPrefs().whenComplete(() {
      if (currentDifficultyLevel == '') {
        currentDifficultyLevel = 'easy';
        setPrefs('currentDifficultyLevel');
      }
      if (currentTheme == '') {
        currentTheme = 'Green';
        setPrefs('currentTheme');
      }
      if (currentAccentColor == '') {
        currentAccentColor = 'darkGrey';
        setPrefs('currentAccentColor');
      }
      print(currentTheme);
      newGame(currentDifficultyLevel);
      changeTheme(currentTheme);
      changeAccentColor(currentAccentColor, true);
    });
  }

  Future<void> getPrefs() async {
    _sudokuController.getSettings();
    setState(() {
      currentDifficultyLevel = _sudokuController.currentDifficultyLevel.value;
      currentTheme = _sudokuController.currentTheme.value;
      currentAccentColor = _sudokuController.currentAccentColor.value;
    });
    print(currentTheme);
  }

  setPrefs(String property) async {
    if (property == 'currentDifficultyLevel') {
      _sudokuController.updateDifficulty(currentDifficultyLevel);
    } else if (property == 'currentTheme') {
      print(currentTheme);
      _sudokuController.updateTheme(currentTheme);
    } else if (property == 'currentAccentColor') {
      _sudokuController.updateAccent(currentAccentColor);
    }
  }

  void changeTheme(String theme) {
    if (theme == 'Green') {
      setState(() {
        Styles.primaryBackgroundColor = Styles.darkGreen;
        Styles.secondaryBackgroundColor = Styles.green;
        Styles.foregroundColor = Styles.darkGrey;
      });
    } else if (theme == 'Purple') {
      setState(() {
        Styles.primaryBackgroundColor = Styles.darkPurple;
        Styles.secondaryBackgroundColor = Styles.purple;
        Styles.foregroundColor = Styles.darkGrey;
      });
    } else if (theme == 'Yellow') {
      setState(() {
        Styles.primaryBackgroundColor = Styles.darkYellow;
        Styles.secondaryBackgroundColor = Styles.yellow;
        Styles.foregroundColor = Styles.darkGrey;
      });
    } else if (theme == 'Blue') {
      setState(() {
        Styles.primaryBackgroundColor = Styles.darkBlue;
        Styles.secondaryBackgroundColor = Styles.blue;
        Styles.foregroundColor = Styles.darkGrey;
      });
    }
    setPrefs('currentTheme');
  }

  void changeAccentColor(String color, [bool firstRun = false]) {
    setState(() {
      if (Styles.accentColors.keys.contains(color)) {
        Styles.primaryColor = Styles.accentColors[color]!;
      } else {
        currentAccentColor = 'Blue';
        Styles.primaryColor = Styles.accentColors[color]!;
      }
      if (color == 'Red') {
        Styles.secondaryColor = Styles.orange;
      } else {
        Styles.secondaryColor = Styles.darkGrey;
      }
      if (!firstRun) {
        setPrefs('currentAccentColor');
      }
    });
  }

  void checkResult() {
    try {
      if (SudokuUtilities.isSolved(game)) {
        isButtonDisabled = !isButtonDisabled;
        gameOver = true;
        Timer(const Duration(milliseconds: 500), () {
          // add if statement with get argument to determine where the user navigated from (adventure tasks or mini games screen)
          showTalkingPerson(
            context: context,
            dialog:
                'Congratulations! You beat the Sudoku Portion of the level! I’ll bring you back to the list of tasks.',
          );
          // showAnimatedDialog<void>(
          //     animationType: DialogTransitionType.fadeScale,
          //     barrierDismissible: true,
          //     duration: const Duration(milliseconds: 350),
          //     context: context,
          //     builder: (_) => AlertGameOver()).whenComplete(() {
          //   if (AlertGameOver.newGame) {
          //     newGame();
          //     AlertGameOver.newGame = false;
          //   } else if (AlertGameOver.restartGame) {
          //     restartGame();
          //     AlertGameOver.restartGame = false;
          //   }
          // });
          // }
        });
      }
    } on InvalidSudokuConfigurationException {
      return;
    }
  }

  static List<List<List<int>>> getNewGame([String difficulty = 'easy']) {
    int emptySquares = 0;
    switch (difficulty) {
      case 'test':
        {
          emptySquares = 2;
        }
        break;
      case 'beginner':
        {
          emptySquares = 18;
        }
        break;
      case 'easy':
        {
          emptySquares = 27;
        }
        break;
      case 'medium':
        {
          emptySquares = 36;
        }
        break;
      case 'hard':
        {
          emptySquares = 54;
        }
        break;
    }
    SudokuGenerator generator = SudokuGenerator(emptySquares: emptySquares);
    return [generator.newSudoku, generator.newSudokuSolved];
  }

  void setGame(int mode, [String difficulty = 'easy']) {
    if (mode == 1) {
      game = List.generate(9, (i) => [0, 0, 0, 0, 0, 0, 0, 0, 0]);
      gameCopy = SudokuUtilities.copySudoku(game);
      gameSolved = SudokuUtilities.copySudoku(game);
    } else {
      gameList = getNewGame(difficulty);
      game = gameList[0];
      gameCopy = SudokuUtilities.copySudoku(game);
      gameSolved = gameList[1];
    }
  }

  void showSolution() {
    setState(() {
      game = SudokuUtilities.copySudoku(gameSolved);
      isButtonDisabled =
          !isButtonDisabled ? !isButtonDisabled : isButtonDisabled;
      gameOver = true;
    });
  }

  void newGame([String difficulty = 'easy']) {
    setState(() {
      setGame(2, difficulty);
      isButtonDisabled =
          isButtonDisabled ? !isButtonDisabled : isButtonDisabled;
      gameOver = false;
    });
  }

  void restartGame() {
    setState(() {
      game = SudokuUtilities.copySudoku(gameCopy);
      isButtonDisabled =
          isButtonDisabled ? !isButtonDisabled : isButtonDisabled;
      gameOver = false;
    });
  }

  Color buttonColor(int k, int i) {
    Color color;
    if (([0, 1, 2].contains(k) && [3, 4, 5].contains(i)) ||
        ([3, 4, 5].contains(k) && [0, 1, 2, 6, 7, 8].contains(i)) ||
        ([6, 7, 8].contains(k) && [3, 4, 5].contains(i))) {
      if (Styles.primaryBackgroundColor == Styles.darkGreen) {
        color = Styles.green;
      } else if (Styles.primaryBackgroundColor == Styles.darkBlue) {
        color = Styles.blue;
      } else if (Styles.primaryBackgroundColor == Styles.darkYellow) {
        color = Styles.yellow;
      } else if (Styles.primaryBackgroundColor == Styles.darkPurple) {
        color = Styles.purple;
      } else {
        color = Styles.primaryBackgroundColor;
      }
    } else {
      color = Styles.primaryBackgroundColor;
    }

    return color;
  }

  BorderRadiusGeometry buttonEdgeRadius(int k, int i) {
    if (k == 0 && i == 0) {
      return const BorderRadius.only(topLeft: Radius.circular(5));
    } else if (k == 0 && i == 8) {
      return const BorderRadius.only(topRight: Radius.circular(5));
    } else if (k == 8 && i == 0) {
      return const BorderRadius.only(bottomLeft: Radius.circular(5));
    } else if (k == 8 && i == 8) {
      return const BorderRadius.only(bottomRight: Radius.circular(5));
    }
    return BorderRadius.circular(0);
  }

  List<SizedBox> createButtons() {
    if (firstRun) {
      setGame(1);
      firstRun = false;
    }
    MaterialColor emptyColor;
    if (gameOver) {
      emptyColor = Styles.primaryColor;
    } else {
      emptyColor = Styles.secondaryColor;
    }
    List<SizedBox> buttonList = List<SizedBox>.filled(9, const SizedBox());
    for (var i = 0; i <= 8; i++) {
      var k = timesCalled;
      buttonList[i] = SizedBox(
        width: 38,
        height: 38,
        child: TextButton(
          onPressed: isButtonDisabled || gameCopy[k][i] != 0
              ? null
              : () {
                  showAnimatedDialog<void>(
                      animationType: DialogTransitionType.fade,
                      barrierDismissible: true,
                      duration: const Duration(milliseconds: 300),
                      context: context,
                      builder: (_) => AlertNumbersState()).whenComplete(() {
                    if (AlertNumbersState.number != null) {
                      callback([k, i], AlertNumbersState.number);
                      AlertNumbersState.number = 0;
                    }
                  });
                },
          onLongPress: isButtonDisabled || gameCopy[k][i] != 0
              ? null
              : () => callback([k, i], 0),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(buttonColor(k, i)),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return gameCopy[k][i] == 0 ? emptyColor : Styles.white;
              }
              return game[k][i] == 0
                  ? buttonColor(k, i)
                  : Styles.secondaryColor;
            }),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
              borderRadius: buttonEdgeRadius(k, i),
            )),
            side: MaterialStateProperty.all<BorderSide>(BorderSide(
              color: Styles.foregroundColor,
              width: 1,
              style: BorderStyle.solid,
            )),
          ),
          child: Text(
            game[k][i] != 0 ? game[k][i].toString() : ' ',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ),
      );
    }
    timesCalled++;
    if (timesCalled == 9) {
      timesCalled = 0;
    }
    return buttonList;
  }

  Row oneRow() {
    return Row(
      children: createButtons(),
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  List<Row> createRows() {
    List<Row> rowList = List<Row>.filled(9, Row());
    for (var i = 0; i <= 8; i++) {
      rowList[i] = oneRow();
    }
    return rowList;
  }

  void callback(List<int> index, int number) {
    setState(() {
      if (number == null) {
        return;
      } else if (number == 0) {
        game[index[0]][index[1]] = number;
      } else {
        game[index[0]][index[1]] = number;
        checkResult();
      }
    });
  }

  showOptionModalSheet(BuildContext context) {
    BuildContext outerContext = context;
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        builder: (context) {
          return Wrap(
            children: [
              ListTile(
                title: Text('Settings',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Styles.primaryBackgroundColor)),
              ),
              ListTile(
                leading:
                    Icon(Icons.refresh, color: Styles.primaryBackgroundColor),
                title: Text('Restart Game',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontWeight: FontWeight.w400)),
                onTap: () {
                  Get.back();
                  Timer(const Duration(milliseconds: 200), () => restartGame());
                },
              ),
              ListTile(
                leading: Icon(Icons.add_rounded,
                    color: Styles.primaryBackgroundColor),
                title: Text('New Game',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontWeight: FontWeight.w400)),
                onTap: () {
                  Get.back();
                  Timer(const Duration(milliseconds: 200),
                      () => newGame(currentDifficultyLevel));
                },
              ),
              ListTile(
                leading: Icon(Icons.lightbulb_outline_rounded,
                    color: Styles.primaryBackgroundColor),
                title: Text('Show Solution',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontWeight: FontWeight.w400)),
                onTap: () {
                  Get.back();
                  Timer(
                      const Duration(milliseconds: 200), () => showSolution());
                },
              ),
              ListTile(
                leading: Icon(Icons.build_outlined,
                    color: Styles.primaryBackgroundColor),
                title: Text('Set Difficulty',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontWeight: FontWeight.w400)),
                onTap: () {
                  Navigator.pop(context);
                  Timer(
                      const Duration(milliseconds: 300),
                      () => showAnimatedDialog<void>(
                              animationType: DialogTransitionType.fadeScale,
                              barrierDismissible: true,
                              duration: const Duration(milliseconds: 350),
                              context: outerContext,
                              builder: (_) => AlertDifficultyState(
                                  currentDifficultyLevel)).whenComplete(() {
                            if (AlertDifficultyState.difficulty != null) {
                              Timer(const Duration(milliseconds: 300), () {
                                newGame(AlertDifficultyState.difficulty);
                                currentDifficultyLevel =
                                    AlertDifficultyState.difficulty;
                                AlertDifficultyState.difficulty = '';
                                setPrefs('currentDifficultyLevel');
                              });
                            }
                          }));
                },
              ),
              ListTile(
                leading: Icon(Icons.color_lens_outlined,
                    color: Styles.primaryBackgroundColor),
                title: Text('Change Theme Color',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontWeight: FontWeight.w400)),
                onTap: () {
                  Get.back();
                  Timer(
                      const Duration(milliseconds: 200),
                      () => showAnimatedDialog<void>(
                                  animationType: DialogTransitionType.fadeScale,
                                  barrierDismissible: true,
                                  duration: const Duration(milliseconds: 350),
                                  context: outerContext,
                                  builder: (_) => AlertThemeColor(currentTheme))
                              .whenComplete(() {
                            if (AlertThemeColor.themeColor != '') {
                              Timer(const Duration(milliseconds: 300), () {
                                changeTheme(AlertThemeColor.themeColor);
                                currentTheme = AlertThemeColor.themeColor;
                                AlertThemeColor.themeColor = '';
                                setPrefs('currentTheme');
                              });
                            }
                          }));
                },
              ),
              ListTile(
                leading: Icon(Icons.info_outline_rounded,
                    color: Styles.primaryBackgroundColor),
                title: Text('About',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontWeight: FontWeight.w400)),
                onTap: () {
                  Get.back();
                  Timer(
                      const Duration(milliseconds: 200),
                      () => showAnimatedDialog<void>(
                          animationType: DialogTransitionType.fadeScale,
                          barrierDismissible: true,
                          duration: const Duration(milliseconds: 350),
                          context: outerContext,
                          builder: (_) => AlertAbout()));
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          showAnimatedDialog<void>(
              animationType: DialogTransitionType.fadeScale,
              barrierDismissible: true,
              duration: const Duration(milliseconds: 350),
              context: context,
              builder: (_) => AlertExit());

          return true;
        },
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(56.0),
                child: AppBar(
                    title: Text('Sudoku',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            fontWeight: FontWeight.w400,
                            color:
                                Theme.of(context).colorScheme.neutralWhite01)),
                    backgroundColor: Colors.transparent,
                    elevation: 0)),
            extendBodyBehindAppBar: true,
            body: Stack(children: [
              Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/background_images/adventure_background.png',
                          ),
                          fit: BoxFit.cover))),
              Builder(builder: (builder) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: createRows(),
                  ),
                );
              }),
            ]),
            floatingActionButton: FloatingActionButton(
              foregroundColor: Colors.black,
              backgroundColor: Styles.primaryBackgroundColor,
              onPressed: () => showOptionModalSheet(context),
              child: const Icon(Icons.menu_rounded),
            )));
  }
}
