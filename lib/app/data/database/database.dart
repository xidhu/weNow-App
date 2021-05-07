/*import 'dart:async';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:we_now/app/data/models/location_model.dart';

class AppDatabase {
  static final _singleton = AppDatabase._();
  static AppDatabase get instance => _singleton;

  late Completer _openDbCompleter;
  bool _isOpen = false;

  AppDatabase._();

  Future get database async {
    if (!_isOpen) {
      _openDbCompleter = Completer();
      final dir = await getApplicationDocumentsDirectory();
      final dbPath = join(dir.path, "location.db");
      final db = await databaseFactoryIo.openDatabase(dbPath);
      _isOpen = true;
      _openDbCompleter.complete(db);
    }
    return _openDbCompleter.future;
  }

  Future<Database> get _db async => await AppDatabase.instance.database;

  static const String LOCATION_STORE = 'locations';
  final _location_store = intMapStoreFactory.store(LOCATION_STORE);

  Future<Location> findLocation(Location location) async {
    final finder = Finder(filter: Filter.byKey(location.locId));
    final finded = await _location_store.findFirst(await _db, finder: finder);
    return finded != null
        ? Location.fromJSON(finded.value)
        : Location(locId: -1, cityName: "Not Found", countryName: "Nill");
  }

  Future<bool> addLocation(Location location) async {
    if ((await findLocation(location)) != null) {
      await _location_store.add(await _db, location.toJSON());
      return true;
    } else
      return false;
  }

  Future<List<Location>> getAllLocations() async {
    return (await _location_store.find(await _db))
        .map((e) => Location.fromJSON(e.value))
        .toList();
  }

  Future<bool> clearLocations() async {
    await _location_store.delete(await _db);
    return true;
  }

  Future<int> getLocationCount() async {
    return _location_store.count(await _db);
  }
}
*/
