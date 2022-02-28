import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';

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

class Emotions extends ChangeNotifier {
  List<Emotion?> _selectedPositiveEmotions = [];
  List<Emotion?> _selectedNegativeEmotions = [];
}

class EmotionalEvaluationPositiveNegativeScreen extends StatefulWidget {
  const EmotionalEvaluationPositiveNegativeScreen({key}) : super(key: key);

  @override
  _EmotionalEvaluationPositiveNegativeScreenState createState() =>
      _EmotionalEvaluationPositiveNegativeScreenState();
}

class _EmotionalEvaluationPositiveNegativeScreenState
    extends State<EmotionalEvaluationPositiveNegativeScreen> {
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

    bool _selectedPositiveFlag = _selectedPositiveEmotions.isNotEmpty;
    bool _selectedNegativeFlag = _selectedNegativeEmotions.isNotEmpty;

    return Scaffold(
        body: Stack(children: [
      Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/background_images/blue_background.png',
                  ),
                  fit: BoxFit.cover))),
      Padding(
        padding: const EdgeInsets.fromLTRB(25, 75, 25, 0),
        child: Container(
          height: 50,
          // width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
          // vertical: 10.0, horizontal: 18.0),
          decoration: BoxDecoration(
              color: const Color(0xff3290FF).withOpacity(0.60),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: const Align(
            alignment: Alignment.topCenter,
            child: Text('Which emotion best apply to you now?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ),
      ),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
          child:
              Wrap(alignment: WrapAlignment.center, runSpacing: 20, children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 0),
              width: double.infinity,
              child: Wrap(runSpacing: 10, children: [
                // const Text('Positive',
                // style: TextStyle(color: Colors.white, fontSize: 20)),

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
                    textStyle: const TextStyle(color: Color(0xff4CA7FC)),
                    selectedChipColor: const Color(0xff4CA7FC),
                    selectedTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    items: _positiveEmotionsItems,
                    // icon: Icon(Icons.check),
                    onTap: (values) {
                      _selectedPositiveEmotions = values;
                      setState() {
                        _selectedPositiveFlag =
                            _selectedPositiveEmotions.isNotEmpty;
                      }

                      print(_selectedPositiveEmotions);
                    },
                  ),
                ),

                const Text('Negative',
                    style: TextStyle(color: Colors.white, fontSize: 20)),

                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  child: MultiSelectChipField<Emotion?>(
                    scroll: false,
                    showHeader: false,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.white)),
                    headerColor: Colors.white,
                    title: const Text('Negative Emotions'),
                    textStyle: const TextStyle(color: Color(0xff4CA7FC)),
                    selectedChipColor: const Color(0xff4CA7FC),
                    selectedTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    items: _negativeEmotionsItems,
                    // icon: Icon(Icons.check),
                    onTap: (values) {
                      _selectedNegativeEmotions = values;
                      setState() {
                        _selectedNegativeFlag =
                            _selectedNegativeEmotions.isNotEmpty;
                      }

                      print(_selectedNegativeEmotions);
                    },
                  ),
                ),

                // DROPDOWNS
                //         Container(
                //           padding: const EdgeInsets.all(15.0),
                //           decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: const BorderRadius.all(Radius.circular(8))),
                //           child: MultiSelectBottomSheetField<Emotion?>(
                //             initialChildSize: 0.3,
                //             listType: MultiSelectListType.CHIP,
                //             searchable: true,
                //             buttonText: Text("Positive Emotions",
                //                 style: TextStyle(fontSize: 18)),
                //             title: Text("Search for your emotion",
                //                 style: TextStyle(fontSize: 16)),
                //             items: _positiveEmotionsItems,
                //             onConfirm: (values) {
                //               _selectedPositiveEmotions = values;
                //               print(_selectedPositiveEmotions);
                //             },
                //             chipDisplay: MultiSelectChipDisplay(
                //               chipColor: Color(0xff4CA7FC),
                //               textStyle: TextStyle(color: Colors.white),
                //               onTap: (item) {
                //                 setState(() {
                //                   _selectedPositiveEmotions.remove(item);
                //                 });
                //               },
                //             ),
                //           ),
                //         ),
                //         Container(
                //           padding: const EdgeInsets.all(15.0),
                //           decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: const BorderRadius.all(Radius.circular(8))),
                //           child: MultiSelectBottomSheetField<Emotion?>(
                //             initialChildSize: 0.3,
                //             listType: MultiSelectListType.CHIP,
                //             searchable: true,
                //             buttonText: Text("Negative Emotions",
                //                 style: TextStyle(fontSize: 18)),
                //             title: Text("Search for your emotion",
                //                 style: TextStyle(fontSize: 16)),
                //             items: _negativeEmotionsItems,
                //             onConfirm: (values) {
                //               _selectedNegativeEmotions = values;
                //               print(_selectedNegativeEmotions);
                //             },
                //             chipDisplay: MultiSelectChipDisplay(
                //               chipColor: Color(0xff4CA7FC),
                //               textStyle: TextStyle(color: Colors.white),
                //               onTap: (item) {
                //                 print(item);
                //                 setState(() {
                //                   _selectedNegativeEmotions.remove(item);
                //                 });
                //               },
                //             ),
                //           ),
                //         ),
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
                  print(_selectedPositiveFlag);
                  print(_selectedNegativeFlag);
                  (_selectedPositiveEmotions.isNotEmpty &&
                          _selectedNegativeEmotions.isNotEmpty)

                      // Contains the alert dialog for user verification son setting notifications
                      ? showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                insetPadding: const EdgeInsets.all(20.0),
                                title: const Text(
                                  'One last thing...',
                                  style: TextStyle(
                                    color: Color(0xffFFC122),
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                content: Wrap(
                                  // runSpacing: 10,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    const Text(
                                      'These questions will be asked to you 3 times a day. Would you like to be reminded when to answer them?',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 0),
                                      child: Divider(
                                        height: 1.0,
                                        thickness: 1.0,
                                        color: Color(0xffF0F1F1),
                                      ),
                                    ),
                                    const Image(
                                      image: AssetImage(
                                          'assets/images/notification_bell.png'),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 50,
                                      margin: const EdgeInsets.fromLTRB(
                                          15, 10, 15, 10),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            primary: const Color(0xffFFC122),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                          ),
                                          child: const Text(
                                            'Yes',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Proxima Nova',
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            // Navigator
                                          }),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 50,
                                      margin: const EdgeInsets.fromLTRB(
                                          15, 0, 15, 0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xffE2E4E4),
                                              width: 1),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30))),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            primary: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                          ),
                                          child: const Text(
                                            "I'll do this later...",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Proxima Nova',
                                              fontSize: 20,
                                              color: Color(0xffFFC122),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                    )
                                  ],
                                ),
                              ))
                      : null;
                }),
          ),
        ),
      ),
    ]));
  }
}
