import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  int currentLocation =
      (await SharedPreferences.getInstance()).getInt("currentLocation") ?? -1;
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'ReemKufi',
      ),
      title: "WeNow",
      initialRoute: currentLocation >= 0 ? AppPages.INITIAL : AppPages.LOCATION,
      getPages: AppPages.routes,
    ),
  );
}
