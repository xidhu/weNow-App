import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:we_now/app/theme/app_theme.dart';
import 'package:we_now/app/widgets/locationview_components.dart';

class LocationSelectController extends GetxController {
  //statc variables
  var appData = GetStorage();
  ScrollController scrollController =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);

  //global variables
  late Rx<LocationViewComponents> components;
  late Rx<AppTheme> theme;
  late Rx<bool> isDarkModeOn;
  late Rx<Size> size;
  Rx<double> scrollOffset = 0.0.obs;

  @override
  void onInit() {
    Get.mediaQuery.platformBrightness == Brightness.dark
        ? appData.write('isDarkModeEnable', true)
        : appData.write('isDarkModeEnable', false);
    appData.writeIfNull('isDarkModeEnable', false);
    isDarkModeOn = (appData.read('isDarkModeEnable') as bool).obs;
    size = Get.size.obs;
    theme = isDarkModeOn.value
        ? AppTheme.darkTheme().obs
        : AppTheme.lightTheme().obs;
    components =
        LocationViewComponents(size: size.value, theme: theme.value).obs;
    scrollController.addListener(() {
      if (scrollController.offset >= 0)
        scrollOffset = scrollController.offset < 100
            ? scrollController.offset.obs
            : 100.0.obs;
      update();
    });
    super.onInit();
  }
}
