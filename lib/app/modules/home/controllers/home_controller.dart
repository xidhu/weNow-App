import 'package:flutter/cupertino.dart';
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

  late Rx<bool> isDrawerOpen;
  late Rx<Size> size;
  late Rx<HomeViewComponents> components;
  late Rx<AppTheme> theme;
  late Rx<bool> isDarkModeOn;

  @override
  void onInit() {
    appData.writeIfNull('isDarkModeEnable', false);
    isDrawerOpen = false.obs;
    isDarkModeOn = (appData.read('isDarkModeEnable') as bool).obs;
    size = Get.size.obs;
    theme = isDarkModeOn.value
        ? AppTheme.darkTheme().obs
        : AppTheme.lightTheme().obs;
    components = HomeViewComponents(size: size.value, theme: theme.value).obs;
    super.onInit();
  }

  void switchTheme(bool setDarkModeEnable) {
    appData.write('isDarkModeEnable', setDarkModeEnable);
    isDarkModeOn = setDarkModeEnable.obs;
    theme = setDarkModeEnable
        ? AppTheme.darkTheme().obs
        : AppTheme.lightTheme().obs;
    components = HomeViewComponents(size: size.value, theme: theme.value).obs;
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
