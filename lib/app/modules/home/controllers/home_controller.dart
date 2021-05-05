import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:we_now/app/routes/app_pages.dart';
import 'package:we_now/app/theme/app_theme.dart';

class HomeController extends GetxController {
  var isDrawerOpen = false.obs;
  var menuAnimationController;
  var isDarkModeOn = false.obs;
  var theme = AppTheme.lightTheme().obs;
  final appData = GetStorage();

  @override
  void onInit() {
    appData.writeIfNull('isDarkModeEnable', false);
    this.isDrawerOpen = false.obs;
    this.isDarkModeOn = (appData.read('isDarkModeEnable') as bool).obs;
    super.onInit();
  }

  void switchTheme(bool setDartkModeEnable) {
    appData.write('isDarkModeEnable', setDartkModeEnable);
    this.isDarkModeOn = setDartkModeEnable.obs;
    this.theme = setDartkModeEnable
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
