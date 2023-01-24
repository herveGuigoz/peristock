part of 'http.dart';

abstract class CredentialsStorageInterface {
  Credentials? read();

  Future<void> write(Credentials credentials);

  Future<void> delete();
}

class CredentialsStorage implements CredentialsStorageInterface {
  const CredentialsStorage._(this._prefs);

  static Future<CredentialsStorage> initialize() async {
    if (_instance != null) {
      return _instance!;
    }
    final sharedPreferences = await SharedPreferences.getInstance();
    return _instance = CredentialsStorage._(sharedPreferences);
  }

  static CredentialsStorage? _instance;

  static CredentialsStorage get instance {
    if (_instance == null) throw Exception('Storage is not initalized');
    return _instance!;
  }

  final SharedPreferences _prefs;

  @override
  Future<void> delete() => _prefs.remove('_credentials_');

  @override
  Credentials? read() {
    final cache = _prefs.getString('_credentials_');
    return cache != null ? Credentials.fromJson(json.decode(cache) as Map<String, dynamic>) : null;
  }

  @override
  Future<void> write(Credentials value) => _prefs.setString('_credentials_', value.toJson());
}
