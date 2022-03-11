import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../controllers/sidasController.dart';

class SIDASScreen extends StatefulWidget {
  const SIDASScreen({Key? key, bool? initialAssessment}) : super(key: key);

  @override
  _SIDASScreenState createState() => _SIDASScreenState();
}

class _SIDASScreenState extends State<SIDASScreen> {
  final PageController _pageController = PageController();

  // SIDAS Questions
  final List<String> questions = [
    'In the past month, how often have you had thoughts about suicide?',
    'In the past month, how much control have you had over these thoughts?',
    'In the past month, how close have you come to making a suicide attempt?',
    'In the past month, to what extent have you felt tormented by thoughts about suicide?',
    'In the past month, how much have thoughts about suicide interfered with your ability to carry out daily activities, such as work, household tasks or social activies?',
  ];

  final List<String> answer_guide = [
    '(0 = Never, 10 = Always)',
    '(0 = No Control, 10 = Full Control)',
    '(0 = Not close at all, 10 = Made an attempt)',
    '(0 = Not at all, 10 = Extremely)',
    '(0 = Not at all, 10 = Extremely)',
  ];

  final List<String> zero_string = [
    '0 = Never',
    '0 = No Control',
    '0 = Not close at all',
    '0 = Not at all',
    '0 = Not at all',
  ];

  final SIDASController _sidasController = Get.put(SIDASController());

