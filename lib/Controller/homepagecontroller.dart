// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer' as developer;

import 'package:adhan/adhan.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlng/latlng.dart';

import '../constant/colors.dart';
import '../main.dart';

abstract class Homepagecontroller extends GetxController {
  getuserlocartion();
}

class HomepagecontrollerImp extends Homepagecontroller {
  // ignore: unused_field
  Color pickerColor = Color(0xff081945);
  Color currentColor = Color(0xff081945);

  void changeColorForBack(Color color) {
    pickerColor = color;
    primaryColor = pickerColor;
    prefs.setInt('backColor', pickerColor.value);
    print(pickerColor);
    update();
  }

  void changeColorForIcons(Color color) {
    pickerColor = color;
    iconColor = pickerColor;
    prefs.setInt('iconColor', pickerColor.value);
    print(pickerColor);
    update();
  }

  void changeColorForCard(Color color) {
    pickerColor = color;
    cardColor1 = pickerColor;
    prefs.setInt('cardColor', pickerColor.value);
    print(pickerColor);
    update();
  }

  void changeColorForAppBar(Color color) {
    pickerColor = color;
    appBarColor = pickerColor;
    prefs.setInt('appBarColor', pickerColor.value);
    print(pickerColor);
    update();
  }

  void changeColorForText(Color color) {
    pickerColor = color;
    fontColor = pickerColor;
    prefs.setInt('textColor', pickerColor.value);
    print(pickerColor);
    update();
  }

  List prayerTimesinfo = [];
  var currentTime = DateFormat.yMd().format(DateTime.now()).toString();
  var currentTimear;
  getDate() async {
    await initializeDateFormatting("ar_SA", null);
    var now = DateTime.now();
    var formatter = DateFormat.yMMMd('ar_SA');

    String formatted = formatter.format(now);
    currentTimear = formatted;
    currentDay = DateFormat.EEEE().format(DateTime.now()).toString();
    switch (currentDay) {
      case 'Monday':
        currentDay = 'الاثنين';
        break;
      case 'Tuesday':
        currentDay = 'الثلاثاء';
        break;
      case 'Wednesday':
        currentDay = 'الاربعاء';
        break;
      case 'Thursday':
        currentDay = 'الخميس';
        break;
      case 'Friday':
        currentDay = 'الجمعة';
        break;
      case 'Saturday':
        currentDay = 'السبت';
        break;
      case 'Sunday':
        currentDay = 'الاحد';
        break;
      default:
    }
    update();
  }

  late var currentDay = DateFormat('EEEE').format(DateTime.now());
  LatLng _center = LatLng(0, 0);
  late Position currentLocation;
  Future getPer() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  @override
  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  getuserlocartion() async {
    currentLocation = await locateUser();

    _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    //  getcityname(_center.latitude, _center.longitude);
    update();
    getPrayerTime();
    print('center ${_center.latitude}');
    print('center ${_center.longitude}');
  }

  getPrayerTime() async {
    print('Kushtia Prayer Times');
    final myCoordinates = Coordinates(_center.latitude,
        _center.longitude); // Replace with your own location lat, lng.
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);

    prayerTimesinfo = [
      {
        'name': 'الفجر',
        'time': DateFormat.Hm().format(prayerTimes.fajr).toString()
      },
      {
        'name': 'الظهر',
        'time': DateFormat.Hm().format(prayerTimes.dhuhr).toString()
      },
      {
        'name': 'العصر',
        'time': DateFormat.Hm().format(prayerTimes.asr).toString()
      },
      {
        'name': 'المغرب',
        'time': DateFormat.Hm().format(prayerTimes.maghrib).toString()
      },
      {
        'name': 'العشاء',
        'time': DateFormat.Hm().format(prayerTimes.isha).toString()
      },
    ];

    update();
  }

  getday() {}

  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus = result;
    update();
  }

  @override
  void onInit() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    // TODO: implement onInit
    super.onInit();
    getPer();
    getday();
    getDate();
    getuserlocartion();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    print(connectionStatus);
  }
}
