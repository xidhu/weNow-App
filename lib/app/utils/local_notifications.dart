import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:we_now/app/data/models/location_model.dart';

class LocalNotifications {
  late FlutterLocalNotificationsPlugin notificationsPlugin;
  LocalNotifications() {
    intialize();
  }

  void intialize() {
    var initSetAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSet = new InitializationSettings(android: initSetAndroid);
    notificationsPlugin = new FlutterLocalNotificationsPlugin();
    notificationsPlugin.initialize(initSet);
  }

  Future showNotificationWithDefaultSound(
      {required Location location, required bool isCelcius}) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '2067', 'we_now_channel', 'we_now_app_notifcation',
        importance: Importance.max, priority: Priority.high);
    var platformChannelSpecifics =
        new NotificationDetails(android: androidPlatformChannelSpecifics);
    await notificationsPlugin.show(
      100,
      location.currentWeather + " in " + location.cityName,
      (isCelcius
              ? (location.currentTemperature - 273).ceil().toString() + "°c"
              : ((location.currentTemperature - 273) * (9 / 5) + 32)
                      .ceil()
                      .toString() +
                  "°F") +
          " with wind " +
          (location.currentWind).toString() +
          " km/h",
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }
}
