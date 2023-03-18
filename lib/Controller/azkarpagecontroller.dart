import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

abstract class AzkarPageController extends GetxController {
  savescreen(String name, ScreenshotController sc);
}

class AzkarPageControllerImpl extends AzkarPageController {
  late ScreenshotController screenshotController;
  bool show = false;
  updateShow() {
    show = !show;
    update();
  }

  @override
  savescreen(String name, ScreenshotController sc) async {
    final directory = (await getApplicationDocumentsDirectory())
        .path; //from path_provide package
    String fileName = name + DateTime.now().microsecondsSinceEpoch.toString();

    sc
        .captureAndSave(directory, //set path where screenshot will be saved
            fileName: fileName)
        .then((value) => print(directory));
  }

  @override
  void onInit() {
    // screenshotController = ScreenshotController();
    // TODO: implement onInit
    super.onInit();
  }
}
