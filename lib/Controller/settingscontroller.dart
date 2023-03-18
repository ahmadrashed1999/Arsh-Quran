import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:quranarsh/constant/colors.dart';
import 'package:quranarsh/main.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Settingscontroller extends GetxController {}

class SettingscontrollerImpl extends Settingscontroller {
  late bool isDarkMode;
  late bool isEnglish;
  Color pickerColor = Color(0xff081945);
  Color currentColor = Color(0xff081945);
  void changeColorForBack(Color color) {
    pickerColor = color;
    quranBackColor = pickerColor;
    prefs.setInt('quranBackColor', pickerColor.value);

    update();
  }

// ValueChanged<Color> callback

  bool fabIsClicked = false;
  double fontsize = 18;
  var saveNum = 0;
  var surah = 0;
  changefont(i) {
    fontsize = i;
    prefs.setDouble('fontsize', fontsize);
    update();
  }

  changestyle() {
    fabIsClicked = !fabIsClicked;
    prefs.setBool('fab', fabIsClicked);
    update();
  }

  void changeColor(Color color) {
    pickerColor = color;
    primaryColor = pickerColor;
    prefs.setInt('backColor', pickerColor.value);
    print(pickerColor);
    update();
  }

  changeSave(i, s) {
    saveNum = i;
    prefs.setInt('index', saveNum);
    surah = s;
    prefs.setInt('surah', surah);
    update();
  }

  translate(bl) {
    isEnglish = bl;
    prefs.remove('isEnglish');
    prefs.setBool("isEnglish", isEnglish);
    update();
  }

  @override
  void onInit() {
    isEnglish = prefs.getBool("isEnglish") == null
        ? false
        : prefs.getBool("isEnglish")!;
    isDarkMode = prefs.getBool("isDarkMode") == null;
    fabIsClicked = prefs.getBool("fab") == null ? false : prefs.getBool("fab")!;
    saveNum = prefs.getInt("index") == null ? 0 : prefs.getInt("index")!;
    surah = prefs.getInt("surah") == null ? 0 : prefs.getInt("surah")!;
    fontsize =
        prefs.getDouble("fontsize") == null ? 18 : prefs.getDouble("fontsize")!;
    super.onInit();
  }
}
