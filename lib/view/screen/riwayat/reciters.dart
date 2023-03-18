import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quranarsh/CURD/curd.dart';
import 'package:quranarsh/constant/colors.dart';
import 'package:quranarsh/view/screen/riwayat/surapage.dart';

class Reciters extends StatefulWidget {
  const Reciters({Key? key, required this.reID, required this.title})
      : super(key: key);

  final String reID;
  final String title;

  @override
  State<Reciters> createState() => _RecitersState();
}

class _RecitersState extends State<Reciters> {
  TextEditingController textController = TextEditingController();
  List _filteredDataList = [];
  List orgList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    orgList = await getrequestRe(
        'https://www.mp3quran.net/api/v3/reciters?rewaya=${widget.reID}',
        'reciters');
    _filteredDataList = orgList;
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
                    var moshaf = _filteredDataList[index]['moshaf'][0];
                    var listof = moshaf['surah_list'].toString().split(',');

                    print(listof);
                    Get.to(
                      SuraPage(
                        id: _filteredDataList[index]['id'].toString(),
                        moshaf: listof,
                        server: moshaf['server'],
                        title: _filteredDataList[index]['name'],
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                    child: ListTile(
                      title: Text(
                          'القارئ : ${_filteredDataList[index]['name'].toString()}',
                          style: TextStyle(color: fontColor)),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
