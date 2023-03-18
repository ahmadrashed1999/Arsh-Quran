import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quranarsh/Controller/settingscontroller.dart';
import 'package:quranarsh/constant/colors.dart';
import 'package:quranarsh/data/full_with_tafseer/quran.dart';
import 'package:quranarsh/data/quran_en%20(2).dart';
import 'package:quranarsh/main.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';

import '../../data/full_with_tafseer/tafseer.dart';
import '../../data/quran.dart';

final ItemScrollController itemScrollController = ItemScrollController();
final ItemPositionsListener itemPositionsListener =
    ItemPositionsListener.create();

// ignore: must_be_immutable
class Surah extends StatefulWidget {
  final int index;
  Surah({Key? key, required this.index}) : super(key: key);
  @override
  State<Surah> createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  SettingscontrollerImpl controller = Get.put(SettingscontrollerImpl());

  @override
  Widget build(BuildContext context) {
    ArabicNumbers arabicNumber = ArabicNumbers();
    List<Map> surah = holyQuran[widget.index]['ayahs'];
    var id = quranEn[widget.index]['id'];
    return GetBuilder<SettingscontrollerImpl>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'سورة ${quranEn[widget.index]['name']}',
            style: TextStyle(color: fontColor),
          ),
          centerTitle: true,
          backgroundColor: appBarColor,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: iconColor,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                controller.changestyle();
              },
              icon: Icon(
                Icons.all_inbox_outlined,
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
                        const Text('تغيير لون خلفية القراء'),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 30.h,
                          child: MaterialPicker(
                            pickerColor: controller.pickerColor,
                            onColorChanged: controller.changeColorForBack,
                          ),
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
        backgroundColor: quranBackColor,
        body: !controller.fabIsClicked
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ScrollablePositionedList.builder(
                  itemCount: surah.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.changeSave(index, id - 1);
                          Get.snackbar('تم حفظ الاية',
                              'سورة : ${quranEn[widget.index]['name']} \nآية:  ${arabicNumber.convert(index + 1)}\n تم اضافة مرجعية للآية',
                              duration: const Duration(seconds: 1),
                              colorText: Colors.black,
                              backgroundColor: Colors.white.withOpacity(0.8),
                              icon: const Icon(
                                Icons.check,
                                size: 30,
                                color: Colors.green,
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            holyQuran[widget.index]['ayahs'][index]['text'] +
                                " " +
                                "\uFD3F${arabicNumber.convert(index + 1)}\uFD3E",
                            style: TextStyle(
                              fontFamily: 'Amiri',
                              fontSize: controller.fontsize,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      controller.isEnglish
                          ? GestureDetector(
                              onTap: () {
                                controller.changeSave(index, id - 1);
                                Get.snackbar(
                                    'تم حفظ الاية', 'تم اضافة مرجعية للآية',
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
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  surah[index]['translation'],
                                  style: TextStyle(
                                    fontFamily: 'Amiri',
                                    fontSize: prefs.getDouble('fontSize') ?? 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                    ],
                  ),
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                ),
              )
            : SafeArea(
                minimum: const EdgeInsets.all(30),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          RichText(
                            textAlign: quranEn.length <= 20
                                ? TextAlign.center
                                : TextAlign.justify,
                            text: TextSpan(
                              children: [
                                for (var i = 1; i <= surah.length; i++) ...{
                                  TextSpan(
                                    text: ' '
                                        '${holyQuran[widget.index]['ayahs'][i - 1]['text']}'
                                        ' ',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.bottomSheet(Container(
                                            padding: EdgeInsets.all(20),
                                            height: 70.h,
                                            color: quranBackColor,
                                            child: ListView(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'تفسير هذه الآية',
                                                      style: TextStyle(
                                                          fontFamily: 'Amiri',
                                                          fontSize: 20,
                                                          color: Colors.black),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      icon: const Icon(
                                                        Icons.close,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                RichText(
                                                  textAlign:
                                                      quranEn.length <= 20
                                                          ? TextAlign.center
                                                          : TextAlign.justify,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            '${holyQuran[widget.index]['ayahs'][i - 1]['text']} ',
                                                        style: TextStyle(
                                                            fontFamily: 'Amiri',
                                                            fontSize: controller
                                                                .fontsize,
                                                            color: Colors.black,
                                                            height: 3.5),
                                                      ),
                                                      WidgetSpan(
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .middle,
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                'assets/images/Ayah.svg',
                                                                width: (controller
                                                                            .fontsize -
                                                                        5) *
                                                                    2,
                                                                height:
                                                                    (controller.fontsize -
                                                                            5) *
                                                                        2,
                                                              ),
                                                              Text(
                                                                arabicNumber
                                                                    .convert(i),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Amiri',
                                                                  fontSize:
                                                                      (controller
                                                                              .fontsize -
                                                                          5),
                                                                ),
                                                              ),
                                                            ],
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 2,
                                                ),
                                                Text(
                                                  '${tafseerList[widget.index]['ayahs'][i - 1]['text']} ',
                                                  style: TextStyle(
                                                    fontFamily: 'Amiri',
                                                    fontSize:
                                                        controller.fontsize,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            )));
                                      },
                                    style: TextStyle(
                                        fontFamily: 'Amiri',
                                        fontSize: controller.fontsize,
                                        color: Colors.black,
                                        height: 3.5),
                                  ),
                                  WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/Ayah.svg',
                                            width:
                                                (controller.fontsize - 5) * 2,
                                            height:
                                                (controller.fontsize - 5) * 2,
                                          ),
                                          Text(
                                            arabicNumber.convert(i),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Amiri',
                                              fontSize: controller.fontsize - 5,
                                            ),
                                          ),
                                        ],
                                      ))
                                }
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      );
    });
  }

  void scrollTo(int index) {
    if ((quranEn[widget.index]['id'] - 1) == prefs.getInt('surah')) {
      if (itemScrollController.isAttached) {
        itemScrollController.scrollTo(
          index: index,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOutCubic,
        );
      }
    }
  }

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollTo(prefs.getInt('index') ?? 0);
    });

    super.initState();
  }
}


// ListView(children: [
            // Padding(
            //   padding: EdgeInsets.all(5),
            //   child: header(),
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // RichText(
            //   textAlign: count <= 20 ? TextAlign.center : TextAlign.justify,
            //   text: TextSpan(
            //     children: [
            //       for (var i = 1; i <= count; i++) ...{
            //         TextSpan(
            //           text: ' ' +
            //               quran.getVerse(index, i, verseEndSymbol: false) +
            //               ' ',
            //           style: TextStyle(
            //             fontFamily: 'Kitab',
            //             fontSize: 25,
            //             color: Colors.black87,
            //           ),
            //         ),
            //         WidgetSpan(
            //             alignment: PlaceholderAlignment.middle,
            //             child: CircleAvatar(
            //               child: Text(
            //                 '$i',
            //                 textAlign: TextAlign.center,
            //                 textScaleFactor: i.toString().length <= 2 ? 1 : .8,
            //               ),
            //               radius: 14,
            //             ))
            //       }
            //     ],
            //   ),
            // ),
            