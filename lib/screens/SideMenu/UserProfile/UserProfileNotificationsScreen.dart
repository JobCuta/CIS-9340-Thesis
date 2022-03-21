import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';

import '../../../constants/notificationService.dart';
import '../../../controllers/timeController.dart';

void main() {
  runApp(const GetMaterialApp(home: UserProfileNotificationsScreen()));
}

class UserProfileNotificationsScreen extends StatefulWidget {
  const UserProfileNotificationsScreen({Key? key}) : super(key: key);

  @override
  UserProfileNotificationsScreenState createState() =>
      UserProfileNotificationsScreenState();
}

class UserProfileNotificationsScreenState
    extends State<UserProfileNotificationsScreen> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final TimeController _timeController = Get.put(TimeController());

    _buildFieldComponent(
        {required label, required timeValue, required enabled, onPressed}) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.w400,
                color: enabled
                    ? Theme.of(context).colorScheme.neutralBlack02
                    : Theme.of(context).colorScheme.neutralGray01)),
        TextButton(
            onPressed: onPressed,
            child: GetBuilder<TimeController>(
                builder: (value) => RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: timeValue,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralGray01)),
                        WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(Icons.keyboard_arrow_right_sharp,
                                size: 30,
                                color: Theme.of(context)
                                    .colorScheme
                                    .neutralGray01))
                      ]),
                    )))
      ]);
    }

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
        appBar: AppBar(
            elevation: 1,
            leading: BackButton(
                color: Theme.of(context).colorScheme.accentBlue02,
                onPressed: () {
                  if (isSwitched) {
                    NotificationService.showMorningNotification(
                        _timeController.morningTime.value);

                    NotificationService.showAfternoonNotification(
                        _timeController.afternoonTime.value);

                    NotificationService.showEveningNotification(
                        _timeController.eveningTime.value);
                  } else {
                    NotificationService.cancelAllNotifications();
                  }
                  Get.back();
                }),
            backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
            title: Text('Notifications',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.neutralBlack02))),
        primary: true,
        body: Stack(
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                child: Wrap(children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Text('Show Notifications',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralBlack02))),
                      Switch.adaptive(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeColor:
                            Theme.of(context).colorScheme.neutralWhite01,
                        activeTrackColor:
                            Theme.of(context).colorScheme.intGreenMain,
                      ),
                    ],
                  ),
                  AbsorbPointer(
                    absorbing: !isSwitched,
                    child: Column(children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Divider(
                          color: Theme.of(context).colorScheme.neutralWhite03,
                          height: 25,
                          thickness: 2,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 25.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.neutralWhite04,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: Text(
                            'Set your preferred times for the day for when you want to be notified',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: isSwitched
                                        ? Theme.of(context)
                                            .colorScheme
                                            .neutralGray04
                                        : Theme.of(context)
                                            .colorScheme
                                            .neutralGray01)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: GetBuilder<TimeController>(
                          builder: (value) => Wrap(
                              alignment: WrapAlignment.center,
                              runSpacing: 5,
                              children: [
                                _buildFieldComponent(
                                  label: 'Morning',
                                  timeValue: _timeController.morningTime.value
                                      .format(context),
                                  enabled: isSwitched,
                                  onPressed: () {
                                    _timeController.selectMorningTime(context);
                                  },
                                ),
                                _buildFieldComponent(
                                    label: 'Afternoon',
                                    timeValue: _timeController
                                        .afternoonTime.value
                                        .format(context),
                                    enabled: isSwitched,
                                    onPressed: () {
                                      _timeController
                                          .selectAfternoonTime(context);
                                    }),
                                _buildFieldComponent(
                                    label: 'Evening',
                                    timeValue: _timeController.eveningTime.value
                                        .format(context),
                                    enabled: isSwitched,
                                    onPressed: () {
                                      _timeController
                                          .selectEveningTime(context);
                                    })
                              ]),
                        ),
                      )
                    ]),
                  ),
                ])),
            // Save Button
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: isSwitched
                              ? Theme.of(context).colorScheme.accentBlue02
                              : Theme.of(context).colorScheme.neutralWhite04),
                      onPressed: () {},
                      child: Text('Save',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralWhite01,
                                  fontWeight: FontWeight.w600)),
                    ),
                  ),
                )),
          ],
        ));
  }
}
