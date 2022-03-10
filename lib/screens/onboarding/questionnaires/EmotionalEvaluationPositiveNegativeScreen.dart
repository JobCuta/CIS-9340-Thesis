import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../controllers/emotionController.dart';

void main() {
  runApp(
      const GetMaterialApp(home: EmotionalEvaluationPositiveNegativeScreen()));
}

class Emotion {
  final int id;
  final String name;

  Emotion({
    required this.id,
    required this.name,
  });

  @override
  toString() => name;
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

    final EmotionController _emotionController = Get.put(EmotionController());

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
        padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
        child: Container(
          alignment: Alignment.center,
          height: 100,
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
          decoration: BoxDecoration(
              color: const Color(0xff3290FF).withOpacity(0.60),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
          child: Text('Which emotion best apply to you now?',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(fontSize: 24, color: Colors.white)),
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
                // Chips
                // const Text('Positive',
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 16,
                //         fontFamily: 'Proxima Nova',
                //         fontWeight: FontWeight.w600)),
                // Container(
                //     padding: const EdgeInsets.all(8),
                //     decoration: const BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.all(Radius.circular(24)),
                //       // border: Border.all(color: Colors.white, width: 1),
                //     ),
                //     child: GetBuilder<EmotionController>(
                //       builder: (value) => MultiSelectChipField<Emotion?>(
                //         scroll: false,
                //         showHeader: false,
                //         decoration: BoxDecoration(
                //             border: Border.all(color: Colors.white)),
                //         textStyle: const TextStyle(
                //             color: Color(0xff4CA7FC),
                //             fontSize: 14,
                //             fontWeight: FontWeight.w600,
                //             fontFamily: 'Proxima Nova'),
                //         selectedChipColor: const Color(0xff4CA7FC),
                //         selectedTextStyle: const TextStyle(
                //             color: Colors.white,
                //             fontSize: 14,
                //             fontWeight: FontWeight.w600,
                //             fontFamily: 'Proxima Nova'),
                //         items: _positiveEmotionsItems,
                //         onTap: (values) {
                //           _emotionController.updatePositiveEmotion(values);
                //         },
                //       ),
                //     )),

                // const Text('Negative',
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 16,
                //         fontFamily: 'Proxima Nova',
                //         fontWeight: FontWeight.w600)),

                // Container(
                //   padding: const EdgeInsets.all(8),
                //   decoration: const BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.all(Radius.circular(24)),
                //   ),
                //   child: MultiSelectChipField<Emotion?>(
                //     scroll: false,
                //     showHeader: false,
                //     decoration:
                //         BoxDecoration(border: Border.all(color: Colors.white)),
                //     textStyle: const TextStyle(
                //         color: Color(0xff4CA7FC),
                //         fontSize: 14,
                //         fontWeight: FontWeight.w600,
                //         fontFamily: 'Proxima Nova'),
                //     selectedChipColor: const Color(0xff4CA7FC),
                //     selectedTextStyle: const TextStyle(
                //         color: Colors.white,
                //         fontSize: 14,
                //         fontWeight: FontWeight.w600,
                //         fontFamily: 'Proxima Nova'),
                //     items: _negativeEmotionsItems,
                //     // icon: Icon(Icons.check),
                //     onTap: (values) {
                //       _emotionController.updateNegativeEmotion(values);
                //     },
                //   ),
                // ),

                // DROPDOWNS
                GetBuilder<EmotionController>(
                  builder: (value) => Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      child: MultiSelectBottomSheetField<Emotion?>(
                        initialChildSize: 0.3,
                        listType: MultiSelectListType.CHIP,
                        searchable: true,
                        buttonText: Text("Positive Emotions",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Proxima Nova',
                                color: (_emotionController
                                        .isPositiveNotEmpty.value)
                                    ? const Color(0xff4CA7FC)
                                    : const Color(0xff778083))),
                        title: const Text("Search for your emotion",
                            style: TextStyle(fontSize: 16)),
                        items: _positiveEmotionsItems,
                        onConfirm: (values) {
                          _emotionController.updatePositiveEmotion(values);
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          chipColor: const Color(0xff4CA7FC),
                          textStyle: const TextStyle(color: Colors.white),
                          onTap: (item) {
                            setState(() {
                              _emotionController.removePositive(item);
                            });
                          },
                        ),
                      )),
                ),
                GetBuilder<EmotionController>(
                  builder: (value) => Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      child: MultiSelectBottomSheetField<Emotion?>(
                        initialChildSize: 0.3,
                        listType: MultiSelectListType.CHIP,
                        searchable: true,
                        buttonText: Text("Negative Emotions",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Proxima Nova',
                                color: (_emotionController
                                        .isNegativeNotEmpty.value)
                                    ? const Color(0xff4CA7FC)
                                    : const Color(0xff778083))),
                        title: const Text("Search for your emotion",
                            style: TextStyle(fontSize: 16)),
                        items: _negativeEmotionsItems,
                        onConfirm: (values) {
                          _emotionController.updateNegativeEmotion(values);
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          chipColor: const Color(0xff4CA7FC),
                          textStyle: const TextStyle(color: Colors.white),
                          onTap: (item) {
                            _emotionController.removeNegative(item);
                          },
                        ),
                      )),
                ),
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
              child: GetBuilder<EmotionController>(
                builder: (value) => ElevatedButton(
                    child: Text(
                      'Done!',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(10),
                      primary: (_emotionController.isValid.value)
                          ? const Color(0xffFFBE18)
                          : const Color(0xffE2E4E4),
                    ),
                    onPressed: () {
                      (_emotionController.isValid.value)
                          // Contains the alert dialog for user verification for setting notifications
                          ? showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    insetPadding: const EdgeInsets.all(20.0),
                                    title: Text(
                                      'One last thing...',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(
                                              color: const Color(0xffFFC122)),
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Wrap(
                                      // runSpacing: 10,
                                      alignment: WrapAlignment.center,
                                      children: [
                                        Text(
                                          'These questions will be asked to you 3 times a day. Would you like to be reminded when to answer them?',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(fontSize: 18),
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
                                        SvgPicture.asset(
                                            'assets/images/notification_bell.svg'),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 50,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 0),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                primary:
                                                    const Color(0xffFFC122),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                ),
                                              ),
                                              child: Text(
                                                'Yes',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    ?.copyWith(
                                                        color: Colors.white),
                                              ),
                                              onPressed: () {
                                                Get.offAndToNamed(
                                                    '/notifScreen');
                                              }),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 50,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 0),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffE2E4E4),
                                                  width: 1),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(30))),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                primary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                ),
                                              ),
                                              child: Text(
                                                "I'll do this later...",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    ?.copyWith(
                                                        color: const Color(
                                                            0xffFFC122)),
                                              ),
                                              onPressed: () {
                                                Get.back();
                                                Get.toNamed('/loadingScreen');
                                              }),
                                        )
                                      ],
                                    ),
                                  ))
                          : null;
                    }),
              )),
        ),
      ),
    ]));
  }
}
