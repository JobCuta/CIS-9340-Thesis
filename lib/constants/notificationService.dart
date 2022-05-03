import 'package:flutter_application_1/apis/phqHive.dart';
import 'package:flutter_application_1/apis/sidasHive.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

late Box phqBox;
late Box sidasBox;
late DateTime nextPHQ;
late DateTime nextSIDAS;
late String timezone;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    initializeLocalNotificationsPlugin(initializationSettings);

    tz.initializeTimeZones();
    timezone = timezone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezone));
    print(timezone);
    print(tz.local);

    phqBox = Hive.box('phq');
    sidasBox = Hive.box('sidas');
    if (phqBox.isNotEmpty) {
      var monthKey = phqBox.keys.last;
      var latestEntry = phqBox.get(monthKey);
      var p = latestEntry as phqHive;
      var pDate = DateTime(p.date.year, p.date.month, p.date.day);
      nextPHQ = pDate.add(const Duration(days: 14));
    }
    if (sidasBox.isNotEmpty) {
      var monthKey = sidasBox.keys.last;
      var latestEntry = sidasBox.get(monthKey);
      var s = latestEntry as sidasHive;
      nextSIDAS = DateTime(s.date.year, s.date.month + 1, s.date.day);
    }
  }

  void initializeLocalNotificationsPlugin(
      InitializationSettings initializationSettings) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) {
      // Get.toNamed('/homepage');
    });
  }

  static void showNotification() async {
    await flutterLocalNotificationsPlugin.show(
        123,
        'Kasiyanna',
        'This is a test notification.',
        const NotificationDetails(
            android: AndroidNotificationDetails('123', 'Kasiyanna',
                channelDescription: 'To remind you about stuff')),
        payload: 'load');
  }

  static void showScheduledNotification(time) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        12345,
        "Kasiyanna",
        "This notification is a scheduled reminder",
        tz.TZDateTime.from(time, tz.local),
        const NotificationDetails(
            android: AndroidNotificationDetails('123', 'Kasiyanna',
                channelDescription: 'To remind you about stuff, scheduled')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  static Future<void> showMorningNotification(time) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        "Kasiyanna",
        "Hey there! It's time for your morning entry",
        _nextInstanceOfMorningTime(time),
        const NotificationDetails(
            android: AndroidNotificationDetails('1', 'Morning Reminder',
                channelDescription:
                    'Reminds the user to do their morning entry.')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  static tz.TZDateTime _nextInstanceOfMorningTime(time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  static Future<void> showAfternoonNotification(time) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        "Kasiyanna",
        "Hey there! It's time for your afternoon entry",
        _nextInstanceOfAfternoonTime(time),
        const NotificationDetails(
            android: AndroidNotificationDetails('2', 'Afternoon Reminder',
                channelDescription:
                    'Reminds the user to do their afternoon entry.')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  static tz.TZDateTime _nextInstanceOfAfternoonTime(time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  static Future<void> showEveningNotification(time) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        3,
        "Kasiyanna",
        "Hey there! It's time for your evening entry",
        _nextInstanceOfEveningTime(time),
        const NotificationDetails(
            android: AndroidNotificationDetails('3', 'Evening Reminder',
                channelDescription:
                    'Reminds the user to do their evening entry.')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  static tz.TZDateTime _nextInstanceOfEveningTime(time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  static Future<void> showPHQNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        "Kasiyanna",
        "Hey there! It's time for your PHQ-9 entry",
        _nextInstanceOfPHQEntry(),
        const NotificationDetails(
            android: AndroidNotificationDetails('1', 'PHQ-9 Reminder',
                channelDescription:
                    'Reminds the user to do their PHQ-9 entry.')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  static tz.TZDateTime _nextInstanceOfPHQEntry() {
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, nextPHQ.year, nextPHQ.month, nextPHQ.day, 12, 30);
    print('PHQ: $scheduledDate');
    return scheduledDate;
  }

  static Future<void> showSIDASNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        "Kasiyanna",
        "Hey there! It's time for your SIDAS entry",
        _nextInstanceOfSIDASEntry(),
        const NotificationDetails(
            android: AndroidNotificationDetails('1', 'SIDAS Reminder',
                channelDescription:
                    'Reminds the user to do their SIDAS entry.')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  static tz.TZDateTime _nextInstanceOfSIDASEntry() {
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, nextSIDAS.year, nextSIDAS.month, nextSIDAS.day, 12, 30);
    print('SIDAS: $scheduledDate');

    return scheduledDate;
  }

  static Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
