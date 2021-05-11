import 'package:we_now/app/data/database/database.dart';

class Settings {
  bool isDarkMode = false;
  bool isCelciuis = true;
  bool isdefaultTheme = false;

  int currentLocation = -1;
  String currentLocationId = "0";

  static final _singleton = Settings._();
  static Settings get instance => _singleton;
  late AppDatabase db;

  Settings._();

  Future saveData() async {
    db = AppDatabase.instance;
    await db.setSettings({
      'id': '1',
      'isDarkMode': isDarkMode,
      'isCelciuis': isCelciuis,
      'isdefaultTheme': isdefaultTheme,
      'currentLocation': currentLocation,
      'currentLocationId': currentLocationId
    });
  }

  Future loadData() async {
    db = AppDatabase.instance;
    var data = (await db.getSettings()).value;
    isDarkMode = data['isDarkMode'];
    isCelciuis = data['isCelciuis'];
    isdefaultTheme = data['isdefaultTheme'];
    currentLocation = data['currentLocation'];
    currentLocationId = data['currentLocationId'];
  }
}
