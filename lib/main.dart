import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_now/app/settings/settings.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Settings appSettings = Settings.instance;
  await appSettings.loadData();
  runApp(GetMaterialApp(
    theme: ThemeData(
      fontFamily: 'ReemKufi',
    ),
    title: "WeNow",
    initialRoute:
        appSettings.currentLocation >= 0 ? AppPages.INITIAL : AppPages.LOCATION,
    getPages: AppPages.routes,
  ));
}
