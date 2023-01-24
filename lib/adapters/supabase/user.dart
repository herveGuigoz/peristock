import 'package:peristock/domain/entities/entities.dart';
import 'package:peristock/domain/ports/user_repository.dart';

class UserRepository implements UserRepositoryInterface {
  @override
  Future<User> getUserProfile() {
    // TODO: implement getUserProfile
    throw UnimplementedError();
  }

  @override
  // TODO: implement onUserChange
  Stream<User> get onUserChange => throw UnimplementedError();

  @override
  Future<void> updateUser({required UserSnapshot snapshot}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
