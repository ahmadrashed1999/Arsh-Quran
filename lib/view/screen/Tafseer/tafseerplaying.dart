import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quranarsh/constant/colors.dart';
import 'package:quranarsh/data/quran.dart';

class TafseerPlayingPage extends StatefulWidget {
  TafseerPlayingPage({
    Key? key,
    required this.server,
    required this.name,
  }) : super(key: key);
  final String server;

  final String name;

  @override
  State<TafseerPlayingPage> createState() => _TafseerPlayingPageState();
}

class _TafseerPlayingPageState extends State<TafseerPlayingPage>
    with TickerProviderStateMixin {
  late AnimationController _animationIconController1;

  late AudioPlayer audioPlayer;
  Duration duration = const Duration();
  Duration position = const Duration();
  Duration slider = const Duration(seconds: 0);
  late double durationvalue;
  bool issongplaying = false;
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
      setState(() => duration = d);
    });
    audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() => position = p);
    });
    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        position = const Duration(
          seconds: 0,
        );
        issongplaying = false;
        AnimatedIcons.play_pause;
        _animationIconController1.reverse();
      });
    });
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
          widget.name,
          style: TextStyle(fontSize: 18, color: fontColor),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios, color: iconColor)),
        elevation: 0,
        backgroundColor: appBarColor,
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
                style: TextStyle(
                  color: fontColor,
                ),
              ),
              const Spacer(),
              Text(
                duration.toString().split('.').first,
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
            max: duration.inSeconds.toDouble(),
            onChanged: (double value) {
              // Add code to track the music duration.
              try {
                setState(() {
                  position = Duration(seconds: value.toInt());
                  value = value;
                });
              } catch (e) {
                print(e);
              }

              audioPlayer.seek(Duration(seconds: value.toInt()));
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
                  print(widget.server);
                  try {
                    setState(
                      () {
                        if (!issongplaying) {
                          audioPlayer.play(UrlSource(widget.server));
                        } else {
                          audioPlayer.pause();
                        }
                        issongplaying
                            ? _animationIconController1.reverse()
                            : _animationIconController1.forward();
                        issongplaying = !issongplaying;
                      },
                    );
                  } catch (e) {
                    Get.dialog(
                      AlertDialog(
                        title: const Text('حدث خطأ'),
                        content: Text(e.toString()),
                      ),
                    );
                    Get.back();
                  }
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
              Visibility(
                visible: false,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                      !isfavorite ? Icons.favorite_border : Icons.favorite,
                      color: Color(0xff081945)),
                ),
              ),
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
