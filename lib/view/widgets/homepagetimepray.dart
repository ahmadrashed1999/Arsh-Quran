import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranarsh/Controller/homepagecontroller.dart';
import 'package:quranarsh/constant/colors.dart';

class HomePageTime extends StatelessWidget {
  final HomepagecontrollerImp controller;
  final int index;
  const HomePageTime({Key? key, required this.controller, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ArabicNumbers arabicNumber = ArabicNumbers();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [cardColor1, cardColor1],
          )),
      width: 60,
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            controller.prayerTimesinfo[index]['name'],
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          Text(
            arabicNumber.convert(controller.prayerTimesinfo[index]['time']),
            style: TextStyle(color: fontColor, fontSize: 8),
          ),
        ],
      ),
    );
  }
}
