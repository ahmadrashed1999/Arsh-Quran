import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:quranarsh/Controller/settingscontroller.dart';
import 'package:quranarsh/view/screen/changefontsize.dart';
import 'package:share/share.dart';

import '../widgets/sittingeswidget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingscontrollerImpl controller = Get.put(SettingscontrollerImpl());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff081945),
        title: const Text('الإعدادات'),
      ),
      body: Container(
        color: const Color(0xff081945),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff081945)),
              child: ListTile(
                  leading: const Icon(
                    Icons.translate,
                    color: Colors.orange,
                  ),
                  trailing: Directionality(
                    textDirection: TextDirection.ltr,
                    child: GetBuilder<SettingscontrollerImpl>(
                      builder: (controller) => InkWell(
                        child: Switch(
                          value: controller.isEnglish,
                          onChanged: (value) {
                            controller.translate(value);
                          },
                          activeColor: Colors.orange,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  title: const Text('ترجمة انجليزية',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ))),
            ),
            SittingsCard(
              iconData: Icons.edit,
              title: 'تغيير حجم الخط',
              onTap: () {
                Get.to(() => ChangeFintSize());
              },
            ),
            SittingsCard(
              onTap: () async {
                await Share.share(
                    'https://ahmadrashed1999.github.io/personal-website/',
                    subject: 'قم بزيارة موقعي الشخصي');
              },
              iconData: Icons.share,
              title: 'مشاركة التطبيق',
            ),
            SittingsCard(
              iconData: Icons.rate_review,
              title: 'تقييم التطبيق',
              onTap: () {
                Get.snackbar("قريبا", "سيتم تفعيل هذه الخاصية قريبا",
                    duration: const Duration(seconds: 1),
                    colorText: Colors.black,
                    backgroundColor: Colors.white.withOpacity(0.8),
                    icon: const Icon(
                      Icons.error,
                      size: 30,
                      color: Colors.orange,
                    ));
              },
            ),
            const Spacer(),
            const Text(
              'تصميم وبرمجة :   أحمد رشيد البرغش',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            const Text(
              'هذا العمل عن روح والدي\nأرجو الدعاء له بالرحمة',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
