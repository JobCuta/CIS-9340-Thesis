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
}
