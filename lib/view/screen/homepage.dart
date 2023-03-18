import 'dart:async';
import 'dart:math';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';

import 'package:quranarsh/Controller/homepagecontroller.dart';
import 'package:quranarsh/constant/colors.dart';
import 'package:quranarsh/data/notifactions.dart';
import 'package:quranarsh/data/quits.dart';
import 'package:quranarsh/main.dart';
import 'package:quranarsh/test.dart';
import 'package:quranarsh/view/screen/Tafseer/tafserlist.dart';
import 'package:quranarsh/view/screen/mainpage.dart';
import 'package:quranarsh/view/screen/qiblah.dart';

import 'package:quranarsh/view/screen/riwayat/riwayats.dart';
import 'package:quranarsh/view/screen/tadabor.dart';
import 'package:quranarsh/view/screen/azkar.dart';
import 'package:quranarsh/view/screen/hadithpage.dart';
import 'package:quranarsh/view/screen/quranliost.dart';
import 'package:quranarsh/view/screen/settings.dart';
import 'package:quranarsh/view/widgets/azkarcrad.dart';

import 'package:quranarsh/view/widgets/homepagetext.dart';
import 'package:quranarsh/view/widgets/homepagetimepray.dart';
import 'package:sizer/sizer.dart';

import 'choosequrantype.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HijriCalendar _today = HijriCalendar.now();
  @override
  void initState() {
    super.initState();
    // print(_today.toFormat("MMMM dd yyyy")); //Ramadan 14 143
    HijriCalendar.setLocal('ar');
  }

  // ignore: non_constant_identifier_names
  bool SendNoti = true;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    HomepagecontrollerImp controller = Get.put(HomepagecontrollerImp());
    return GetBuilder<HomepagecontrollerImp>(builder: ((controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.to(() => const SettingsPage());
            },
            icon: Icon(
              Icons.settings,
              color: iconColor,
            ),
          ),
          elevation: 0,
          backgroundColor: appBarColor,
          title: Text(
            'آرش قرآن',
            style: TextStyle(color: fontColor),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  SendNoti = !SendNoti;
                });
                if (SendNoti) {
                  prefs.setBool('sentnoti', SendNoti);
                } else {
                  prefs.setBool('sentnoti', SendNoti);
                }
              },
              icon: Icon(
                SendNoti ? Icons.notifications_off : Icons.notifications,
                color: iconColor,
              ),
            ),
            IconButton(
              onPressed: () {
                Get.bottomSheet(Container(
                    padding: EdgeInsets.all(
                      2.h,
                    ),
                    height: 90.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: ListView(
                      children: [
                        const Text('تغيير لون خلفية التطبيق'),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 25.h,
                          child: MaterialPicker(
                            pickerColor: controller.pickerColor,
                            onColorChanged: controller.changeColorForBack,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        const Text('تغيير لون البار العلوي '),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 25.h,
                          child: MaterialPicker(
                            pickerColor: controller.pickerColor,
                            onColorChanged: controller.changeColorForAppBar,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        const Text('تغيير لون الخطوط '),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 25.h,
                          child: MaterialPicker(
                            pickerColor: controller.pickerColor,
                            onColorChanged: controller.changeColorForText,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        const Text('تغيير لون الأيقونات'),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          height: 25.h,
                          child: MaterialPicker(
                            pickerColor: controller.pickerColor,
                            onColorChanged: controller.changeColorForIcons,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        const Text('تغيير لون البطاقات'),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          height: 25.h,
                          child: MaterialPicker(
                              pickerColor: controller.pickerColor,
                              onColorChanged: controller.changeColorForCard),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),

                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // Text('تغيير لون الخلفية'),
                      ],
                    )));
              },
              icon: Icon(
                Icons.color_lens,
                color: iconColor,
              ),
            ),
          ],
        ),
        backgroundColor: primaryColor,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 17.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/backgroundp.jpg'),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    height: 17.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: HomePageText(
                            text:
                                '${controller.currentDay}\n${controller.currentTimear}',
                          ),
                        ),
                        Center(
                          child: HomePageText(
                            text: _today.toFormat("yyyy / MMMM /  dd "),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 80,
                child: controller.prayerTimesinfo.isEmpty
                    ? Container()
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          return HomePageTime(controller: controller, index: i);
                        },
                        itemCount: controller.prayerTimesinfo.length,
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: AzkarPageCard(
                            text: 'القرآن الكريم',
                            image: 'assets/images/quran.png',
                            onTap: () {
                              Get.to(() => const ChooseQuranPage());
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: AzkarPageCard(
                            text: 'إستمع للقرآن',
                            image: 'assets/images/koran.png',
                            onTap: () {
                              Get.to(() => const RiwayatPage());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: AzkarPageCard(
                            text: 'الأذكار',
                            image: 'assets/images/azkar.png',
                            onTap: () {
                              Get.to(() => const Azkar());
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: AzkarPageCard(
                            text: 'تفسير القرآن',
                            image: 'assets/images/tafseer.png',
                            onTap: () {
                              Get.to(() => Tafseer());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: AzkarPageCard(
                            text: 'الأربعون النووية',
                            image: 'assets/images/decoration.png',
                            onTap: () {
                              Get.to(() => hadithPage());
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: AzkarPageCard(
                            text: 'تدبر',
                            image: 'assets/images/read.png',
                            onTap: () {
                              Get.to(() => Tadabor());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              )),
            ],
          ),
        ),
      );
    }));
  }
}
