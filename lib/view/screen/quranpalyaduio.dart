import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quranarsh/constant/colors.dart';

import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

class QuranPlayPage extends StatefulWidget {
  QuranPlayPage({
    Key? key,
    required this.server,
    required this.sora_name,
    required this.name,
    required this.id,
    required this.list,
  }) : super(key: key);
  final String id;
  final String server;
  // ignore: non_constant_identifier_names
  final String sora_name;
  final String name;
  final List list;

  @override
  State<QuranPlayPage> createState() => _QuranPlayPageState();
}

class _QuranPlayPageState extends State<QuranPlayPage>
    with TickerProviderStateMixin {
  late AnimationController _animationIconController1;

  late AudioPlayer audioPlayer;
  Duration _duration = const Duration();
  Duration position = const Duration();
  Duration slider = const Duration(seconds: 0);
  late double durationvalue;
  bool issongplaying = false;
  String title = '';
  ArabicNumbers arabicNumber = ArabicNumbers();
  bool isfavorite = false;

  @override
  void initState() {
    super.initState();
    position = slider;
    _animationIconController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
      reverseDuration: const Duration(milliseconds: 750),
    );
    audioPlayer = AudioPlayer();
    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
    });
    audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() => position = p);
    });
    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        position = Duration(
          seconds: 0,
        );
        issongplaying = false;
        AnimatedIcons.play_pause;
        _animationIconController1.reverse();
      });
    });
    title = widget.sora_name;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        excludeHeaderSemantics: true,
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(fontSize: 18, color: fontColor),
        ),
        elevation: 0,
        backgroundColor: appBarColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios, color: iconColor)),
      ),
      backgroundColor: primaryColor,
      body: Column(
        children: [
          issongplaying
              ? Expanded(
                  child: Container(
                  //     decoration: BoxDecoration(
                  //   color: Colors.grey.shade100.withOpacity(0.55),
                  //   image: DecorationImage(
                  //     image: NetworkImage(widget.data['image_url']),
                  //     fit: BoxFit.fill,
                  //   ),
                  // )),
                  child: Center(
                      child: Lottie.network(
                          'https://assets6.lottiefiles.com/packages/lf20_U6edMV2fpR.json')),
                ))
              : Expanded(
                  child: Container(
                  child: Center(
                      child: Lottie.network(
                          'https://assets6.lottiefiles.com/packages/lf20_gplhY8/stop only.json')),
                )),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                position.toString().split('.').first,
                style: TextStyle(color: fontColor),
              ),
              const Spacer(),
              Text(
                _duration.toString().split('.').first,
                style: TextStyle(color: fontColor),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          Slider(
            activeColor: iconColor,
            inactiveColor: Colors.grey,
            value: position.inSeconds.toDouble(),
            max: _duration.inSeconds.toDouble(),
            onChanged: (double value) {
              // Add code to track the music duration.
              setState(() {
                audioPlayer.seek(Duration(seconds: value.toInt()));
                value = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Visibility(
                visible: false,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                      !isfavorite ? Icons.favorite_border : Icons.favorite,
                      color: Color(0xff081945)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      if (!issongplaying) {
                        audioPlayer.play(
                            UrlSource('${widget.server}/${widget.id}.mp3'));
                      } else {
                        audioPlayer.pause();
                      }
                      issongplaying
                          ? _animationIconController1.reverse()
                          : _animationIconController1.forward();
                      issongplaying = !issongplaying;
                    },
                  );
                },
                child: ClipOval(
                  child: Container(
                    color: iconColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        size: 50,
                        progress: _animationIconController1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () async {
                    final result = await TimePicker.show<DateTime?>(
                      context: context,
                      sheet: TimePickerSheet(
                        sheetTitle: 'ايقاف التشغيل بعد',
                        hourTitle: 'ساعة',
                        minuteTitle: 'ديقيقة',
                        saveButtonText: 'حفظ',
                        hourTitleStyle: const TextStyle(
                            fontSize: 14, color: Colors.redAccent),
                        minuteTitleStyle: const TextStyle(
                            fontSize: 14, color: Colors.redAccent),
                        minuteInterval: 1,
                      ),
                    );
                    if (result == null) {
                      print('cancel');
                    } else {
                      var totalMin = (result.hour * 60) + (result.minute);
                      Future.delayed(Duration(minutes: totalMin), () {
                        // <-- Delay here
                        setState(() {
                          audioPlayer.pause();
                          issongplaying
                              ? _animationIconController1.reverse()
                              : _animationIconController1.forward();
                          issongplaying = false; // <-- Code run after delay
                        });
                      });
                    }
                  },
                  icon: Icon(
                    Icons.alarm_sharp,
                    color: iconColor,
                    size: 30,
                  )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
