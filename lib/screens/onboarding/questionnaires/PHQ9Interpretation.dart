import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class PHQ9InterpretationScreen extends StatefulWidget {
  int sum = 0;
  PHQ9InterpretationScreen({Key? key, required this.sum}) : super(key: key);

  @override
  _PHQ9InterpretationScreenState createState() =>
      _PHQ9InterpretationScreenState();
}

class _PHQ9InterpretationScreenState extends State<PHQ9InterpretationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(alignment: AlignmentDirectional.topCenter, children: [
      Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/orange_gradient_background.png',
                  ),
                  fit: BoxFit.cover))),
      Container(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 25),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 100,
            runSpacing: 20,
            children: [
              const Text(
                  'Here is your PHQ-9 score and proposed treatment action',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, color: Colors.white)),
              Text.rich(TextSpan(children: <InlineSpan>[
                TextSpan(
                    text: widget.sum.toString(),
                    style: const TextStyle(fontSize: 64, color: Colors.white)),
                const TextSpan(
                    text: '/27',
                    style: TextStyle(fontSize: 64, color: Color(0xffD89512)))
              ])),
              LinearPercentIndicator(
                linearStrokeCap: LinearStrokeCap.butt,
                lineHeight: 20,
                percent: widget.sum / 27,
                progressColor: Colors.white,
                backgroundColor: const Color(0xffFFE297),
              ),
              Text(
                  widget.sum >= 20
                      ? 'Severe'
                      : widget.sum >= 15
                          ? 'Moderately Severe'
                          : widget.sum >= 10
                              ? 'Moderate'
                              : widget.sum >= 5
                                  ? 'Mild'
                                  : 'None - Minimal',
                  style: const TextStyle(color: Colors.white, fontSize: 32)),
              Container(
                // height: 100,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
                decoration: BoxDecoration(
                    color: const Color(0xffFFA132).withOpacity(0.60),
                    // border: Border.all(color: Colors.black38, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: Center(
                  child: Text(
                      widget.sum >= 20
                          ? 'Immediate initiation of pharmacotherapy and, if severe impairment or poor response to therapy, expedited referral to a mental health specialist for psychotherapy and/or collaborative management'
                          : widget.sum >= 15
                              ? 'Active treatment with pharmacotherapy and/or psychotherapy'
                              : widget.sum >= 10
                                  ? 'Treatment plan, considering counseling, follow-up and/or pharmacotherapy'
                                  : widget.sum >= 5
                                      ? 'Watchful waiting; repeat PHQ-9 at follow-up'
                                      : 'None',
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          )),
      Container(
          padding: const EdgeInsets.all(20),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 328,
                height: 50,
                child: ElevatedButton(
                    child: const Text('Take me to Kasiyanna',
                        style: TextStyle(fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(12),
                      primary: const Color(0xffFFBE18),
                    ),
                    onPressed: () {}),
              )))
    ]));
  }
}
