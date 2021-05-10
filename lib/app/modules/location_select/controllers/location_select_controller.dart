import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_now/app/Utils/geolocator.dart';
import 'package:we_now/app/data/Api/weather_api.dart';
import 'package:we_now/app/data/database/database.dart';
import 'package:we_now/app/data/models/location_model.dart';
import 'package:we_now/app/routes/app_pages.dart';
import 'package:we_now/app/theme/app_theme.dart';
import 'package:we_now/app/widgets/locationview_components.dart';

class LocationSelectController extends GetxController {
  //statc variables
  GetStorage appMemoryData = GetStorage();
  final WeatherApi api = WeatherApi();
  ScrollController scrollController =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  TextEditingController searchTextConroller = TextEditingController();
  late SharedPreferences appData;
  FocusNode focusNode = FocusNode();

  //global variables
  late Rx<LocationViewComponents> components;
  late Rx<AppTheme> theme;
  late Rx<Size> size;
  late AppDatabase database;

  //State Variables
  Rx<bool> isDarkModeOn = false.obs;
  Rx<double> scrollOffset = 0.0.obs;
  Rx<bool> typingState = false.obs;
  Rx<bool> loadingState = false.obs;
  Rx<bool> locationsAvailable = false.obs;

  //Data variables
  var locations;
  var locationList;
  var currentLocation = -1;

  @override
  void onInit() async {
    Get.mediaQuery.platformBrightness == Brightness.dark
        ? appMemoryData.write('isDarkModeEnable', true)
        : appMemoryData.write('isDarkModeEnable', false);
    appMemoryData.writeIfNull('isDarkModeEnable', false);
    isDarkModeOn = (appMemoryData.read('isDarkModeEnable') as bool).obs;
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
    database = AppDatabase.instance;
    locations = (await database.getAllLocations());
    appData = await SharedPreferences.getInstance();
    if (locations.length > 0) {
      locationsAvailable = true.obs;
      currentLocation = appData.getInt('currentLocation') ?? -1;
      update();
    }
    super.onInit();
  }

  void onSearchBarTextChanged(String value) async {
    if (value == '') {
      typingState = false.obs;
      loadingState = false.obs;
    } else {
      loadingState = true.obs;
      typingState = true.obs;
      update();
      locationList = ((await api.getCities(value))
          .toList()
          .map((city) => Location.fromAPI(city))).toList();
      loadingState = false.obs;
    }
    update();
  }

  void getLocationFromGps() async {
    loadingState = true.obs;
    update();
    await determinePosition()
        .then((value) => getLocationFromCoord(value.latitude, value.longitude))
        .onError((error, stackTrace) => locatorError(error));
  }

  Future<void> onRefresh() async {
    loadingState = true.obs;
    update();
    database = AppDatabase.instance;
    locations = (await database.getAllLocations());
    if (locations.length > 0) {
      locationsAvailable = true.obs;
    }
    await Future.delayed(Duration(seconds: 1));
    loadingState = false.obs;
    update();
  }

  void locatorError(error) {
    loadingState = false.obs;
    Get.dialog(
        Material(
          color: Colors.grey.withOpacity(0.4),
          child: components.value.dialogBox(
              controller: this,
              title: "Location",
              description: error == LocatorStatus.LOCATION_OFF
                  ? "Please Turn On Your Location"
                  : error == LocatorStatus.PERMISSIONS_DISABLED
                      ? "Location Access Denied"
                      : error == LocatorStatus.PERMISSIONS_DISABLED_FOREVER
                          ? "App Location Permissions Disabled"
                          : "Can't Fetch Location",
              negetive: "Cancel",
              positive: error == LocatorStatus.LOCATION_OFF
                  ? "Turn On"
                  : error == LocatorStatus.PERMISSIONS_DISABLED
                      ? "Request"
                      : error == LocatorStatus.PERMISSIONS_DISABLED_FOREVER
                          ? "Ok"
                          : "Try Again",
              onNegetive: () => Get.back(),
              onPositive: error == LocatorStatus.LOCATION_OFF
                  ? () {
                      Geolocator.openLocationSettings();
                      Get.back();
                    }
                  : error == LocatorStatus.PERMISSIONS_DISABLED
                      ? () {
                          Geolocator.requestPermission();
                          Get.back();
                        }
                      : error == LocatorStatus.PERMISSIONS_DISABLED_FOREVER
                          ? () => Get.back()
                          : () {
                              Get.back();
                              getLocationFromGps();
                            }),
        ),
        barrierColor: Colors.transparent,
        transitionDuration: Duration(milliseconds: 200));
    focusNode.unfocus();
    update();
  }

  void getLocationFromCoord(double lat, double lon) async {
    locationList = ((await api.getCitiesByLocation(lon, lat))
        .toList()
        .map((city) => Location.fromAPI(city))).toList();
    loadingState = false.obs;
    typingState = true.obs;
    update();
  }

  void backClicked() async {
    if (typingState.value) {
      searchTextConroller.text = '';
      typingState = false.obs;
      loadingState = false.obs;
      update();
    } else {
      if (currentLocation >= 0) Get.offAndToNamed(AppPages.INITIAL);
    }
  }

  void addLocation(int index) async {
    loadingState = true.obs;
    update();
    database = AppDatabase.instance;
    Location loc = locationList[index];
    loc.setWeather(await api.getWeather(locationList[index].locId));
    await database.addLocation(loc);
    locations = (await database.getAllLocations());
    searchTextConroller.text = '';
    typingState = false.obs;
    loadingState = false.obs;
    locationsAvailable = true.obs;
    update();
  }

  void deleteLocation(int index) {
    database = AppDatabase.instance;
    Location loc = locations[index];
    Get.dialog(
        Material(
          color: Colors.grey.withOpacity(0.4),
          child: components.value.dialogBox(
              controller: this,
              title: "Delete Location",
              description: "Do you want to delete this location?",
              onNegetive: () => Get.back(),
              onPositive: () async {
                loadingState = true.obs;
                update();
                await database.deleteLocation(loc);
                locations = (await database.getAllLocations());
                if (locations.length > 0) {
                  locationsAvailable = true.obs;
                } else {
                  locationsAvailable = false.obs;
                }
                if (index == currentLocation)
                  currentLocation = -1;
                else
                  currentLocation--;
                appData.setInt('currentLocation', currentLocation);
                loadingState = false.obs;
                Get.back();
                update();
              },
              positive: "Delete",
              negetive: "Cancel"),
        ),
        barrierColor: Colors.transparent,
        transitionDuration: Duration(milliseconds: 200));
    focusNode.unfocus();
  }

  void onLocationClicked(int index) {
    currentLocation = index;
    appData.setInt('currentLocation', index);
    appData.setString('currentLocationId', locations[index].locId);
    appMemoryData.write('currentLocationId', locations[index].locId);
    update();
    Get.offAndToNamed(AppPages.INITIAL);
  }
}
