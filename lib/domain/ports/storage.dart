import 'dart:async';

abstract class StorageInterface {
  /// Returns value for key
  String? read(String key);

  /// Persists key value pair
  Future<void> write(String key, String value);

  /// Deletes key value pair
  Future<void> delete(String key);

  /// Clears all key value pairs from storage
  Future<void> clear();
}
