import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/timeController.dart';

void main() {
  runApp(const GetMaterialApp(home: SetNotificationScreen()));
}

class SetNotificationScreen extends StatefulWidget {
  const SetNotificationScreen({Key? key}) : super(key: key);

  @override
  SetNotificationScreenState createState() => SetNotificationScreenState();
}

class SetNotificationScreenState extends State<SetNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final TimeController _timeController = Get.put(TimeController());

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
        padding: const EdgeInsets.fromLTRB(25, 100, 25, 0),
        child: Container(
          alignment: Alignment.center,
          height: 120,
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
          decoration: BoxDecoration(
              color: const Color(0xff3290FF).withOpacity(0.60),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Text(
              'Set your preferred times for the day for when you want to be notified',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.white)),
        ),
      ),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
          child:
              Wrap(alignment: WrapAlignment.center, runSpacing: 20, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Morning',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontFamily: 'Proxima Nova',
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              TextButton(
                  onPressed: () {
                    _timeController.selectMorningTime(context);
                  },
                  child: GetBuilder<TimeController>(
                      builder: (value) => RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: _timeController.morningTime.value
                                      .format(context),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                          fontFamily: 'Proxima Nova',
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white)),
                              const WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(Icons.keyboard_arrow_right_sharp,
                                      size: 30, color: Colors.white))
                            ]),
                          )))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Afternoon',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontFamily: 'Proxima Nova',
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              TextButton(
                  onPressed: () {
                    _timeController.selectAfternoonTime(context);
                  },
                  child: GetBuilder<TimeController>(
                      builder: (value) => RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: _timeController.afternoonTime.value
                                      .format(context),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                          fontFamily: 'Proxima Nova',
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white)),
                              const WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(Icons.keyboard_arrow_right_sharp,
                                      size: 30, color: Colors.white))
                            ]),
                          )))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Evening',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontFamily: 'Proxima Nova',
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              TextButton(
                  onPressed: () {
                    _timeController.selectEveningTime(context);
                  },
                  child: GetBuilder<TimeController>(
                      builder: (value) => RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: _timeController.eveningTime.value
                                      .format(context),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                          fontFamily: 'Proxima Nova',
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white)),
                              const WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(Icons.keyboard_arrow_right_sharp,
                                      size: 30, color: Colors.white))
                            ]),
                          ))),
            ]),
          ]),
        )
      ]),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: const Color(0xffFFC122),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'Done!',
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Proxima Nova'),
                ),
                onPressed: () {
                  Get.toNamed('/loadingScreen');
                }),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffE2E4E4), width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  "I'll do this later...",
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: const Color(0xffFFC122),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Proxima Nova'),
                ),
                onPressed: () {
                  Get.toNamed('/loadingScreen');
                }),
          ),
        ),
      )
    ]));
  }
}
