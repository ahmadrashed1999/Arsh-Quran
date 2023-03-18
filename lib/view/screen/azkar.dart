import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranarsh/constant/colors.dart';
import 'package:quranarsh/data/azkar.dart';
import 'package:quranarsh/view/screen/azcarpage.dart';
import 'package:quranarsh/view/widgets/azkarcrad.dart';

class Azkar extends StatelessWidget {
  const Azkar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'أذكار',
          style: TextStyle(color: fontColor),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios, color: iconColor)),
        backgroundColor: appBarColor,
      ),
      backgroundColor: primaryColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            SizedBox(
              height: 100,
              child: AzkarPageCard(
                text: 'اذكار الصباح ',
                image: 'assets/images/dua.png',
                onTap: () {
                  Get.to(AzkarPage(
                    title: 'اذكار الصباح ',
                    azkar: azkarsabah,
                  ));
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 100,
              child: AzkarPageCard(
                text: 'اذكار المساء ',
                image: 'assets/images/dua.png',
                onTap: () {
                  Get.to(AzkarPage(
                    title: 'اذكار المساء ',
                    azkar: azkarmasaa,
                  ));
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 100,
              child: AzkarPageCard(
                text: 'اذكار بعد الصلاة ',
                image: 'assets/images/dua.png',
                onTap: () {
                  Get.to(AzkarPage(
                    title: 'اذكار بعد الصلاة ',
                    azkar: azkarafter,
                  ));
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 100,
              child: AzkarPageCard(
                text: 'اذكار الاستيقاظ  ',
                image: 'assets/images/dua.png',
                onTap: () {
                  Get.to(AzkarPage(
                    title: 'اذكار الاستيقاظ ',
                    azkar: azkarwake,
                  ));
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 100,
              child: AzkarPageCard(
                text: 'اذكار النوم ',
                image: 'assets/images/dua.png',
                onTap: () {
                  Get.to(AzkarPage(
                    title: 'اذكار النوم ',
                    azkar: sleepAzkar,
                  ));
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 100,
              child: AzkarPageCard(
                text: 'أدعية الانبياء',
                image: 'assets/images/dua.png',
                onTap: () {
                  Get.to(AzkarPage(
                    title: 'أدعية الانبياء',
                    azkar: poghetsPrayers,
                  ));
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 100,
              child: AzkarPageCard(
                text: "أدعية قرآنية",
                image: 'assets/images/dua.png',
                onTap: () {
                  Get.to(AzkarPage(
                    title: "أدعية قرآنية",
                    azkar: sleepAzkar,
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
