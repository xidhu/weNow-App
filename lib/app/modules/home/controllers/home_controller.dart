import 'dart:ui';

import 'package:get/get.dart';

class HomeController extends GetxController {
  var isDrawerOpen = false.obs;
  var menuAnimationController;

  @override
  void onInit() {
    this.isDrawerOpen = false.obs;

    super.onInit();
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
