import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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
        "This notification is a scheduled reminder (Morning)",
        _nextInstanceOfMorningTime(time),
        const NotificationDetails(
            android: AndroidNotificationDetails('1', 'Kasiyanna',
                channelDescription: 'To remind you about stuff, scheduled')),
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
        "This notification is a scheduled reminder (Afternoon)",
        _nextInstanceOfAfternoonTime(time),
        const NotificationDetails(
            android: AndroidNotificationDetails('2', 'Kasiyanna',
                channelDescription: 'To remind you about stuff, scheduled')),
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
        "This notification is a scheduled reminder (Evening)",
        _nextInstanceOfEveningTime(time),
        const NotificationDetails(
            android: AndroidNotificationDetails('3', 'Kasiyanna',
                channelDescription: 'To remind you about stuff, scheduled')),
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
}
