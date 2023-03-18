import 'package:flutter_local_notifications/flutter_local_notifications.dart';

sendlocal(var body) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();

// Initialize the plugin
  var initializationSettingsAndroid =
      new AndroidInitializationSettings('@mipmap/ic_launcher');
  var initSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  flutterLocalNotificationsPlugin.initialize(initSettings);
  int interval = 8 * 60 * 60;
// Schedule a notification
  var scheduledNotificationDateTime = DateTime.now().add(Duration(seconds: 5));
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',

    channelDescription: 'aaaaaaaaaaaaaaa',
    // this is the name of the asset file in the `res/drawable` folder
  );
  await flutterLocalNotificationsPlugin.schedule(
    0,
    '❤🦉',
    body,
    scheduledNotificationDateTime,
    NotificationDetails(android: androidPlatformChannelSpecifics),
    payload: 'item x',
  );
}
