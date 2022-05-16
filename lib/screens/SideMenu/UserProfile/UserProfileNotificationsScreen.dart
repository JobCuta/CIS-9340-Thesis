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
  runApp(const GetMaterialApp(home: UserProfileNotificationsScreen()));
}

class UserProfileNotificationsScreen extends StatefulWidget {
  const UserProfileNotificationsScreen({Key? key}) : super(key: key);

  @override
  UserProfileNotificationsScreenState createState() => UserProfileNotificationsScreenState();
}

class UserProfileNotificationsScreenState extends State<UserProfileNotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final TimeController _timeController = Get.put(TimeController());
    final SettingsController _settingsController = Get.put(SettingsController());

    _buildFieldComponent({required label, required timeValue, required enabled, onPressed}) {
      return InkWell(
        splashColor: Theme.of(context).colorScheme.neutralGray02,
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(label,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: enabled
                        ? Theme.of(context).colorScheme.neutralBlack02
                        : Theme.of(context).colorScheme.neutralGray01)),
            GetBuilder<TimeController>(
                builder: (value) => RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: timeValue,
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.neutralGray01)),
                        WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(Icons.keyboard_arrow_right_sharp,
                                size: 30, color: Theme.of(context).colorScheme.neutralGray01))
                      ]),
                    ))
          ]),
        ),
      );
    }

    formatTime(TimeOfDay time) {
      return '${time.hour}:${time.minute}';
    }

    _timeController.morningTime.value = TimeOfDay(
        hour: int.parse(_settingsController.notificationsMorningTime[0]),
        minute: int.parse(_settingsController.notificationsMorningTime[1]));
    _timeController.afternoonTime.value = TimeOfDay(
        hour: int.parse(_settingsController.notificationsAfternoonTime[0]),
        minute: int.parse(_settingsController.notificationsAfternoonTime[1]));
    _timeController.eveningTime.value = TimeOfDay(
        hour: int.parse(_settingsController.notificationsEveningTime[0]),
        minute: int.parse(_settingsController.notificationsEveningTime[1]));
    return WillPopScope(
      onWillPop: () {
        _settingsController.resetAllValues();
        return Future.value(true);
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
          appBar: AppBar(
              elevation: 1,
              leading: BackButton(
                  color: Theme.of(context).colorScheme.accentBlue02,
                  onPressed: () {
                    _settingsController.resetAllValues();
                    Get.back();
                  }),
              backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
              title: Text('Notifications',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.neutralBlack02))),
          primary: true,
          body: Stack(
            children: [
              SafeArea(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                    child: Wrap(children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Text('Show Notifications',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(color: Theme.of(context).colorScheme.neutralBlack02))),
                          Switch.adaptive(
                            value: _settingsController.notificationsEnabled.value,
                            onChanged: (value) {
                              setState(() {
                                _settingsController.notificationsEnabled.value = value;
                              });
                            },
                            activeColor: Theme.of(context).colorScheme.neutralWhite01,
                            activeTrackColor: Theme.of(context).colorScheme.intGreenMain,
                          ),
                        ],
                      ),
                      AbsorbPointer(
                        absorbing: !_settingsController.notificationsEnabled.value,
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
                            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.neutralWhite04,
                                borderRadius: const BorderRadius.all(Radius.circular(8))),
                            child: Text('Set your preferred times for the day for when you want to be notified',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: _settingsController.notificationsEnabled.value
                                        ? Theme.of(context).colorScheme.neutralGray04
                                        : Theme.of(context).colorScheme.neutralGray01)),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: GetBuilder<TimeController>(
                              builder: (value) => Wrap(alignment: WrapAlignment.center, runSpacing: 5, children: [
                                _buildFieldComponent(
                                  label: 'Morning',
                                  timeValue: _timeController.morningTime.value.format(context),
                                  enabled: _settingsController.notificationsEnabled.value,
                                  onPressed: () {
                                    _timeController.selectMorningTime(context: context);
                                  },
                                ),
                                _buildFieldComponent(
                                    label: 'Afternoon',
                                    timeValue: _timeController.afternoonTime.value.format(context),
                                    enabled: _settingsController.notificationsEnabled.value,
                                    onPressed: () {
                                      _timeController.selectAfternoonTime(context: context);
                                    }),
                                _buildFieldComponent(
                                    label: 'Evening',
                                    timeValue: _timeController.eveningTime.value.format(context),
                                    enabled: _settingsController.notificationsEnabled.value,
                                    onPressed: () {
                                      _timeController.selectEveningTime(
                                        context: context,
                                      );
                                    }),
                                Divider(
                                  color: Theme.of(context).colorScheme.neutralWhite03,
                                  height: 25,
                                  thickness: 2,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Text('Show PHQ9 Assessment Notifications',
                                            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                                color: _settingsController.notificationsEnabled.value
                                                    ? Theme.of(context).colorScheme.neutralGray04
                                                    : Theme.of(context).colorScheme.neutralGray01))),
                                    Switch.adaptive(
                                      value: _settingsController.notificationsEnabled.value
                                          ? _settingsController.phqNotificationsEnabled.value
                                          : _settingsController.notificationsEnabled.value,
                                      onChanged: (value) {
                                        setState(() {
                                          _settingsController.phqNotificationsEnabled.value = value;
                                        });
                                      },
                                      activeColor: Theme.of(context).colorScheme.neutralWhite01,
                                      activeTrackColor: Theme.of(context).colorScheme.intGreenMain,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Text('Show SIDAS Assessment Notifications',
                                            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                                color: _settingsController.notificationsEnabled.value
                                                    ? Theme.of(context).colorScheme.neutralGray04
                                                    : Theme.of(context).colorScheme.neutralGray01))),
                                    Switch.adaptive(
                                      value: _settingsController.notificationsEnabled.value
                                          ? _settingsController.sidasNotificationsEnabled.value
                                          : _settingsController.notificationsEnabled.value,
                                      onChanged: (value) {
                                        setState(() {
                                          _settingsController.sidasNotificationsEnabled.value = value;
                                        });
                                      },
                                      activeColor: Theme.of(context).colorScheme.neutralWhite01,
                                      activeTrackColor: Theme.of(context).colorScheme.intGreenMain,
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          ),
                        ]),
                      ),
                    ])),
              ),
              // Save Button
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Theme.of(context).colorScheme.accentBlue02,
                        ),
                        onPressed: () async {
                          String notifID = '';
                          await UserSecureStorage.getNotifID().then((value) => notifID = value.toString());
                          if (notifID.isEmpty || notifID == 'null') {
                            log('notification ID did not exist. Assuming backend ID not saved, saving to backend..');
                            log('time ${formatTime(_timeController.afternoonTime.value)}');
                            Map result = await UserProvider().createNotifs(
                              formatTime(_timeController.morningTime.value),
                              formatTime(_timeController.afternoonTime.value),
                              formatTime(_timeController.eveningTime.value),
                            );
                            if (result.isNotEmpty) {
                              UserSecureStorage.setNotifID(result['id']);
                              log('successfully saved notifs to backend');
                            } else {
                              log('error saving to backend..');
                            }
                          } else {
                            UserProvider().updateNotifs(
                                formatTime(_timeController.morningTime.value),
                                formatTime(_timeController.afternoonTime.value),
                                formatTime(_timeController.eveningTime.value),
                                notifID);
                            log('successfully saved notifs to backend');
                          }

                          _settingsController.updateNotificationSettings(
                            newNotificationsEnabled: _settingsController.notificationsEnabled.value,
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
                            newPHQNotificationsEnabled: _settingsController.phqNotificationsEnabled.value,
                            newSIDASNotificationsEnabled: _settingsController.sidasNotificationsEnabled.value,
                          );

                          if (_settingsController.notificationsEnabled.value) {
                            NotificationService.showMorningNotification(_timeController.morningTime.value);

                            NotificationService.showAfternoonNotification(_timeController.afternoonTime.value);

                            NotificationService.showEveningNotification(_timeController.eveningTime.value);
                            if (_settingsController.phqNotificationsEnabled.value) {
                              NotificationService.showPHQNotification();
                            }
                            if (_settingsController.sidasNotificationsEnabled.value) {
                              NotificationService.showSIDASNotification();
                            }
                          } else {
                            NotificationService.cancelAllNotifications();
                          }
                          Get.snackbar('Edit Notification Settings', 'Your notification settings have been updated.',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.white60,
                              colorText: Colors.black87);
                        },
                        child: Text('Save',
                            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                color: Theme.of(context).colorScheme.neutralWhite01, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  )),
            ],
          )),
    );
  }
}
