import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/apis/userSecureStorage.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';

import '../../../constants/notificationService.dart';
import '../../../controllers/settingsController.dart';
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
    final SettingsController _settingsController = Get.put(SettingsController());

    _timeController.morningTime.value = TimeOfDay(
        hour: int.parse(_settingsController.notificationsMorningTime[0]),
        minute: int.parse(_settingsController.notificationsMorningTime[1]));
    _timeController.afternoonTime.value = TimeOfDay(
        hour: int.parse(_settingsController.notificationsAfternoonTime[0]),
        minute: int.parse(_settingsController.notificationsAfternoonTime[1]));
    _timeController.eveningTime.value = TimeOfDay(
        hour: int.parse(_settingsController.notificationsEveningTime[0]),
        minute: int.parse(_settingsController.notificationsEveningTime[1]));

    _buildFieldComponent({required label, required timeValue, required enabled, onPressed}) {
      return InkWell(
        splashColor: Theme.of(context).colorScheme.neutralGray02,
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(label,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.neutralWhite01)),
            GetBuilder<TimeController>(
                builder: (value) => RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: timeValue,
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.neutralWhite01)),
                        WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(Icons.keyboard_arrow_right_sharp,
                                size: 30, color: Theme.of(context).colorScheme.neutralWhite01))
                      ]),
                    ))
          ]),
        ),
      );
    }

    return Scaffold(
        body: Stack(children: [
      Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/background_images/blue_background.png',
                  ),
                  fit: BoxFit.cover))),
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 100, 25, 0),
          child: Container(
            alignment: Alignment.center,
            height: 100,
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            decoration: BoxDecoration(
                color: const Color(0xff3290FF).withOpacity(0.60),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Text('Set your preferred times for the day for when you want to be notified',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.neutralWhite01)),
          ),
        ),
      ),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
          child: Wrap(alignment: WrapAlignment.center, runSpacing: 20, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Morning',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)),
              TextButton(
                  onPressed: () {
                    _timeController.selectMorningTime(context: context);
                  },
                  child: GetBuilder<TimeController>(
                      builder: (value) => RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: _timeController.morningTime.value.format(context),
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.neutralWhite01)),
                              WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(Icons.keyboard_arrow_right_sharp,
                                      size: 30, color: Theme.of(context).colorScheme.neutralWhite01))
                            ]),
                          )))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Afternoon',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)),
              TextButton(
                  onPressed: () {
                    _timeController.selectAfternoonTime(context: context);
                  },
                  child: GetBuilder<TimeController>(
                      builder: (value) => RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: _timeController.afternoonTime.value.format(context),
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.neutralWhite01)),
                              WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(Icons.keyboard_arrow_right_sharp,
                                      size: 30, color: Theme.of(context).colorScheme.neutralWhite01))
                            ]),
                          )))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Evening',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)),
              TextButton(
                  onPressed: () {
                    _timeController.selectEveningTime(context: context);
                  },
                  child: GetBuilder<TimeController>(
                      builder: (value) => RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: _timeController.eveningTime.value.format(context),
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.neutralWhite01)),
                              WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(Icons.keyboard_arrow_right_sharp,
                                      size: 30, color: Theme.of(context).colorScheme.neutralWhite01))
                            ]),
                          ))),
            ]),
          ]),
        )
      ]),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: const EdgeInsets.only(bottom: 5),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Theme.of(context).colorScheme.sunflowerYellow01,
                    ),
                    child: Text(
                      'Done!',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(color: Theme.of(context).colorScheme.neutralWhite01, fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      NotificationService.showMorningNotification(_timeController.morningTime.value);

                      NotificationService.showAfternoonNotification(_timeController.afternoonTime.value);

                      NotificationService.showEveningNotification(_timeController.eveningTime.value);

                      _settingsController.updateNotificationSettings(
                        newNotificationsEnabled: true,
                        newNotificationsMorningTime: [
                          _timeController.morningTime.value.hour.toString(),
                          _timeController.morningTime.value.minute.toString()
                        ],
                        newNotificationsAfternoonTime: [
                          _timeController.afternoonTime.value.hour.toString(),
                          _timeController.afternoonTime.value.minute.toString()
                        ],
                        newNotificationsEveningTime: [
                          _timeController.eveningTime.value.hour.toString(),
                          _timeController.eveningTime.value.minute.toString()
                        ],
                        newPHQNotificationsEnabled: true,
                        newSIDASNotificationsEnabled: true,
                      );
                      Get.toNamed('/loadingScreen', arguments: {'type': 'both'});
                    }),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).colorScheme.neutralWhite04, width: 1),
                ),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Theme.of(context).colorScheme.neutralWhite01,
                    ),
                    child: Text(
                      "I'll do this later...",
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: Theme.of(context).colorScheme.sunflowerYellow01, fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      Get.toNamed('/loadingScreen', arguments: {'type': 'both'});
                    }),
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}
