import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/copingController.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:flutter_application_1/controllers/sudokuController.dart';
import 'package:flutter_application_1/enums/Province.dart';
import 'package:flutter_application_1/screens/main/HomepageScreen.dart';
import 'package:get/get.dart';

class ActivitiesGameScreen extends StatefulWidget {
  const ActivitiesGameScreen({key}) : super(key: key);

  @override
  State<ActivitiesGameScreen> createState() => _ActivitiesGameScreenState();
}

class _ActivitiesGameScreenState extends State<ActivitiesGameScreen> {
  final LevelController _levelController = Get.put(LevelController());
  final SudokuController _sudokuController = Get.put(SudokuController());
  final CopingController _copingController = Get.put(CopingController());

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
                      color: const Color(0xffFFC122))),
              const WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.keyboard_arrow_right_sharp,
                      color: Color(0xffFFC122)))
            ]),
          );
  }

  @override
  Widget build(BuildContext context) {
    //bool _isMemoryGameDone = _memoryController.isDailyExerciseDone.value;
    bool _isCopingGameDone = _copingController.provinceCompleted.value as bool;
    //bool _isSudokuGameDone = _sudokuController.value;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Your Adventure',
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: Theme.of(context).colorScheme.neutralWhite01,
                fontWeight: FontWeight.w400),
          ),
          leading: BackButton(onPressed: () => {Get.toNamed('/userJourney')}),
          primary: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/background_images/adventure_background.png',
                        ),
                        fit: BoxFit.cover))),
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 15),
                          child: Wrap(
                            runSpacing: 10,
                            children: [
                              Text('Your Activities',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                              Text('Start your Journey to Wellness!',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                              Divider(
                                color: Theme.of(context)
                                    .colorScheme
                                    .neutralWhite03,
                                height: 10,
                                thickness: 1,
                              ),
                              /**InkWell(
                                onTap: () {
                                  _copingController
                                      .getCompleteStatusOfProvinceCards(province);
                                  setState(() {
                                    _isCopingGameDone = true;
                                  });
                                  Get.offAndToNamed('/copingGame');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Coping',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .neutralBlack02)),
                                    displayBasedOnTaskCompleteness(
                                        _isCopingGameDone)
                                  ],
                                ),
                              ),*/
                              _buildFieldComponent(
                                title: 'Memory',
                                onTap: () {
                                  Get.toNamed('/memoryGameScreen');
                                },
                              ),
                              Divider(
                                color: Theme.of(context)
                                    .colorScheme
                                    .neutralWhite03,
                                height: 10,
                                thickness: 1,
                              ),
                              InkWell(
                                onTap: () {
                                  _copingController
                                      .updateSelectedProvince(Province.Abra);
                                  setState(() {
                                    _isCopingGameDone = true;
                                  });
                                  Get.offAndToNamed('/copingGame');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Coping',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .neutralBlack02)),
                                    displayBasedOnTaskCompleteness(
                                        _isCopingGameDone)
                                  ],
                                ),
                              ),
                              /**_buildFieldComponent(
                                title: 'Coping',
                                onTap: () {
                                  Get.toNamed('/copingGame');
                                },
                              ),*/
                              Divider(
                                color: Theme.of(context)
                                    .colorScheme
                                    .neutralWhite03,
                                height: 10,
                                thickness: 1,
                              ),
                              /**InkWell(
                                onTap: () {
                                  _sudokuController
                                      .getCompleteStatusOfProvinceCards(province);
                                  setState(() {
                                    _isCopingGameDone = true;
                                  });
                                  Get.offAndToNamed('/copingGame');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Coping',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .neutralBlack02)),
                                    displayBasedOnTaskCompleteness(
                                        _isCopingGameDone)
                                  ],
                                ),
                              ),*/
                              _buildFieldComponent(
                                title: 'Sudoku',
                                onTap: () {
                                  Get.toNamed('/sudoku');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  _buildFieldComponent({title, onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.neutralBlack02)),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: 'Go',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffFFC122))),
              const WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.keyboard_arrow_right_sharp,
                      color: Color(0xffFFC122)))
            ]),
          ),
        ],
      ),
    );
  }
}
