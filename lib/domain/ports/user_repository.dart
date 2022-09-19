import 'package:peristock/domain/entities/entities.dart';

abstract class UserRepositoryInterface {
  /// Listen to user info change events.
  Stream<User> get onUserChange;

  /// Method to get the user information by id.
  Future<User> getUserProfile();

  /// Method to update the user information.
  Future<void> updateUser({required UserSnapshot snapshot});
}
