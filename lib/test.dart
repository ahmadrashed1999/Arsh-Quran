import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quranarsh/constant/colors.dart';
import 'package:quranarsh/data/full_with_tafseer/quran.dart';
import 'package:quranarsh/data/quran.dart';
import 'package:quranarsh/main.dart';
import 'package:sizer/sizer.dart';

class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final PageController pageController = PageController(
    initialPage: prefs.getInt('pageNum') ?? 0,
    keepPage: true,
  );
  List<Widget> list = [];
  int pagenum = 0;
  @override
  void initState() {
    super.initState();
    if (pageController.hasClients) {
      pageController.animateToPage(
        prefs.getInt('pageNum') ?? 0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
    pageController.addListener(() {
      setState(() {
        pagenum = pageController.page!.toInt();
        prefs.setInt('pageNum', pagenum);
      });
    });
    // crateListForSoraName();
  }

  void crateListForSoraName() {
    List sora = [];

    for (int i = 0; i < quran.length; i++) {
      sora.add(quran[i]['soraName']);
    }

    print(sora);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    pageController.dispose();
  }

  ArabicNumbers arabicNumber = ArabicNumbers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('القرآن الكريم'),
          backgroundColor: appBarColor,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      title: const Text('انتقل الى الصفحة'),
                      content: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'ادخل رقم الصفحة',
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            pageController.animateToPage(
                              int.parse(value) - 1,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.move_up_rounded,
                  color: iconColor,
                )),

            // IconButton(
            //     onPressed: () {
            //       pageController.animateToPage(
            //         pagenum - 1,
            //         duration: const Duration(milliseconds: 400),
            //         curve: Curves.easeInOut,
            //       );
            //     },
            //     icon: const Icon(Icons.arrow_back_ios)),
            // IconButton(
            //     onPressed: () {
            //       pageController.animateToPage(
            //         pagenum + 1,
            //         duration: const Duration(milliseconds: 400),
            //         curve: Curves.easeInOut,
            //       );
            //     },
            //     icon: const Icon(Icons.arrow_forward_ios)),
          ],
        ),
        backgroundColor: quranBackColor,
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemBuilder: (context, index) {
                  return Container(
                      padding: EdgeInsets.all(30),
                      foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/6ir5j4GrT.png'),
                            fit: BoxFit.fill),
                      ),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            alignment: Alignment(-.2, 0),
                            image: AssetImage('assets/images/6ir5j4GrT.png'),
                            fit: BoxFit.cover),
                      ),
                      child: QuranImage(index + 1));
                },
                itemCount: 604,
              ),
            ),
            Text(
              'الصفحة ${arabicNumber.convert((prefs.getInt('pageNum') ?? 0) + 1)}',
              style: TextStyle(
                  fontSize: 10.sp,
                  color: const Color(0xff081945),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }

  SvgPicture QuranImage(int a) {
    var i = '001';
    if (a < 10) {
      i = '00$a';
    }
    if (a > 9 && a < 100) {
      i = '0$a';
    }
    if (a > 99) {
      i = '$a';
    }

    return SvgPicture.network(
      'https://www.mp3quran.net/api/quran_pages_svg/$i.svg',
      fit: BoxFit.fill,
      placeholderBuilder: (BuildContext context) => const Center(
          child: CircularProgressIndicator(
        color: Color(0xff081945),
      )),
    );
  }

  // ignore: non_constant_identifier_names
  Page(x) {
    return Container(
      height: 100.h,
      width: 100.w,
      color: Colors.red,
      child: Column(
        children: [
          SizedBox(
            height: 5.h,
            child: Text(
              x['name'],
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: x['ayahs'][0]['text'],
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.black,
                    ),
                  ),
                  WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Text(
                        "\uFD3F${arabicNumber.convert(index + 1)}\uFD3E",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Amiri',
                        ),
                      ))
                ]));
              },
            ),
          ),
        ],
      ),
    );
  }
}
