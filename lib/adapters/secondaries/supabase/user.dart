import 'package:peristock/domain/entities/entities.dart';
import 'package:peristock/domain/ports/user.dart';

class UserRepository implements UserRepositoryInterface {
  @override
  Stream<User> get onUserChange => throw UnimplementedError();

  @override
  Future<User> getUserProfile() {
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser({required UserSnapshot snapshot}) {
    throw UnimplementedError();
  }
}
