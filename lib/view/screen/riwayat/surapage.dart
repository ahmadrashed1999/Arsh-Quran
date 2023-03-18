import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quranarsh/CURD/curd.dart';
import 'package:quranarsh/view/screen/quranpalyaduio.dart';
import 'package:sizer/sizer.dart';

import '../../../constant/colors.dart';
import 'reciters.dart';

class SuraPage extends StatefulWidget {
  const SuraPage(
      {Key? key,
      required this.id,
      required this.moshaf,
      required this.server,
      required this.title})
      : super(key: key);
  final String id;
  final List moshaf;
  final String server;
  final String title;

  @override
  State<SuraPage> createState() => _SuraPageState();
}

class _SuraPageState extends State<SuraPage> {
  TextEditingController textController = TextEditingController();

  List _filteredDataList = [];
  List orgList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    print(widget.server);
  }

  void getData() async {
    orgList = await getrequestRe('https://mp3quran.net/api/v3/suwar', 'suwar');

    orgList.forEach((element) {
      if (widget.moshaf.contains(element["id"].toString())) {
        _filteredDataList.add(element);
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: appBarColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            AnimationSearchBar(
                backIconColor: iconColor,
                searchIconColor: iconColor,
                closeIconColor: iconColor,
                cursorColor: iconColor,
                centerTitle: widget.title,
                centerTitleStyle: TextStyle(
                  color: fontColor,
                  fontSize: 20,
                ),
                searchFieldDecoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.black.withOpacity(.2), width: .5),
                    borderRadius: BorderRadius.circular(15)),
                hintText: '',
                hintStyle: TextStyle(
                  color: fontColor,
                  fontSize: 20,
                ),
                backIcon: Icons.arrow_back_ios,
                onChanged: (text) {
                  setState(() {
                    _filteredDataList = orgList
                        .where((item) => item['name']
                            .toString()
                            .toLowerCase()
                            .contains(text.toLowerCase()))
                        .toList();
                  });
                },
                searchTextEditingController: textController,
                horizontalPadding: 5)
          ],
        ),
        backgroundColor: primaryColor,
        body: _filteredDataList.isEmpty
            ? Center(
                child: Lottie.asset('assets/images/loading.json'),
              )
            : ListView.builder(
                itemCount: _filteredDataList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Reciters(
                      //               reID: widget.id,
                      //             )));
                      String ide = '';
                      if ((_filteredDataList[index]['id']).toString().length ==
                          1) {
                        ide = "00${_filteredDataList[index]['id']}";
                      } else if ((_filteredDataList[index]['id'])
                              .toString()
                              .length ==
                          2) {
                        ide = "0${_filteredDataList[index]['id']}";
                      } else {
                        ide = "${_filteredDataList[index]['id']}";
                      }

                      Get.to(() => QuranPlayPage(
                          server: widget.server,
                          sora_name: _filteredDataList[index]['name']
                              .toString()
                              .replaceAll('\r\n', ''),
                          name: 'name',
                          id: ide,
                          list: []));
                    },
                    child: Container(
                      height: 8.h,
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
                            'سورة : ${_filteredDataList[index]['name'].toString().replaceAll('\r\n', '')}',
                            style: TextStyle(color: fontColor)),
                      ),
                    ),
                  );
                },
              ));
  }
}
