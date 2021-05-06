import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:we_now/app/theme/app_theme.dart';
import 'package:we_now/app/widgets/homeview_components.dart';
import 'package:we_now/app/widgets/temperature_chart.dart';

class HomeController extends GetxController {
  //Static Variables
  GetStorage appData = GetStorage();

  //Global Variables
  late Rx<bool> isDrawerOpen;
  late Rx<Size> size;
  late Rx<HomeViewComponents> components;
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
    Get.mediaQuery.platformBrightness == Brightness.dark
        ? appData.write('isDarkModeEnable', true)
        : appData.write('isDarkModeEnable', false);
    appData.writeIfNull('isDarkModeEnable', false);
    isDrawerOpen = false.obs;
    isDarkModeOn = (appData.read('isDarkModeEnable') as bool).obs;
    size = Get.size.obs;
    theme = isDarkModeOn.value
        ? AppTheme.darkTheme().obs
        : AppTheme.lightTheme().obs;
    components = HomeViewComponents(size: size.value, theme: theme.value).obs;
    chart = TemperatureChart().obs;
    periodChooserState = [true, false, false].obs;
    switcherState = true.obs;
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
