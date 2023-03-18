import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:quranarsh/constant/colors.dart';
import 'package:quranarsh/view/screen/qiblah/qiblah_compass.dart';
import 'package:quranarsh/view/screen/qiblah/qiblah_maps.dart';

class Qiblah extends StatelessWidget {
  Qiblah({Key? key}) : super(key: key);
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('القبلة'),
        backgroundColor: appBarColor,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: FutureBuilder(
        future: _deviceSupport,
        builder: (_, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xff081945),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );
          }

          if (snapshot.data!) {
            return QiblahCompass();
          } else {
            return QiblahMaps();
          }
        },
      ),
    );
  }
}
