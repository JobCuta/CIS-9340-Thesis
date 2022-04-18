import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/widgets/UserEngagementCompletedDialog.dart';
import 'package:get/get.dart';

class UESFocusedAttentionScreen extends StatefulWidget {
  const UESFocusedAttentionScreen({Key? key}) : super(key: key);

  @override
  State<UESFocusedAttentionScreen> createState() =>
      UESFocusedAttentionScreenState();
}

class UESFocusedAttentionScreenState extends State<UESFocusedAttentionScreen> {
  final PageController _pageController = PageController();

  // default values start at 0 since the scale starts at 1
  List<List<int?>> groupValue = [
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0]
  ];

  List<List<String>> questions = [
    [
      'I lost myself in this experience',
      'The time I spent using Kasiyanna just slipped away',
      'I was absorbed in this experience'
    ],
    [
      'I felt frustrated while using Kasiyanna',
      'I found Kasiyanna confusing to use',
      'Using Kasiyanna was taxing'
    ],
    [
      'Kasiyanna was attractive',
      'Kasiyanna was aesthetically appealing',
      'Kasiyanna appealed to my senses'
    ],
    [
      'Using Kasiyanna was worthwhile',
      'My experience using the app was rewarding',
      'I felt interested in this experience'
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
        appBar: AppBar(
            elevation: 1,
            backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
            leading: BackButton(
                color: Theme.of(context).colorScheme.accentBlue02,
                onPressed: () {
                  Get.offAndToNamed('/homepage');
                }),
            title: Text('User Assessment',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.neutralBlack02))),
        body: SafeArea(
            child: PageView.builder(
                // NeverScrollableScrollPhysics to ensure the user can only navigate through the pageviews with the expected interactions
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemCount: 4,
                itemBuilder: (context, position) {
                  return Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 18),
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _question(position, 0),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Divider(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralWhite04,
                                  height: 10,
                                  thickness: 1,
                                ),
                              ),
                              _question(position, 1),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Divider(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralWhite04,
                                  height: 10,
                                  thickness: 1,
                                ),
                              ),
                              _question(position, 2),
                            ],
                          ),
                        ),
                      ),
                      // Bottom Container
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: position != 0
                              ? Row(children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 50,
                                      child: ElevatedButton(
                                          child: Text(
                                            'Previous',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2
                                                ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .accentBlue02,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            side: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .neutralWhite04),
                                            primary: Theme.of(context)
                                                .colorScheme
                                                .neutralWhite01,
                                          ),
                                          onPressed: () {
                                            (position == 0)
                                                ? Get.toNamed(
                                                    '/assessSIDASScreen')
                                                : _pageController
                                                    .jumpToPage(position - 1);
                                          }),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: SizedBox(
                                      height: 50,
                                      child: ElevatedButton(
                                          child: Text(
                                            position != 3 ? 'Next' : 'Finish',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2
                                                ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .neutralWhite01,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            primary:
                                                groupValue[position].contains(0)
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .neutralWhite04
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .accentBlue02,
                                          ),
                                          onPressed: () {
                                            if (groupValue[position]
                                                .contains(0)) {
                                              return;
                                            }
                                            if (position == 3) {
                                              calculateScores();
                                              showUserEngagementCompletedDialog(
                                                  context);
                                            } else {
                                              _pageController
                                                  .jumpToPage(position + 1);
                                            }
                                          }),
                                    ),
                                  ),
                                ])
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: ElevatedButton(
                                      child: Text(
                                        position == 0 ? 'Next' : 'Finish',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .neutralWhite01,
                                                fontWeight: FontWeight.w600),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        primary:
                                            groupValue[position].contains(0)
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .neutralWhite04
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .accentBlue02,
                                      ),
                                      onPressed: () {
                                        if (groupValue[position].contains(0)) {
                                          return;
                                        }
                                        // Checks if the user selected a valid value
                                        _pageController
                                            .jumpToPage(position + 1);
                                      }),
                                ),
                        ),
                      ),
                    ],
                  );
                })));
  }

  _radioButton(value, position, questionNumber, text) {
    return SizedBox(
      width: 60,
      child: Column(
        children: [
          Radio<int>(
            activeColor: Theme.of(context).colorScheme.accentBlue02,
            value: value,
            groupValue: groupValue[position][questionNumber],
            onChanged: (newValue) {
              setState(() => groupValue[position][questionNumber] = newValue);
            },
          ),
          Text(text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.neutralGray04))
        ],
      ),
    );
  }

  _question(position, questionNumber) {
    return Wrap(
      spacing: 15,
      alignment: WrapAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).size.width,
          child: Text(questions[position][questionNumber],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.neutralBlack03)),
        ),
        _radioButton(position != 1 ? 1 : 5, position, questionNumber,
            'Strongly\nDisagree'),
        _radioButton(
            position != 1 ? 2 : 4, position, questionNumber, 'Disagree'),
        _radioButton(
            position != 1 ? 3 : 3, position, questionNumber, 'Neutral'),
        _radioButton(position != 1 ? 4 : 2, position, questionNumber, 'Agree'),
        _radioButton(
            position != 1 ? 5 : 1, position, questionNumber, 'Strongly\nAgree'),
      ],
    );
  }

  void calculateScores() {
    double total = 0;
    var category = [
      'Focused Attention',
      'Perceived Usability',
      'Aesthetic Appeal',
      'Reward Factor'
    ];

    List<int> categorySum = [0, 0, 0, 0];
    List<double> categoryScore = [0, 0, 0, 0];
    for (int i = 0; i < groupValue.length; i++) {
      for (int? value in groupValue[i]) {
        categorySum[i] += value!;
        total += value;
      }

      categoryScore[i] = categorySum[i] / 3;
      print('${category[i]}: ${categoryScore[i].toStringAsFixed(2)} / 5.0');
    }

    total /= 12;
    print('Overall Engagement Score: ${total.toStringAsFixed(2)} / 5.0');
  }
}