  @override
  Widget build(BuildContext context) {
    // Currently can't figure out how to display the hint text (Pick an option) with the current implementation
    // thus 'Pick an option' was added as an option (countermeasure added to ensure the user cannot proceed unless they choose a different option)
    return Scaffold(
      body: PageView.builder(
          // NeverScrollableScrollPhysics to ensure the user can only navigate through the pageviews with the expected interactions
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemCount: questions.length,
          itemBuilder: (context, position) {
            return Stack(children: [
              Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/background_images/blue_background.png',
                          ),
                          fit: BoxFit.cover))),
              // Keeps the StepProgressIndicator in the same spot
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: StepProgressIndicator(
                    selectedSize: 8.0,
                    unselectedSize: 8.0,
                    roundedEdges: const Radius.circular(4),
                    totalSteps: questions.length,
                    currentStep: position + 1,
                    selectedColor: Colors.white,
                    unselectedColor: const Color(0xffA1D6FF),
                  ),
                ),
              ),

              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Center(
                    child: Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 20,
                        children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                        padding: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 15.0),
                        decoration: BoxDecoration(
                            color: const Color(0xff3290FF).withOpacity(0.60),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: Wrap(
                            alignment: WrapAlignment.center,
                            runSpacing: 20,
                            children: [
                              Text(questions[position],
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white)),
                              Text(answer_guide[position],
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.white))
                            ]),
                      ),
                      GetBuilder<SIDASController>(
                        builder: (value) => Row(children: [
                          Expanded(
                            child: InkWell(
                                onTap: () {
                                  _sidasController.updateValues(
                                      position, (position != 1) ? 0 : 10);
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: position != 1
                                                ? _sidasController.answerValues[
                                                            position] ==
                                                        0
                                                    ? Colors.white
                                                    : Colors.transparent
                                                : _sidasController.answerValues[
                                                            position] ==
                                                        10
                                                    ? Colors.white
                                                    : Colors.transparent,
                                            width: 4),
                                        color: const Color(0xffFFB762)),
                                    child: Text('0',
                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white)))),
                          ),
                          Expanded(
                            child: InkWell(
                                onTap: () {
                                  _sidasController.updateValues(
                                      position, (position != 1) ? 1 : 9);
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: position != 1
                                                ? _sidasController.answerValues[
                                                            position] ==
                                                        1
                                                    ? Colors.white
                                                    : Colors.transparent
                                                : _sidasController.answerValues[
                                                            position] ==
                                                        9
                                                    ? Colors.white
                                                    : Colors.transparent,
                                            width: 4),
                                        color: const Color(0xffFFAE50)),
                                    child: Text('1',
                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white)))),
                          ),
                          Expanded(
                            child: InkWell(
                                onTap: () {
                                  _sidasController.updateValues(
                                      position, (position != 1) ? 2 : 8);
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: position != 1
                                                ? _sidasController.answerValues[
                                                            position] ==
                                                        2
                                                    ? Colors.white
                                                    : Colors.transparent
                                                : _sidasController.answerValues[
                                                            position] ==
                                                        8
                                                    ? Colors.white
                                                    : Colors.transparent,
                                            width: 4),
                                        color: const Color(0xffFFA236)),
                                    child: Text('2',
                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white)))),
                          ),
                          Expanded(
                            child: InkWell(
                                onTap: () {
                                  _sidasController.updateValues(
                                      position, (position != 1) ? 3 : 7);
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: position != 1
                                                ? _sidasController.answerValues[
                                                            position] ==
                                                        3
                                                    ? Colors.white
                                                    : Colors.transparent
                                                : _sidasController.answerValues[
                                                            position] ==
                                                        7
                                                    ? Colors.white
                                                    : Colors.transparent,
                                            width: 4),
                                        color: const Color(0xffFF8A00)),
                                    child: Text('3',
                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white)))),
                          ),
                          Expanded(
                            child: InkWell(
                                onTap: () {
                                  _sidasController.updateValues(
                                      position, (position != 1) ? 4 : 6);
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: position != 1
                                                ? _sidasController.answerValues[
                                                            position] ==
                                                        4
                                                    ? Colors.white
                                                    : Colors.transparent
                                                : _sidasController.answerValues[
                                                            position] ==
                                                        6
                                                    ? Colors.white
                                                    : Colors.transparent,
                                            width: 4),
                                        color: const Color(0xffFF7A00)),
                                    child: Text('4',
                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white)))),
                          ),
                          Expanded(
                            child: InkWell(
                                onTap: () {
                                  _sidasController.updateValues(position, 5);
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                _sidasController.answerValues[
                                                            position] ==
                                                        5
                                                    ? Colors.white
                                                    : Colors.transparent,
                                            width: 4),
                                        color: const Color(0xffFF6B00)),
                                    child: Text('5',
                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white)))),
                          ),
                          Expanded(
                            child: InkWell(
                                onTap: () {
                                  _sidasController.updateValues(
                                      position, (position != 1) ? 6 : 4);
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: position != 1
                                                ? _sidasController.answerValues[
                                                            position] ==
                                                        6
                                                    ? Colors.white
                                                    : Colors.transparent
                                                : _sidasController.answerValues[
                                                            position] ==
                                                        4
                                                    ? Colors.white
                                                    : Colors.transparent,
                                            width: 4),
                                        color: const Color(0xffFF7A00)),
                                    child: Text('6',
                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white)))),
                          ),
                          Expanded(
                            child: InkWell(
                                onTap: () {
                                  _sidasController.updateValues(
                                      position, (position != 1) ? 7 : 3);
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: position != 1
                                                ? _sidasController.answerValues[
                                                            position] ==
                                                        7
                                                    ? Colors.white
                                                    : Colors.transparent
                                                : _sidasController.answerValues[
                                                            position] ==
                                                        3
                                                    ? Colors.white
                                                    : Colors.transparent,
                                            width: 4),
                                        color: const Color(0xffFF8A00)),
                                    child: Text('7',
                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white)))),
                          ),
                          Expanded(
                            child: InkWell(
                                onTap: () {
                                  _sidasController.updateValues(
                                      position, (position != 1) ? 8 : 2);
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: position != 1
                                                ? _sidasController.answerValues[
                                                            position] ==
                                                        8
                                                    ? Colors.white
                                                    : Colors.transparent
                                                : _sidasController.answerValues[
                                                            position] ==
                                                        2
                                                    ? Colors.white
                                                    : Colors.transparent,
                                            width: 4),
                                        color: const Color(0xffFFA236)),
                                    child: Text('8',
                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white)))),
                          ),
                          Expanded(
                            child: InkWell(
                                onTap: () {
                                  _sidasController.updateValues(
                                      position, (position != 1) ? 9 : 1);
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: position != 1
                                                ? _sidasController.answerValues[
                                                            position] ==
                                                        9
                                                    ? Colors.white
                                                    : Colors.transparent
                                                : _sidasController.answerValues[
                                                            position] ==
                                                        1
                                                    ? Colors.white
                                                    : Colors.transparent,
                                            width: 4),
                                        color: const Color(0xffFFAE50)),
                                    child: Text('9',
                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white)))),
                          ),
                          Expanded(
                            child: InkWell(
                                onTap: () {
                                  _sidasController.updateValues(
                                      position, (position != 1) ? 10 : 0);
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: position != 1
                                                ? _sidasController.answerValues[
                                                            position] ==
                                                        10
                                                    ? Colors.white
                                                    : Colors.transparent
                                                : _sidasController.answerValues[
                                                            position] ==
                                                        0
                                                    ? Colors.white
                                                    : Colors.transparent,
                                            width: 4),
                                        color: const Color(0xffFFB762)),
                                    child: Text('10',
                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white)))),
                          )
                        ]),
                        // InkWell(
                        //     onTap: () {
                        //       _sidasController.updateValues(
                        //           position, (position != 1) ? 0 : 10);
                        //     },
                        //     child: Container(
                        //         alignment: Alignment.center,
                        //         width: MediaQuery.of(context).size.width,
                        //         padding: const EdgeInsets.symmetric(
                        //             vertical: 13.0, horizontal: 14.0),
                        //         decoration: const BoxDecoration(
                        //             color: Color(0xffFFA236),
                        //             borderRadius:
                        //                 BorderRadius.all(Radius.circular(3))),
                        //         child: Text(zero_string[position],
                        //             style: Theme.of(context)
                        //                 .textTheme
                        //                 .bodyText1
                        //                 ?.copyWith(
                        //                     color: Colors.white,
                        //                     fontWeight: FontWeight.w700,
                        //                     fontFamily: 'Proxima Nova')))),
                      )
                    ])),
              ),
              // Bottombar
              Container(
                padding: const EdgeInsets.all(20),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              child: Text(
                                'Previous',
                                style: Theme.of(context).textTheme.subtitle2?.copyWith(color: const Color(0xffFFBE18)),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.all(10),
                                primary: Colors.white,
                              ),
                              onPressed: () {
                                (position == 0)
                                    ? Get.toNamed('/assessSIDASScreen')
                                    : _pageController.jumpToPage(position - 1);
                              }),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              child: Text(
                                'Next',
                                style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.all(10),
                                primary: const Color(0xffFFBE18),
                              ),
                              onPressed: () {
                                (position == questions.length - 1)
                                    ? Get.toNamed('/loadingScreen')
                                    // Checks if the user selected a valid value
                                    : _pageController.jumpToPage(position + 1);
                              }),
                        ),
                      ),
                    ])),
              ),
            ]);
          }),
    );
  }
}
