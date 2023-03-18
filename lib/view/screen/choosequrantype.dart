import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranarsh/test.dart';
import 'package:quranarsh/view/screen/quranliost.dart';

import '../../constant/colors.dart';
import '../widgets/azkarcrad.dart';

class ChooseQuranPage extends StatelessWidget {
  const ChooseQuranPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'إختر',
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
          child: Column(
            children: [
              Spacer(),
              SizedBox(
                height: 100,
                child: AzkarPageCard(
                  text: 'القران مع  التفسير',
                  image: 'assets/images/quran.png',
                  onTap: () {
                    Get.to(Quran());
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 100,
                child: AzkarPageCard(
                  text: 'القرآن العادي',
                  image: 'assets/images/quran.png',
                  onTap: () {
                    Get.to(Test());
                  },
                ),
              ),
              Spacer()
            ],
          ),
        ));
  }
}
