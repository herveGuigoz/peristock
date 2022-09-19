abstract class AuthException implements Exception {
  const AuthException(this.error);

  /// The error which was caught.
  final Object error;
}

/// Thrown during the sign in process if a failure occurs.
class SignInFailure extends AuthException {
  const SignInFailure(super.error);
}

/// Thrown during the sign out process if a failure occurs.
class SignOutFailure extends AuthException {
  const SignOutFailure(super.error);
}

class UserInformationFailure extends AuthException {
  const UserInformationFailure(super.error);
}

class UpdateUserFailure extends AuthException {
  UpdateUserFailure(super.error);
}
