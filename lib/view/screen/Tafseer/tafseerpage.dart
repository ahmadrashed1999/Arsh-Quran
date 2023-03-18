import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranarsh/constant/colors.dart';
import 'package:quranarsh/view/screen/Tafseer/tafseerplaying.dart';

class TafseerPage extends StatelessWidget {
  const TafseerPage({Key? key, required this.list, required this.title})
      : super(key: key);
  final List<Map<String, Object>> list;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تفسير سورة : $title',
          style: TextStyle(color: fontColor),
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      cardColor1,
                      cardColor1,
                    ],
                  )),
              child: InkWell(
                onTap: () {
                  Get.to(() => TafseerPlayingPage(
                      server: list[index]['url'].toString(),
                      name: '${list[index]['name']}'));
                },
                child: ListTile(
                  title: Text(
                    '${list[index]['name']}',
                    style: TextStyle(fontSize: 16, color: fontColor),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: list.length),
    );
  }
}
