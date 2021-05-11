import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:we_now/app/settings/settings.dart';
import 'package:we_now/app/utils/connectivity.dart';
import 'package:we_now/app/utils/day_converter.dart';
import 'package:we_now/app/data/Api/weather_api.dart';
import 'package:we_now/app/data/database/database.dart';
import 'package:we_now/app/data/models/location_model.dart';
import 'package:we_now/app/data/models/temperature_model.dart';
import 'package:we_now/app/routes/app_pages.dart';
import 'package:we_now/app/theme/app_theme.dart';
import 'package:we_now/app/widgets/homeview_components.dart';
import 'package:we_now/app/widgets/temperature_chart.dart';

class HomeController extends GetxController {
  //Static Variables
  final WeatherApi api = WeatherApi();

  //Global Variables
  late AppDatabase database;
  late HomeViewComponents components;
  late AppTheme theme;
  late ConnectionStatusSingleton connectionStatus;
  late StreamSubscription connectionChangeStream;
  late Settings appSettings;

  //State Variables
  late bool isDrawerOpen;
  late Size size;
  bool loadingState = false;
  ChartSeriesController? chartController;
  bool isOnline = false;

  //Data variables
  late Location data;
  String currentLocation = "";
  var locations;
  late List<TemperatureChartData> chartData = [];
  double highestTemperature = -273.0;
  double lowestTemperature = 1000.0;

  //ForegroundDown View
  late TemperatureChart chart;

  //PeriodChooser View
  late List<bool> periodChooserState;

  //Switcher View
  late bool switcherState;

  @override
  void onInit() async {
    database = AppDatabase.instance;
    appSettings = Settings.instance;

    connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    connectionChangeStream = connectionStatus.connectionChange.listen((status) {
      isOnline = status;
      if (isOnline) {
        showSnackBar(
            title: "Connection", description: "Internet Connection Available");
      } else {
        showSnackBar(
            title: "Connection", description: "No Internet Connection");
      }
      update();
    });

    isDrawerOpen = false;

    size = Get.size;
    setTheme();
    components = HomeViewComponents(size: size, theme: theme);
    loadingState = true;
    update();
    await appSettings.loadData();
    currentLocation = appSettings.currentLocationId;

    data = (await database.getLocation(currentLocation));

    if (!data.isDataAvailable ||
        !(DateTime.now().day != data.date.day &&
            DateTime.now().hour != data.date.hour &&
            DateTime.now().month != data.date.month &&
            DateTime.now().year != data.date.year)) {
      if (await connectionStatus.checkConnection()) {
        data.setFullWeather(
            (await api.getFullWeather(data.longitude, data.latitude)));
        data.isDataAvailable = true;
        await database.updateLocation(data);
      } else {
        showSnackBar(
            title: "Connection", description: "No Internet Connection");
        Get.offAndToNamed(AppPages.LOCATION);
      }
    }
    locations = (await database.getAllLocations());
    periodChooserState = [true, false, false];
    switcherState = true;
    setData(data);
    super.onInit();
  }

  void setTheme() {
    if (appSettings.isdefaultTheme) {
      theme = Get.mediaQuery.platformBrightness == Brightness.dark
          ? AppTheme.darkTheme()
          : AppTheme.lightTheme();
    } else {
      theme =
          appSettings.isDarkMode ? AppTheme.darkTheme() : AppTheme.lightTheme();
    }
  }

  void showSnackBar({required String title, required String description}) {
    Get.snackbar(title, description,
        snackPosition: SnackPosition.BOTTOM,
        colorText: theme.appColorTheme.greyButtonInsideColor,
        isDismissible: true,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        backgroundColor: theme.appColorTheme.colorBackground,
        borderRadius: 10,
        boxShadows: [theme.appColorTheme.shadowMedium],
        animationDuration: Duration(milliseconds: 200));
  }

  void setData(Location data) {
    chartData.clear();
    highestTemperature = -273.0;
    lowestTemperature = 1000.0;
    if (periodChooserState[0]) {
      data.dayChartData.forEach((hour) {
        if (DateTime.now().day == hour.time.day) {
          if (hour.temperature < lowestTemperature)
            lowestTemperature = hour.temperature;
          if (hour.temperature > highestTemperature)
            highestTemperature = hour.temperature;

          chartData.add(TemperatureChartData(
              time:
                  hour.time.hour.toString() + ":" + hour.time.minute.toString(),
              temperature: hour.temperature,
              weather: hour.weather,
              weatherIcon: hour.weatherIcon));
        }
      });
    } else if (periodChooserState[1]) {
      data.dayChartData.forEach((hour) {
        if (DateTime.now().day + 1 == hour.time.day) {
          if (hour.temperature < lowestTemperature)
            lowestTemperature = hour.temperature;
          if (hour.temperature > highestTemperature)
            highestTemperature = hour.temperature;

          chartData.add(TemperatureChartData(
              time:
                  hour.time.hour.toString() + ":" + hour.time.minute.toString(),
              temperature: hour.temperature,
              weather: hour.weather,
              weatherIcon: hour.weatherIcon));
        }
      });
    } else if (periodChooserState[2]) {
      data.weekChartData.forEach((day) {
        if (day.temperature < lowestTemperature)
          lowestTemperature = day.temperature;
        if (day.temperature > highestTemperature)
          highestTemperature = day.temperature;
        chartData.add(TemperatureChartData(
            time: convertToDay(day.time.weekday) +
                "\n (" +
                day.time.day.toString() +
                ")",
            temperature: day.temperature,
            weather: day.weather,
            weatherIcon: day.weatherIcon));
      });
    }
    chart = TemperatureChart();
    loadingState = false;
    update();
  }

  void changePeriodChooserState(List<bool> state) {
    periodChooserState = state;
    setData(data);
    update();
  }

  void changeSwitcherState(bool state) {
    switcherState = state;
    setData(data);
    update();
  }

  void openDrawer() async {
    database = AppDatabase.instance;

    isDrawerOpen = true;
    update();
  }

  void closeDrawer() async {
    isDrawerOpen = false;
    update();
  }

  void onLocationClicked(int index) async {
    appSettings.currentLocation = index;
    appSettings.currentLocationId = locations[index].locId;
    await appSettings.saveData();
    update();
    onInit();
  }

  void onLocationPageClicked() async {
    await appSettings.saveData();
    closeDrawer();
    Get.offAndToNamed(AppPages.LOCATION);
  }
}
