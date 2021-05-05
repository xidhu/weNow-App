import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'ReemKufi',
      ),
      title: "WeNow",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
