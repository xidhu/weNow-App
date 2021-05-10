import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:we_now/app/Utils/day_converter.dart';
import 'package:we_now/app/data/Api/weather_api.dart';
import 'package:we_now/app/data/database/database.dart';
import 'package:we_now/app/data/models/location_model.dart';
import 'package:we_now/app/data/models/temperature_model.dart';
import 'package:we_now/app/theme/app_theme.dart';
import 'package:we_now/app/widgets/homeview_components.dart';
import 'package:we_now/app/widgets/temperature_chart.dart';

class HomeController extends GetxController {
  //Static Variables
  GetStorage appMemoryData = GetStorage();
  late SharedPreferences appData;
  final WeatherApi api = WeatherApi();

  //Global Variables
  late AppDatabase database;
  late Rx<HomeViewComponents> components;
  late Rx<AppTheme> theme;

  //State Variables
  late Rx<bool> isDrawerOpen;
  late Rx<Size> size;
  late Rx<bool> isDarkModeOn;
  Rx<bool> loadingState = false.obs;
  ChartSeriesController? chartController;

  //Data variables
  late Location data, fullData;
  String currentLocation = "";
  var locations;
  late List<TemperatureChartData> chartData = [];
  double highestTemperature = 0.0;
  double lowestTemperature = 273.0;

  //ForegroundDown View
  late TemperatureChart chart;

  //PeriodChooser View
  late RxList<bool> periodChooserState;

  //Switcher View
  late Rx<bool> switcherState;

  @override
  void onInit() async {
    /*Get.mediaQuery.platformBrightness == Brightness.dark
        ? appData.write('isDarkModeEnable', true)
        : appData.write('isDarkModeEnable', false);*/
    appMemoryData.writeIfNull('isDarkModeEnable', false);
    isDrawerOpen = false.obs;
    isDarkModeOn = (appMemoryData.read('isDarkModeEnable') as bool).obs;
    size = Get.size.obs;
    theme = isDarkModeOn.value
        ? AppTheme.darkTheme().obs
        : AppTheme.lightTheme().obs;
    components = HomeViewComponents(size: size.value, theme: theme.value).obs;
    loadingState = true.obs;
    update();
    appData = await SharedPreferences.getInstance();
    currentLocation = appData.getString('currentLocationId') ??
        appMemoryData.read('currentLocationId');
    database = AppDatabase.instance;
    data = (await database.getLocation(currentLocation));
    if (!data.isDataAvailable ||
        !(DateTime.now().day == data.date.day &&
            DateTime.now().hour == data.date.hour &&
            DateTime.now().month == data.date.month &&
            DateTime.now().year == data.date.year)) {
      data.setFullWeather(
          (await api.getFullWeather(data.longitude, data.latitude)));
      data.isDataAvailable = true;
      await database.updateLocation(data);
    }
    locations = (await database.getAllLocations());
    periodChooserState = [true, false, false].obs;
    switcherState = true.obs;
    setData(data);
    super.onInit();
  }

  void setData(Location data) {
    chartData.clear();
    highestTemperature = 0.0;
    lowestTemperature = 273.0;
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
    loadingState = false.obs;
    update();
  }

  void switchTheme(bool setDarkModeEnable) {
    appMemoryData.write('isDarkModeEnable', setDarkModeEnable);
    isDarkModeOn = setDarkModeEnable.obs;
    theme = setDarkModeEnable
        ? AppTheme.darkTheme().obs
        : AppTheme.lightTheme().obs;
    components = HomeViewComponents(size: size.value, theme: theme.value).obs;
    update();
  }

  void changePeriodChooserState(List<bool> state) {
    periodChooserState = state.obs;
    setData(data);
    update();
  }

  void changeSwitcherState(bool state) {
    switcherState = state.obs;
    setData(data);
    update();
  }

  void openDrawer() async {
    database = AppDatabase.instance;
    (await database.printAllLocations());

    isDrawerOpen = true.obs;
    update();
  }

  void closeDrawer() async {
    isDrawerOpen = false.obs;
    update();
  }
}
