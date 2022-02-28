import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const GetMaterialApp(home: SetNotificationScreen()));
}

class SetNotificationScreen extends StatefulWidget {
  const SetNotificationScreen({Key? key}) : super(key: key);

  @override
  SetNotificationScreenState createState() => SetNotificationScreenState();
}

class SetNotificationScreenState extends State<SetNotificationScreen> {
  // Need help on this: update the variable based on Future<dynamic> function [TestTimePicker]
  // Need to format the text to only show the value in the screen (not TimeOfDate(...))
  var _morningTime = const TimeOfDay(hour: 9, minute: 30).obs;
  var _afternoonTime = const TimeOfDay(hour: 12, minute: 30).obs;
  var _eveningTime = const TimeOfDay(hour: 18, minute: 30).obs;

  @override
  Widget build(BuildContext context) {
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
          height: 120,
          // width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
          // vertical: 10.0, horizontal: 18.0),
          decoration: BoxDecoration(
              color: const Color(0xff3290FF).withOpacity(0.60),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: const Align(
            alignment: Alignment.topCenter,
            child: Text(
                'Set your preferred times for the day for when you want to be notified',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Proxima Nova')),
          ),
        ),
      ),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
          child:
              Wrap(alignment: WrapAlignment.center, runSpacing: 20, children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Morning',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              const Expanded(
                flex: 1,
                child: const Text(''),
              ),
              Obx(() => TextButton(
                  onPressed: () {
                    _morningTime.value = TestTimePicker(
                            context, _morningTime.value, 'MORNING REMINDER')
                        as TimeOfDay;
                  },
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: '${_morningTime.value}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18)),
                      const WidgetSpan(
                          child: Icon(Icons.keyboard_arrow_right_sharp,
                              color: Colors.white))
                    ]),
                  )))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Afternoon',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              const Expanded(
                flex: 1,
                child: Text(''),
              ),
              Obx(() => TextButton(
                  onPressed: () {
                    _afternoonTime = TestTimePicker(
                        context, _afternoonTime.value, 'AFTERNOON REMINDER');
                  },
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: '${_afternoonTime.value}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18)),
                      const WidgetSpan(
                          child: Icon(Icons.keyboard_arrow_right_sharp,
                              color: Colors.white))
                    ]),
                  )))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Evening',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              const Expanded(
                flex: 1,
                child: const Text(''),
              ),
              Obx(() => TextButton(
                  onPressed: () {
                    _eveningTime = TestTimePicker(
                        context, _eveningTime.value, 'EVENING REMINDER');
                  },
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: '${_eveningTime.value}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18)),
                      const WidgetSpan(
                          child: const Icon(Icons.keyboard_arrow_right_sharp,
                              color: Colors.white))
                    ]),
                  )))
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
                child: const Text(
                  'Done!',
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
          ),
        ),
      )
    ]));
  }
}

TestTimePicker(context, defaultTime, helpText) async {
  await showTimePicker(
    context: context,
    initialTime: defaultTime as TimeOfDay,
    initialEntryMode: TimePickerEntryMode.dial,
    confirmText: "CONFIRM",
    cancelText: "CANCEL",
    helpText: helpText,
  );
}
