import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_now/app/data/Api/weather_api.dart';
import 'package:we_now/app/settings/settings.dart';
import 'package:we_now/app/utils/local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'app/data/database/database.dart';
import 'app/data/models/location_model.dart';
import 'app/routes/app_pages.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    var database = AppDatabase.instance;
    Location data = (await database.getLocation(inputData!['locId']));
    data.setFullWeather(
        await WeatherApi().getFullWeather(data.longitude, data.latitude));

    LocalNotifications().showNotificationWithDefaultSound(
        location: data, isCelcius: inputData['isCel']);
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Settings appSettings = Settings.instance;
  await appSettings.loadData();

  if (appSettings.currentLocation >= 0) {
    Workmanager wrk = Workmanager();
    wrk.initialize(callbackDispatcher);
    wrk.registerPeriodicTask("1", "backgroundNotification",
        existingWorkPolicy: ExistingWorkPolicy.replace,
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
        inputData: {
          'locId': appSettings.currentLocationId,
          'isCel': appSettings.isCelciuis
        },
        frequency: Duration(hours: 3),
        initialDelay: Duration(seconds: 5));
  }

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
