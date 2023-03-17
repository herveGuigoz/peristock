import 'dart:async';

import 'package:peristock/domain/ports/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage implements StorageInterface {
  const Storage._(this._prefs);

  static Future<Storage> initialize() async {
    if (_instance != null) {
      return _instance!;
    }
    final sharedPreferences = await SharedPreferences.getInstance();
    return _instance = Storage._(sharedPreferences);
  }

  static Storage? _instance;

  static Storage get instance {
    if (_instance == null) throw Exception('Storage is not initalized');
    return _instance!;
  }

  final SharedPreferences _prefs;

  @override
  Future<void> clear() => _prefs.clear();

  @override
  Future<void> delete(String key) => _prefs.remove(key);

  @override
  String? read(String key) => _prefs.getString(key);

  @override
  Future<void> write(String key, String value) => _prefs.setString(key, value);
}
