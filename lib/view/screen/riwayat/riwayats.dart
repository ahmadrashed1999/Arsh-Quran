import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quranarsh/CURD/curd.dart';
import 'package:quranarsh/view/screen/riwayat/reciters.dart';
import 'package:quranarsh/view/screen/riwayat/surapage.dart';

import '../../../constant/colors.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الروايات',
          style: TextStyle(color: fontColor),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios, color: iconColor)),
        backgroundColor: appBarColor,
      ),
      backgroundColor: primaryColor,
      body: FutureBuilder<dynamic>(
        future: getrequestRe('https://mp3quran.net/api/v3/riwayat', 'riwayat'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => Reciters(
                          reID: snapshot.data[index]['id'].toString(),
                          title: snapshot.data[index]['name'].toString(),
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [cardColor1, cardColor1],
                        )),
                    child: ListTile(
                      title: Text(
                          ' رواية : ${snapshot.data[index]['name'].toString()}',
                          style: TextStyle(color: fontColor)),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Lottie.asset('assets/images/loading.json'));
          }
        },
      ),
    );
  }
}
