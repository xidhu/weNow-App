import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_now/app/data/Api/weather_api.dart';
import 'package:we_now/app/data/models/location_model.dart';
import 'package:we_now/app/settings/settings.dart';
import 'package:we_now/app/utils/local_notifications.dart';
import 'app/data/database/database.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/connectivity.dart';

backGroundTask(String locationId, bool isCelcius) async {
  var connectionStatus = ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();
  if ((await connectionStatus.checkConnection())) {
    var database = AppDatabase.instance;
    Location data = (await database.getLocation(locationId));
    data.setFullWeather(
        await WeatherApi().getFullWeather(data.longitude, data.latitude));
    LocalNotifications()
        .showNotificationWithDefaultSound(location: data, isCelcius: isCelcius);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Settings appSettings = Settings.instance;
  await appSettings.loadData();
  await AndroidAlarmManager.initialize();
  runApp(GetMaterialApp(
    theme: ThemeData(
      fontFamily: 'ReemKufi',
    ),
    title: "WeNow",
    initialRoute:
        appSettings.currentLocation >= 0 ? AppPages.INITIAL : AppPages.LOCATION,
    getPages: AppPages.routes,
  ));
  await appSettings.loadData();
  if (appSettings.currentLocation >= 0) {
    await AndroidAlarmManager.periodic(const Duration(minutes: 1), 0,
        backGroundTask(appSettings.currentLocationId, appSettings.isCelciuis));
  }
}
