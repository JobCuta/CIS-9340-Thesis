import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const GetMaterialApp(home: SetNotificationScreen()));
}

class TimeController extends GetxController {
  var morningTime = const TimeOfDay(hour: 9, minute: 30).obs;
  var afternoonTime = const TimeOfDay(hour: 12, minute: 30).obs;
  var eveningTime = const TimeOfDay(hour: 18, minute: 30).obs;

  Future _selectMorningTime(BuildContext context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: morningTime.value,
      initialEntryMode: TimePickerEntryMode.dial,
      confirmText: "CONFIRM",
      cancelText: "CANCEL",
      helpText: 'MORNING REMINDER',
    );
    morningTime.value = timeOfDay!;
    update();
  }

  Future _selectAfternoonTime(BuildContext context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: afternoonTime.value,
      initialEntryMode: TimePickerEntryMode.dial,
      confirmText: "CONFIRM",
      cancelText: "CANCEL",
      helpText: 'AFTERNOON REMINDER',
    );
    afternoonTime.value = timeOfDay!;
    update();
  }

  Future _selectEveningTime(BuildContext context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: eveningTime.value,
      initialEntryMode: TimePickerEntryMode.dial,
      confirmText: "CONFIRM",
      cancelText: "CANCEL",
      helpText: 'EVENING REMINDER',
    );
    eveningTime.value = timeOfDay!;
    update();
  }
}

class SetNotificationScreen extends StatefulWidget {
  const SetNotificationScreen({Key? key}) : super(key: key);

  @override
  SetNotificationScreenState createState() => SetNotificationScreenState();
}

class SetNotificationScreenState extends State<SetNotificationScreen> {
  final TimeController _timeController = Get.put(TimeController());

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
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
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
                child: Text(''),
              ),
              TextButton(
                  onPressed: () {
                    _timeController._selectMorningTime(context);
                  },
                  child: GetBuilder<TimeController>(
                      builder: (value) => RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: _timeController.morningTime.value
                                      .format(context),
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
              TextButton(
                  onPressed: () {
                    _timeController._selectAfternoonTime(context);
                  },
                  child: GetBuilder<TimeController>(
                      builder: (value) => RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: _timeController.afternoonTime.value
                                      .format(context),
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
                child: Text(''),
              ),
              TextButton(
                  onPressed: () {
                    _timeController._selectEveningTime(context);
                  },
                  child: GetBuilder<TimeController>(
                      builder: (value) => RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: _timeController.eveningTime.value
                                      .format(context),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              const WidgetSpan(
                                  child: Icon(Icons.keyboard_arrow_right_sharp,
                                      color: Colors.white))
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
                  Get.back();
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
                  Get.back();
                }),
          ),
        ),
      )
    ]));
  }
}
