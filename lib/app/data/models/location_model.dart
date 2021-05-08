import 'package:we_now/app/data/models/temperature_model.dart';

class Location {
  late String locId;
  late String cityName;
  late String countryName;
  late double longitude;
  late double latitude;

  DateTime date = DateTime.now();
  double currentTemperature = 0.0;
  String currentWhether = "";
  String weatherIcon = "";
  double currentPrecipitation = 0.0;
  double currentWind = 0.0;
  double currentHumidity = 0.0;
  List<TemperatureData> dayChartData = [];
  List<TemperatureData> weekChartData = [];

  bool isCurrentLocation = false;
  bool isRecentLocation = false;

  bool isDataAvailable = false;

  Location.fromAPI(Map<String, dynamic> data) {
    this.locId = data["locId"].toString();
    this.cityName = data["cityName"];
    this.countryName = data["countryName"];
    this.longitude = data["lon"];
    this.latitude = data["lat"];
  }

  Map<String, dynamic> toDatabase() {
    return {
      'date': date.toString(),
      'locId': locId,
      'cityName': cityName,
      'countryName': countryName,
      'currentTemperature': currentTemperature,
      'currentWhether': currentWhether,
      'weatherIcon': weatherIcon,
      'currentPrecipitation': currentPrecipitation,
      'currentWind': currentWind,
      'currentHumidity': currentHumidity,
      'dayChartData': dayChartData.map((e) => e.toJSON()).toList(),
      'weekChartData': weekChartData.map((e) => e.toJSON()).toList(),
      'lon': longitude,
      'lat': latitude,
      'isCurrentLocation': isCurrentLocation,
      'isRecentLocation': isRecentLocation,
      'isDataAvailable': isDataAvailable
    };
  }

  Location.fromDatabase(Map<String, dynamic> data) {
    this.isCurrentLocation = data["isCurrentLocation"];
    this.isRecentLocation = data["isRecentLocation"];
    this.isDataAvailable = data["isDataAvailable"];
    this.latitude = data["lat"];
    this.longitude = data["lon"];
    this.date = DateTime.parse(data["date"].toString());
    this.locId = data["locId"].toString();
    this.cityName = data["cityName"];
    this.countryName = data["countryName"];
    this.currentWhether = data["currentWhether"];
    this.weatherIcon = data["weatherIcon"];
    this.currentTemperature = data["currentTemperature"];
    this.currentPrecipitation = data["currentPrecipitation"];
    this.currentHumidity = data["currentHumidity"];
    this.currentWind = data["currentWind"];
    this.dayChartData = data["hourlyData"] != null
        ? data["hourlyData"].map((hours) {
            return TemperatureData(
                time: hours["time"],
                temperature: hours["temperature"],
                weather: hours["weather"],
                weatherIcon: hours["weatherIcon"]);
          })
        : [];
    this.weekChartData = data["dailyData"] != null
        ? data["dailyData"].map((day) {
            return TemperatureData(
                time: day["time"],
                temperature: day["temperature"],
                weather: day["weather"],
                weatherIcon: day["weatherIcon"]);
          })
        : [];
  }

  void setWeather(Map<String, dynamic> data) {
    date = DateTime.parse(data["date"].toString());
    locId = data["locId"].toString();
    cityName = data["cityName"];
    countryName = data["countryName"];
    currentWhether = data["currentWhether"];
    weatherIcon = data["weatherIcon"];
    currentTemperature = data["currentTemperature"];
  }

  void setFullWeather(Map<String, dynamic> data) {
    date = DateTime.parse(data["date"].toString());
    currentWhether = data["currentWhether"];
    weatherIcon = data["weatherIcon"];
    currentTemperature = data["currentTemperature"];
    currentPrecipitation = data["currentPrecipitation"];
    currentHumidity = data["currentHumidity"];
    currentWind = data["currentWind"];
    dayChartData = data["hourlyData"].map((hours) {
      return TemperatureData(
          time: hours["time"],
          temperature: hours["temperature"],
          weather: hours["weather"],
          weatherIcon: hours["weatherIcon"]);
    });
    weekChartData = data["dailyData"].map((day) {
      return TemperatureData(
          time: day["time"],
          temperature: day["temperature"],
          weather: day["weather"],
          weatherIcon: day["weatherIcon"]);
    });
  }
}
