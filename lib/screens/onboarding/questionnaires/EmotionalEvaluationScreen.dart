import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

void main() {
  runApp(MaterialApp(home: EmotionalEvaluationScreen(initialAssessment: true)));
}

class EmotionalEvaluationScreen extends StatefulWidget {
  bool initialAssessment = true;

  EmotionalEvaluationScreen({key, required this.initialAssessment})
      : super(key: key);

  @override
  _EmotionalEvaluationScreenState createState() =>
      _EmotionalEvaluationScreenState();
}

class _EmotionalEvaluationScreenState extends State<EmotionalEvaluationScreen> {
  // int position = 10;
  bool isVeryHappy = true;
  bool isHappy = true;
  bool isNeutral = true;
  bool isBad = true;
  bool isVeryBad = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/blue_background.png',
                    ),
                    fit: BoxFit.cover))),
        // Keeps the StepProgressIndicator in the same spot
        // Visibility(
        //   visible: widget.initialAssessment,
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(vertical: 75, horizontal: 25),
        //     child: Align(
        //       alignment: Alignment.topCenter,
        //       child: StepProgressIndicator(
        //         totalSteps: 11,
        //         currentStep: position,
        //         selectedColor: Colors.white,
        //         unselectedColor: const Color(0xff004479),
        //       ),
        //     ),
        //   ),
        // ),

        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
            child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 50,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 18.0),
                    decoration: BoxDecoration(
                        color: const Color(0xff3290FF).withOpacity(0.60),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: const Align(
                      alignment: Alignment.topCenter,
                      child: Text('How do you feel in this moment?',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      // ),
                    ),
                  ),
                  // Text(,
                  //     style: TextStyle(fontSize: 16)),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Center(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.vertical,
                        spacing: 5,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                (widget.initialAssessment)
                                    ? setState(() {
                                        isVeryHappy = true;
                                        isHappy = false;
                                        isNeutral = false;
                                        isBad = false;
                                        isVeryBad = false;
                                      })
                                    : toEmotionalEvaluationPositiveNegative(
                                        context, widget.initialAssessment);
                              }, // Image tapped
                              splashColor:
                                  Colors.white12, // Splash color over image
                              child: Ink.image(
                                image: (isVeryHappy)
                                    ? const AssetImage(
                                        'assets/images/face_very_happy_selected.png',
                                      )
                                    : const AssetImage(
                                        'assets/images/face_very_happy.png'),
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ),
                          const Text('Very Happy',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white))
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Center(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.vertical,
                        spacing: 5,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                (widget.initialAssessment)
                                    ? setState(() {
                                        isVeryHappy = false;
                                        isHappy = true;
                                        isNeutral = false;
                                        isBad = false;
                                        isVeryBad = false;
                                      })
                                    : toEmotionalEvaluationPositiveNegative(
                                        context, widget.initialAssessment);
                                print('happy');
                              }, // Image tapped
                              splashColor:
                                  Colors.white12, // Splash color over image
                              child: Ink.image(
                                image: (isHappy)
                                    ? const AssetImage(
                                        'assets/images/face_happy_selected.png',
                                      )
                                    : const AssetImage(
                                        'assets/images/face_happy.png'),
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ),
                          const Text('Happy',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white))
                        ],
                      ),
                    ),
                  ]),
                  Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.vertical,
                      spacing: 5,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              (widget.initialAssessment)
                                  ? setState(() {
                                      isVeryHappy = false;
                                      isHappy = false;
                                      isNeutral = true;
                                      isBad = false;
                                      isVeryBad = false;
                                    })
                                  : toEmotionalEvaluationPositiveNegative(
                                      context, widget.initialAssessment);
                              print('neutral');
                            }, // Image tapped
                            splashColor:
                                Colors.white12, // Splash color over image
                            child: Ink.image(
                              image: (isNeutral)
                                  ? const AssetImage(
                                      'assets/images/face_neutral_selected.png',
                                    )
                                  : const AssetImage(
                                      'assets/images/face_neutral.png'),
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                        const Text('Neutral',
                            style: TextStyle(fontSize: 18, color: Colors.white))
                      ],
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Center(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.vertical,
                        spacing: 5,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                (widget.initialAssessment)
                                    ? setState(() {
                                        isVeryHappy = false;
                                        isHappy = false;
                                        isNeutral = false;
                                        isBad = false;
                                        isVeryBad = true;
                                      })
                                    : toEmotionalEvaluationPositiveNegative(
                                        context, widget.initialAssessment);
                                print('very bad');
                              }, // Image tapped
                              splashColor:
                                  Colors.white12, // Splash color over image
                              child: Ink.image(
                                image: (isVeryBad)
                                    ? const AssetImage(
                                        'assets/images/face_very_bad_selected.png',
                                      )
                                    : const AssetImage(
                                        'assets/images/face_very_bad.png'),
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ),
                          const Text('Very Bad',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white))
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Center(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.vertical,
                        spacing: 5,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                (widget.initialAssessment)
                                    ? setState(() {
                                        isVeryHappy = false;
                                        isHappy = false;
                                        isNeutral = false;
                                        isBad = true;
                                        isVeryBad = false;
                                      })
                                    : toEmotionalEvaluationPositiveNegative(
                                        context, widget.initialAssessment);
                                print('bad');
                              }, // Image tapped
                              splashColor:
                                  Colors.white12, // Splash color over image
                              child: Ink.image(
                                image: (isBad)
                                    ? const AssetImage(
                                        'assets/images/face_bad_selected.png',
                                      )
                                    : const AssetImage(
                                        'assets/images/face_bad.png'),
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ),
                          const Text('Bad',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ]),
                ]),
          ),
        ]),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                  child: const Text(
                    'Next',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.all(10),
                    primary: (isVeryHappy &&
                            isHappy &&
                            isNeutral &&
                            isBad &&
                            isVeryBad)
                        ? const Color(0xffE2E4E4)
                        : const Color(0xffFFBE18),
                  ),
                  onPressed: () {
                    (isVeryHappy && isHappy && isNeutral && isBad && isVeryBad)
                        ? null
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MaterialApp(
                                        home:
                                            EmotionalEvaluationPositiveNegativeScreen(
                                      initialAssessment: true,
                                    ))));
                    //
                  }),
            ),
          ),
        ),
        // EmotionalEvaluationComponent(
        //     initialAssessment: widget.initialAssessment),
      ]),
    );
  }
}

