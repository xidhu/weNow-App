import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motion_widget/motion_widget.dart';
import 'package:we_now/app/theme/app_theme.dart';
import 'package:we_now/app/widgets/homeview_components.dart';

class HomeController extends GetxController {
  var appData = GetStorage();
  var menuAnimator = MotionExitConfigurations(
          durationMs: 500,
          displacement: 200,
          orientation: MotionOrientation.RIGHT)
      .obs;

  var isDrawerOpen;
  var size;
  var components;
  var theme;
  var isDarkModeOn;

  @override
  void onInit() {
    appData.writeIfNull('isDarkModeEnable', false);
    isDrawerOpen = false.obs;
    isDarkModeOn = (appData.read('isDarkModeEnable') as bool).obs;
    size = Get.size;
    theme = isDarkModeOn ? AppTheme.darkTheme() : AppTheme.lightTheme();
    components = HomeViewComponents(size: size, theme: theme);
    super.onInit();
  }

  void switchTheme(bool setDarkModeEnable) {
    appData.write('isDarkModeEnable', setDarkModeEnable);
    isDarkModeOn = setDarkModeEnable.obs;
    theme = setDarkModeEnable
        ? AppTheme.darkTheme().obs
        : AppTheme.lightTheme().obs;
    update();
  }

  void openDrawer() {
    isDrawerOpen = true.obs;
    update();
  }

  void closeDrawer() {
    isDrawerOpen = false.obs;
    update();
  }
}
