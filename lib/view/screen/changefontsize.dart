import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranarsh/Controller/settingscontroller.dart';
import 'package:quranarsh/view/widgets/sittingeswidget.dart';

class ChangeFintSize extends StatelessWidget {
  const ChangeFintSize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text('تغيير حجم الخط'),
          backgroundColor: const Color(0xff081945),
        ),
        backgroundColor: const Color(0xff081945),
        body: GetBuilder<SettingscontrollerImpl>(
          builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                SizedBox(
                  height: 100,
                  child: Text('بسم الله الرحمن الرحيم',
                      style: TextStyle(
                        fontSize: controller.fontsize,
                        color: Colors.white,
                      )),
                ),
                Spacer(),
                Slider(
                  inactiveColor: Colors.black.withOpacity(0.8),
                  activeColor: Colors.orange,
                  value: controller.fontsize,
                  onChanged: (i) {
                    controller.changefont(i);
                  },
                  max: 35,
                  min: 12,
                ),
                Spacer(),
              ],
            );
          },
        ));
  }
}
