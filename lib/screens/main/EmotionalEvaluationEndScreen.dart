import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/Emotion.dart';
import 'package:flutter_application_1/apis/EmotionEntryDetail.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../controllers/emotionController.dart';

void main() {
  runApp(
      const GetMaterialApp(home: EmotionalEvaluationEndScreen()));
}

class EmotionalEvaluationEndScreen extends StatefulWidget {
  const EmotionalEvaluationEndScreen({key}) : super(key: key);

  @override
  _EmotionalEvaluationEndScreenState createState() =>
      _EmotionalEvaluationEndScreenState();
}


final EmotionController _emotionController = Get.put(EmotionController());

class _EmotionalEvaluationEndScreenState
    extends State<EmotionalEvaluationEndScreen> {
    bool isEditMode = false;
    List<Emotion> positiveEmotions = [];
    List<Emotion> negativeEmotions = [];

    void checkIfEditMode() {
      if (_emotionController.isEditMode.value) {
        EmotionEntryDetail emotionEntryDetail = (_emotionController.isMorningCheck.value) 
            ? _emotionController.getSelectedEmotionEntry().morningCheck : (_emotionController.isAfternoonCheck.value)
            ? _emotionController.getSelectedEmotionEntry().afternoonCheck : (_emotionController.isEveningCheck.value) 
            ? _emotionController.getSelectedEmotionEntry().eveningCheck : EmotionEntryDetail(mood: '', positiveEmotions: [], negativeEmotions: [], isEmpty: true);

        isEditMode = _emotionController.isEditMode.value ? true : false;
        positiveEmotions = emotionEntryDetail.positiveEmotions as List<Emotion>;
        negativeEmotions = emotionEntryDetail.negativeEmotions as List<Emotion>;
     }
    }

  @override
  Widget build(BuildContext context) {
    checkIfEditMode();

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




    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: Text(
                'Add an Entry',
                style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
            ),

            leading: BackButton(onPressed: () {Get.toNamed('/homepage');}),
            elevation: 0,
            backgroundColor: Colors.transparent
        ),


        body: Stack(children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/background_images/blue_background.png',
                      ),
                      fit: BoxFit.cover))
          ),


          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Container(
                alignment: Alignment.center,
                child: ListView(
                  children: [
                    Text('Date & Time',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white),
                    ),

                    const SizedBox(height: 35.0),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Date',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                          ),

                          Text('Wed, 2 March',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white),
                          ),
                        ]),

                    const SizedBox(height: 25.0),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Time',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                          ),

                          Text('22:21, Evening',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white),
                          ),
                        ]),

                    const SizedBox(height: 20.0),

                    const Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),

                    const SizedBox(height: 20.0),

                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
                      decoration: BoxDecoration(
                          color: const Color(0xff3290FF).withOpacity(0.60),
                          borderRadius: const BorderRadius.all(Radius.circular(4))),
                      child:Text('Which emotion best apply to you now?',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white, fontWeight: FontWeight.w400)),
                    ),


                    Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        child:
                        Wrap(alignment: WrapAlignment.center, runSpacing: 20, children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 0),
                            width: double.infinity,
                            child: Wrap(runSpacing: 10, children: [
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
                                      initialValue: isEditMode ? positiveEmotions : [],
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
                                      initialValue: isEditMode ? negativeEmotions : [],
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
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: GetBuilder<EmotionController>(
                              builder: (value) => ElevatedButton(
                                  child: Text(
                                    'Save',
                                    style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white),
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
                                    _emotionController.updateEntryInStorage();
                                    Get.offAllNamed('/homepage');
                                  }),
                            )),
                      ),
                    ),
                  ],
                ),
              )
          ),

        ]));
  }
}