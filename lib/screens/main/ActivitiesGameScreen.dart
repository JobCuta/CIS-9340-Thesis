import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/AdventureProgress.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/adventureController.dart';
import 'package:flutter_application_1/controllers/copingController.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:flutter_application_1/controllers/sudokuController.dart';
import 'package:flutter_application_1/enums/Province.dart';
import 'package:flutter_application_1/screens/main/HomepageScreen.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum Activities {
    Coping,
    Memory,
    Sudoku
}

class ActivitiesGameScreen extends StatefulWidget {
  const ActivitiesGameScreen({key}) : super(key: key);

  @override
  State<ActivitiesGameScreen> createState() => _ActivitiesGameScreenState();
}

class _ActivitiesGameScreenState extends State<ActivitiesGameScreen> {
  final AdventureController _adventureController = Get.put(AdventureController());
  // final LevelController _levelController = Get.put(LevelController());
  // final SudokuController _sudokuController = Get.put(SudokuController());
  // final CopingController _copingController = Get.put(CopingController());

  // might have to change screen after completing memory or sudoku for the "complete" to reflect in the UI
  // TODO: will change something later to fix that
  RichText displayBasedOnTaskCompleteness(Activities activity) {
    Map<Province, int> provinceIndex = {
      Province.Apayao: 0,
      Province.Kalinga: 1,
      Province.Abra: 2,
      Province.MountainProvince: 3,
      Province.Ifugao: 4,
      Province.Benguet: 5
    };

    Province selectedProvince = _adventureController.selectedProvince.value;
    Box box = Hive.box<AdventureProgress>('adventure');
    AdventureProgress adventureProgress = box.get('adventureProgress');

    List <bool> provinceCompleted = (activity == Activities.Coping) ? adventureProgress.copingProvinceCompleted
        : (activity == Activities.Memory) ? adventureProgress.memoryProvinceCompleted
        : adventureProgress.sudokuProvinceCompleted;

    bool isTaskDone = provinceCompleted[provinceIndex[selectedProvince] as int];
    
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
    return WillPopScope(
      onWillPop: () {
        Get.offAndToNamed('/userJourney');
        return Future.value(true);
      },
      child: Scaffold(
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
                                // InkWell(
                                //   onTap: () {
                                //     _copingController
                                //         .getCompleteStatusOfProvinceCards(province);
                                //     setState(() {
                                //       _isCopingGameDone = true;
                                //     });
                                //     Get.offAndToNamed('/copingGame');
                                //   },
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Text('Coping',
                                //           style: Theme.of(context)
                                //               .textTheme
                                //               .bodyText2
                                //               ?.copyWith(
                                //               fontWeight: FontWeight.w400,
                                //               color: Theme.of(context)
                                //                   .colorScheme
                                //                   .neutralBlack02)),
                                //       displayBasedOnTaskCompleteness(
                                //           _isCopingGameDone)
                                //     ],
                                //   ),
                                // ),
                                _buildFieldComponent(
                                  title: Activities.Memory,
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
                                _buildFieldComponent(
                                  title: Activities.Coping,
                                  onTap: () {
                                    Get.offAndToNamed('/copingGame');
                                  }
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     // _copingController
                                //     //     .updateSelectedProvince(Province.Abra);
                                //     // setState(() {
                                //     //   _isCopingGameDone = true;
                                //     // });
                                //     Get.offAndToNamed('/copingGame');
                                //   },
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Text('Coping',
                                //           style: Theme.of(context)
                                //               .textTheme
                                //               .bodyText2
                                //               ?.copyWith(
                                //                   fontWeight: FontWeight.w400,
                                //                   color: Theme.of(context)
                                //                       .colorScheme
                                //                       .neutralBlack02)),
                                //       // displayBasedOnTaskCompleteness(
                                //       //     _isCopingGameDone)
                                //     ],
                                //   ),
                                // ),
                                // _buildFieldComponent(
                                //   title: 'Coping',
                                //   onTap: () {
                                //     Get.toNamed('/copingGame');
                                //   },
                                // ),
                                Divider(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralWhite03,
                                  height: 10,
                                  thickness: 1,
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     _sudokuController
                                //         .getCompleteStatusOfProvinceCards(province);
                                //     setState(() {
                                //       _isCopingGameDone = true;
                                //     });
                                //     Get.offAndToNamed('/copingGame');
                                //   },
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Text('Coping',
                                //           style: Theme.of(context)
                                //               .textTheme
                                //               .bodyText2
                                //               ?.copyWith(
                                //               fontWeight: FontWeight.w400,
                                //               color: Theme.of(context)
                                //                   .colorScheme
                                //                   .neutralBlack02)),
                                //       displayBasedOnTaskCompleteness(
                                //           _isCopingGameDone)
                                //     ],
                                //   ),
                                // ),
                                _buildFieldComponent(
                                  title: Activities.Sudoku,
                                  onTap: () {
                                    Get.toNamed('/sudoku', arguments: {
                                      'route': '/ActivitiesGameScreen'
                                    });
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
          )),
    );
  }
  _buildFieldComponent({required Activities title, onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.neutralBlack02)),

          displayBasedOnTaskCompleteness(title),
          // RichText(
          //   text: TextSpan(children: [
          //     TextSpan(
          //         text: 'Go',
          //         style: Theme.of(context).textTheme.bodyText1?.copyWith(
          //             fontWeight: FontWeight.w600,
          //             color: const Color(0xffFFC122))),
          //     const WidgetSpan(
          //         alignment: PlaceholderAlignment.middle,
          //         child: Icon(Icons.keyboard_arrow_right_sharp,
          //             color: Color(0xffFFC122)))
          //   ]),
          // ),
        ],
      ),
    );
  }
}