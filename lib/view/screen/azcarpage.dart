import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quranarsh/Controller/azkarpagecontroller.dart';
import 'package:quranarsh/constant/colors.dart';
import 'package:quranarsh/view/widgets/azkarbutton.dart';
import 'package:quranarsh/view/widgets/azkariconwid.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class AzkarPage extends StatelessWidget {
  final List azkar;
  final String title;
  const AzkarPage({Key? key, required this.azkar, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AzkarPageControllerImpl azkarPageControllerImpl =
        Get.put(AzkarPageControllerImpl());
    ArabicNumbers arabicNumbers = ArabicNumbers();

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            title,
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
        body: ListView.separated(
            itemBuilder: (c, i) {
              ScreenshotController scrollController$i = ScreenshotController();
              return Screenshot(
                controller: scrollController$i,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor.withOpacity(.8)),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/clip.png',
                                  width: 40,
                                  height: 40,
                                ),
                                Text(
                                  arabicNumbers.convert(i + 1),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.withOpacity(0.2)),
                              child: Text(
                                  'عدد التكرارات : ${arabicNumbers.convert(azkar[i]['repeat'].toString())}',
                                  style: TextStyle(
                                      color: fontColor, fontSize: 14)),
                            ),
                            AzkarWidget(
                              iconData: Icons.share,
                              onTap: () async {
                                await Share.share(azkar[i]['zekr'].toString(),
                                    subject: 'قم بمشاركة الأذكار');
                              },
                            ),
                            AzkarWidget(
                              iconData: Icons.copy,
                              onTap: () {
                                Clipboard.setData(
                                    ClipboardData(text: azkar[i]['zekr']));
                                Get.snackbar('تم النسخ', 'تم نسخ الاذكار بنجاح',
                                    duration: const Duration(seconds: 1),
                                    colorText: Colors.black,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.8),
                                    icon: const Icon(
                                      Icons.check,
                                      size: 30,
                                      color: Colors.green,
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          azkar[i]['zekr'],
                          style: TextStyle(
                              fontSize: 18, color: fontColor, height: 2),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      azkar[i]['bless'] == null || azkar[i]['bless'] == ''
                          ? Container()
                          : const Divider(
                              color: Colors.white,
                            ),
                      azkar[i]['bless'] == null || azkar[i]['bless'] == ''
                          ? Container()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                azkar[i]['bless'],
                                style: TextStyle(
                                    fontSize: 12,
                                    color: fontColor.withOpacity(0.8),
                                    height: 2),
                              ),
                            ),
                      azkar[i]['bless'] == null || azkar[i]['bless'] == ''
                          ? Container()
                          : const Divider(
                              color: Colors.white,
                            ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (c, i) {
              return const Divider(
                thickness: 3,
                color: Colors.white,
              );
            },
            itemCount: azkar.length));
  }
}