class Emotion {
  final int id;
  final String name;

  Emotion({
    required this.id,
    required this.name,
  });

  @override
  toString() => '$name';
}

class EmotionalEvaluationPositiveNegativeScreen extends StatefulWidget {
  final bool initialAssessment;

  const EmotionalEvaluationPositiveNegativeScreen(
      {key, required this.initialAssessment})
      : super(key: key);

  @override
  _EmotionalEvaluationPositiveNegativeScreenState createState() =>
      _EmotionalEvaluationPositiveNegativeScreenState();
}

class _EmotionalEvaluationPositiveNegativeScreenState
    extends State<EmotionalEvaluationPositiveNegativeScreen> {
  // int position = 11;

  @override
  Widget build(BuildContext context) {
    final List<Emotion> positiveEmotionsList = [
      Emotion(id: 1, name: 'Good'),
      Emotion(id: 2, name: 'Happy'),
      Emotion(id: 3, name: 'Confident'),
      Emotion(id: 4, name: 'Proud'),
      Emotion(id: 5, name: 'Test'),
      Emotion(id: 6, name: 'Test1'),
      Emotion(id: 7, name: 'Test2'),
      Emotion(id: 5, name: 'Test'),
      Emotion(id: 6, name: 'Test1'),
      Emotion(id: 7, name: 'Test2'),
      Emotion(id: 5, name: 'Test'),
      Emotion(id: 6, name: 'Test1'),
      Emotion(id: 7, name: 'Test2'),
      Emotion(id: 5, name: 'Test'),
      Emotion(id: 6, name: 'Test1'),
      Emotion(id: 7, name: 'Test2'),
    ];

    final List<Emotion> negativeEmotionsList = [
      Emotion(id: 1, name: 'Unmotivated'),
      Emotion(id: 2, name: 'Depressed'),
      Emotion(id: 3, name: 'Tired'),
      Emotion(id: 4, name: 'Isolated'),
    ];

    final _positiveEmotionsItems = positiveEmotionsList
        .map((emotion) => MultiSelectItem<Emotion>(emotion, emotion.name))
        .toList();

    final _negativeEmotionsItems = negativeEmotionsList
        .map((emotion) => MultiSelectItem<Emotion>(emotion, emotion.name))
        .toList();

    List<Emotion?> _selectedPositiveEmotions = [];
    List<Emotion?> _selectedNegativeEmotions = [];

    return Scaffold(
        body: Stack(children: [
      Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/blue_background.png',
                  ),
                  fit: BoxFit.cover))),
      // Keeps the StepProgressIndicator in the same spot
      // Visibility(
      //   visible: widget.initialAssessment,
      //   child: Container(
      //     padding: const EdgeInsets.symmetric(vertical: 75, horizontal: 25),
      //     child: Align(
      //       alignment: Alignment.topCenter,
      //       child: StepProgressIndicator(
      //         totalSteps: 11,
      //         currentStep: position,
      //         selectedColor: Colors.white,
      //         unselectedColor: const Color(0xff004479),
      //       ),
      //     ),
      //   ),
      // ),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
          child:
              Wrap(alignment: WrapAlignment.center, runSpacing: 20, children: [
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
              // vertical: 10.0, horizontal: 18.0),
              decoration: BoxDecoration(
                  color: const Color(0xff3290FF).withOpacity(0.60),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: const Center(
                child: Text('Which emotion best apply to you now?',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 0),
              width: double.infinity,
              child: Wrap(runSpacing: 10, children: [
                Text('Positive',
                    style: TextStyle(color: Colors.white, fontSize: 20)),

                // Chips
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    // border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: MultiSelectChipField<Emotion?>(
                    scroll: false,
                    showHeader: false,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.white)),
                    headerColor: Colors.white,
                    title: const Text('Positive Emotions'),
                    textStyle: const TextStyle(color: const Color(0xff4CA7FC)),
                    selectedChipColor: const Color(0xff4CA7FC),
                    selectedTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    items: _positiveEmotionsItems,
                    // icon: Icon(Icons.check),
                    onTap: (values) {
                      _selectedPositiveEmotions = values;
                      print(_selectedPositiveEmotions);
                    },
                  ),
                ),

                Text('Negative',
                    style: TextStyle(color: Colors.white, fontSize: 20)),

                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                  ),
                  child: MultiSelectChipField<Emotion?>(
                    scroll: false,
                    showHeader: false,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.white)),
                    headerColor: Colors.white,
                    title: const Text('Negative Emotions'),
                    textStyle: const TextStyle(color: const Color(0xff4CA7FC)),
                    selectedChipColor: const Color(0xff4CA7FC),
                    selectedTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    items: _negativeEmotionsItems,
                    // icon: Icon(Icons.check),
                    onTap: (values) {
                      _selectedNegativeEmotions = values;

                      print(_selectedNegativeEmotions);
                    },
                  ),
                ),

                // DROPDOWNS
                // Container(
                //   padding: const EdgeInsets.all(15.0),
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: const BorderRadius.all(Radius.circular(8))),
                //   child: MultiSelectBottomSheetField<Emotion?>(
                //     initialChildSize: 0.3,
                //     listType: MultiSelectListType.CHIP,
                //     searchable: true,
                //     buttonText: Text("Positive Emotions",
                //         style: TextStyle(fontSize: 18)),
                //     title: Text("Search for your emotion",
                //         style: TextStyle(fontSize: 16)),
                //     items: _positiveEmotionsItems,
                //     onConfirm: (values) {
                //       _selectedPositiveEmotions = values;
                //       print(_selectedPositiveEmotions);
                //     },
                //     chipDisplay: MultiSelectChipDisplay(
                //       chipColor: Color(0xff4CA7FC),
                //       textStyle: TextStyle(color: Colors.white),
                //       onTap: (item) {
                //         setState(() {
                //           _selectedPositiveEmotions.remove(item);
                //         });
                //       },
                //     ),
                //   ),
                // ),
                // Container(
                //   padding: const EdgeInsets.all(15.0),
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: const BorderRadius.all(Radius.circular(8))),
                //   child: MultiSelectBottomSheetField<Emotion?>(
                //     initialChildSize: 0.3,
                //     listType: MultiSelectListType.CHIP,
                //     searchable: true,
                //     buttonText: Text("Negative Emotions",
                //         style: TextStyle(fontSize: 18)),
                //     title: Text("Search for your emotion",
                //         style: TextStyle(fontSize: 16)),
                //     items: _negativeEmotionsItems,
                //     onConfirm: (values) {
                //       _selectedNegativeEmotions = values;
                //       print(_selectedNegativeEmotions);
                //     },
                //     chipDisplay: MultiSelectChipDisplay(
                //       chipColor: Color(0xff4CA7FC),
                //       textStyle: TextStyle(color: Colors.white),
                //       onTap: (item) {
                //         print(item);
                //         setState(() {
                //           _selectedNegativeEmotions.remove(item);
                //         });
                //       },
                //     ),
                //   ),
                // ),
              ]),
            )
          ]),
        )
      ]),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ElevatedButton(
                child: const Text(
                  'Done!',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.all(10),
                  primary: (_selectedPositiveEmotions.isNotEmpty &&
                          _selectedNegativeEmotions.isNotEmpty)
                      ? const Color(0xffFFBE18)
                      : const Color(0xffE2E4E4),
                ),
                onPressed: () {
                  print(_selectedPositiveEmotions.length);
                  print(_selectedPositiveEmotions.isNotEmpty &&
                      _selectedNegativeEmotions.isNotEmpty);
                  (_selectedPositiveEmotions.isNotEmpty &&
                          _selectedNegativeEmotions.isNotEmpty)
                      ? print('ookok')
                      : null;
                  // : Navigator.push(
                  // context,
                  // MaterialPageRoute(
                  // builder: (context) => const MaterialApp(
                  // home:
                  // EmotionalEvaluationPositiveNegativeScreen(
                  // initialAssessment: true,
                  // )
                  // )));
                  //
                }),
          ),
        ),
      ),
    ]));
  }
}

void toEmotionalEvaluationPositiveNegative(context, initialAssessment) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MaterialApp(
                  home: EmotionalEvaluationPositiveNegativeScreen(
                initialAssessment: initialAssessment,
              ))));
}
