import 'dart:async';
import 'dart:math';

import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quranarsh/constant/colors.dart';
import 'package:quranarsh/view/screen/mainpage.dart';
import 'package:quranarsh/view/screen/tadabor.dart';
import 'package:quranarsh/view/screen/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:workmanager/workmanager.dart';

import 'data/notifactions.dart';
import 'data/quits.dart';

const fetchBackground = "fetchBackground";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackground:
        if (prefs.getBool('sendnoti') ?? true) {
          int randomNumber = Random().nextInt(qoutes.length);
          sendlocal(qoutes[randomNumber]);
        }
        break;
    }
    return Future.value(true);
  });
}

late SharedPreferences prefs;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );
  await Workmanager().registerPeriodicTask(
    "1",
    fetchBackground,
    frequency: const Duration(hours: 8),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
  int randomNumber = Random().nextInt(qoutes.length);
  sendlocal(qoutes[randomNumber]);

  prefs = await SharedPreferences.getInstance();
  checkColor();
  runApp(const MyApp());
}

void checkColor() {
  if (prefs.getInt('backColor') != null) {
    primaryColor = Color(prefs.getInt('backColor')!);
  }
  if (prefs.getInt('iconColor') != null) {
    iconColor = Color(prefs.getInt('iconColor')!);
  }
  if (prefs.getInt('cardColor') != null) {
    cardColor1 = Color(prefs.getInt('cardColor')!);
  }
  if (prefs.getInt('appBarColor') != null) {
    appBarColor = Color(prefs.getInt('appBarColor')!);
  }
  if (prefs.getInt('textColor') != null) {
    fontColor = Color(prefs.getInt('textColor')!);
  }
  if (prefs.getInt('quranBackColor') != null) {
    quranBackColor = Color(prefs.getInt('quranBackColor')!);
  }
}

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) {
//     // initialise the plugin of flutterlocalnotifications.
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.requestPermission();

//     // Initialize the plugin
//     var initializationSettingsAndroid =
//         new AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initSettings =
//         InitializationSettings(android: initializationSettingsAndroid);
//     flutterLocalNotificationsPlugin.initialize(initSettings);

//     var scheduledNotificationDateTime =
//         DateTime.now().add(Duration(seconds: 5));
//     var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//       'your channel id',
//       'your channel name',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',

//       channelDescription: 'aaaaaaaaaaaaaaa',
//       // this is the name of the asset file in the `res/drawable` folder
//     );
//     flutterLocalNotificationsPlugin.schedule(
//       0,
//       '❤🦉',
//       qoutes[Random().nextInt(qoutes.length)],
//       scheduledNotificationDateTime,
//       NotificationDetails(android: androidPlatformChannelSpecifics),
//       payload: 'item x',
//     );

//     return Future.value(true);
//   });
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('ar'),
          title: 'طريق الحياة',
          theme: ThemeData(
            fontFamily: 'Amiri',
            primarySwatch: Colors.blue,
          ),
          home: AnimatedSplashScreen(
            splashIconSize: 300,
            splash: Lottie.asset('assets/images/splash.json',
                width: 500, height: 500),
            nextScreen: MainPage(),
            splashTransition: SplashTransition.rotationTransition,
          ));
    });
  }
}
