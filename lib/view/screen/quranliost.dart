import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranarsh/main.dart';
import 'package:quranarsh/view/screen/surah.dart';

import '../../constant/colors.dart';
import '../../data/quran.dart';

class Quran extends StatelessWidget {
  const Quran({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ArabicNumbers arabicNumber = ArabicNumbers();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "القران الكريم",
          style: TextStyle(color: fontColor),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios, color: iconColor)),
        backgroundColor: appBarColor,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(Surah(
                  index: prefs.getInt('surah') ?? 1,
                ));
              },
              icon: Icon(
                Icons.bookmark,
                color: iconColor,
              ))
        ],
      ),
      backgroundColor: primaryColor,
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: quran.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(Surah(
                    index: index,
                  ));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [cardColor1, cardColor1],
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            "assets/images/clip.png",
                            width: 50,
                            height: 50,
                          ),
                          Text(
                            arabicNumber.convert(index + 1).toString(),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text("${quran[index]['name']}",
                              style: TextStyle(
                                fontSize: 20,
                                color: fontColor,
                              )),
                          Text(
                            "${arabicNumber.convert(quran[index]['total_verses'])} آية",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: fontColor.withOpacity(0.7)),
                          ),
                          quran[index]['type'] == 'meccan'
                              ? const Text("مكية")
                              : const Text("مدنية")
                        ],
                      ),
                      Text(
                        "${quran[index]['transliteration']}",
                        style: TextStyle(fontSize: 20, color: fontColor),
                      ),
                    ],
                  ),
                ),
              );
              // return Card(
              //   color: Color(0xff081945),
              //   child: ListTile(
              //     title: Text(quran[index]['name'],
              //         style: TextStyle(color: Colors.white)),
              //     subtitle: Text(quran[index]['transliteration'],
              //         style: TextStyle(color: Colors.white)),
              //     trailing: Text(
              //         'آياتها : ' + quran[index]['total_verses'].toString(),
              //         style: TextStyle(color: Colors.white)),
              //     onTap: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => Surah(
              //                     index: index,
              //                   )));
              //     },
              //   ),
              // );
            }),
      ),
    );
  }
}
