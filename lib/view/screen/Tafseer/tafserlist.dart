import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranarsh/constant/colors.dart';
import 'package:quranarsh/data/quran.dart';
import 'package:quranarsh/data/tafseer.dart';
import 'package:quranarsh/view/screen/Tafseer/tafseerpage.dart';

class Tafseer extends StatefulWidget {
  Tafseer({Key? key}) : super(key: key);

  @override
  State<Tafseer> createState() => _TafseerState();
}

class _TafseerState extends State<Tafseer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'تفسير الطبري',
            style: TextStyle(color: fontColor),
          ),
          centerTitle: true,
          backgroundColor: appBarColor,
          elevation: 0,
        ),
        backgroundColor: primaryColor,
        body: ListView.separated(
            itemBuilder: (
              context,
              index,
            ) {
              return InkWell(
                onTap: () {
                  // Get.to(TadaborPage(
                  //   data: a[index][0],
                  // ));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [cardColor1, cardColor1],
                      )),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => TafseerPage(
                            list: tafseer['${index + 1}']!,
                            title: '${quran[index]['name']}',
                          ));
                    },
                    child: ListTile(
                      title: Text(
                        'تفسير سورة  :  ${quran[index]['name']}',
                        style: TextStyle(fontSize: 16, color: fontColor),
                      ),
                    ),
                  ),
                ),
              );
            },
            shrinkWrap: true,
            separatorBuilder: (context, index) => const Divider(),
            itemCount: tafseer.length));
  }
}
