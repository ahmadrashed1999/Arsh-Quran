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

import '../../data/hadith.dart';

class hadithPage extends StatelessWidget {
  hadithPage({Key? key}) : super(key: key);
  AzkarPageControllerImpl controller = Get.put(AzkarPageControllerImpl());
  var hadith_list = hadith;
  ArabicNumbers arabicNumber = ArabicNumbers();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text('احاديث نووية', style: TextStyle(color: fontColor)),
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
                      color: primaryColor),
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
                                  arabicNumber.convert(i + 1).toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                            AzkarWidget(
                              iconData: Icons.share,
                              onTap: () async {
                                await Share.share(
                                    hadith_list[i]['hadith'].toString(),
                                    subject: 'قم بمشاركة الأذكار');
                              },
                            ),
                            AzkarWidget(
                              iconData: Icons.copy,
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                    text: hadith_list[i]['hadith']));
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
                          hadith_list[i]['hadith'] ?? '',
                          style: TextStyle(
                              fontSize: 20, color: fontColor, height: 2),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GetBuilder<AzkarPageControllerImpl>(
                          builder: (controller) {
                        return controller.show
                            ? ElevatedButton(
                                onPressed: () {
                                  controller.updateShow();
                                },
                                child: const Text('إخفاء شرح الحديث'),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  controller.updateShow();
                                },
                                child: const Text('عرض شرح الحديث'),
                              );
                      }),

                      const Divider(
                        color: Colors.white,
                      ),
                      GetBuilder<AzkarPageControllerImpl>(
                        builder: (controller) {
                          return controller.show
                              ? Text(
                                  hadith_list[i]['description'] ?? '',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: fontColor.withOpacity(0.8),
                                      height: 2),
                                )
                              : Container();
                        },
                      ),
                      //     ? Container()
                      //     : Padding(
                      //         padding:
                      //             const EdgeInsets.symmetric(horizontal: 10),
                      //         child: Text(
                      //           azkar[i]['bless'],
                      //           style: const TextStyle(
                      //               fontSize: 12,
                      //               color: Colors.white,
                      //               height: 2),
                      //         ),
                      //       ),
                      // azkar[i]['bless'] == null || azkar[i]['bless'] == ''
                      //     ? Container()
                      //     : const Divider(
                      //         color: Colors.white,
                      //       ),
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
            itemCount: hadith_list.length));
  }
}
