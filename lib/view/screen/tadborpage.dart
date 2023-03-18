import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranarsh/constant/colors.dart';

class TadaborPage extends StatefulWidget {
  TadaborPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  State<TadaborPage> createState() => _TadaborPageState();
}

class _TadaborPageState extends State<TadaborPage>
    with TickerProviderStateMixin {
  late AnimationController _animationIconController1;

  late AudioPlayer audioPlayer;
  Duration _duration = const Duration();
  Duration position = const Duration();
  Duration slider = const Duration(seconds: 0);
  late double durationvalue;
  bool issongplaying = false;
  String title = '';
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
    title = widget.data['sora_name'].toString().replaceAll("\r\n", '');
    print(title.replaceAllMapped(" ", (match) => ''));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationIconController1.dispose();
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
          Expanded(
            child: Container(
                decoration: BoxDecoration(
              color: primaryColor,
              image: DecorationImage(
                image: NetworkImage(widget.data['image_url']),
                fit: BoxFit.fill,
              ),
            )),
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
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      if (!issongplaying) {
                        audioPlayer.play(UrlSource(widget.data['audio_url']));
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
