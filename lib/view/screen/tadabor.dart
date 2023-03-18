import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quranarsh/CURD/curd.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:quranarsh/constant/colors.dart';
import 'package:quranarsh/view/screen/tadborpage.dart';

class Tadabor extends StatefulWidget {
  Tadabor({Key? key}) : super(key: key);

  @override
  State<Tadabor> createState() => _TadaborState();
}

class _TadaborState extends State<Tadabor> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(getrequest('https://mp3quran.net/api/v3/tadabor?language=ar')
        .toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('تدبر',
              style: TextStyle(
                color: fontColor,
              )),
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
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  FutureBuilder(
                    future: getrequest(
                        'https://mp3quran.net/api/v3/tadabor?language=ar'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final restaurant = snapshot.data as Map;
                        List a = [];
                        restaurant.forEach(
                          (key, value) => {
                            a.add(value),
                            // print(key),
                            // print(value),
                          },
                        );

                        return ListView.separated(
                            itemBuilder: (
                              context,
                              index,
                            ) {
                              return InkWell(
                                onTap: () {
                                  Get.to(TadaborPage(
                                    data: a[index][0],
                                  ));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 20),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [cardColor1, cardColor1],
                                      )),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ListTile(
                                        title: Text(
                                          'اسم السورة :  ${a[index][0]['sora_name'].toString().replaceAll("\r\n", "")}',
                                          style: TextStyle(
                                              fontSize: 16, color: fontColor),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'رواية : ${a[index][0]['rewaya_name']}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: fontColor),
                                            ),
                                            Text(
                                              'القارئ : ${a[index][0]['reciter_name']} ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: fontColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          '${a[index][0]['text'].toString().replaceAll("<p>", "").replaceAll("</p>", "").replaceAll("&quot;", "")} ',
                                          style: TextStyle(
                                              fontSize: 12, color: fontColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: a.length);
                      } else {
                        return Center(
                            child: Lottie.asset('assets/images/loading.json'));
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
