import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motion_widget/motion_widget.dart';
import 'package:we_now/app/theme/app_theme.dart';
import 'package:we_now/app/widgets/homeview_components.dart';
import 'package:we_now/app/widgets/temperature_chart.dart';

class HomeController extends GetxController {
  //Static Variables
  GetStorage appData = GetStorage();
  MotionExitConfigurations menuAnimator = MotionExitConfigurations(
      durationMs: 500, displacement: 200, orientation: MotionOrientation.RIGHT);
  HomeViewComponents components = HomeViewComponents();

  //Global Variables
  late Rx<bool> isDrawerOpen;
  late Rx<Size> size;
  late Rx<AppTheme> theme;
  late Rx<bool> isDarkModeOn;

  //ForegroundDown View
  late Rx<TemperatureChart> chart;

  //PeriodChooser View
  late RxList<bool> periodChooserState;

  //Switcher View
  late Rx<bool> switcherState;

  @override
  void onInit() {
    appData.writeIfNull('isDarkModeEnable', false);
    isDrawerOpen = false.obs;
    isDarkModeOn = (appData.read('isDarkModeEnable') as bool).obs;
    size = Get.size.obs;
    theme = isDarkModeOn.value
        ? AppTheme.darkTheme().obs
        : AppTheme.lightTheme().obs;
    chart = TemperatureChart(theme: theme.value).obs;
    periodChooserState = [true, false, false].obs;
    switcherState = false.obs;
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

  void changePeriodChooserState(List<bool> state) {
    periodChooserState = state.obs;
    update();
  }

  void changeSwitcherState(bool state) {
    switcherState = state.obs;
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
