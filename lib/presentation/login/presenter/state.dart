part of 'presenter.dart';

class LoginState extends Equatable with FormMixin {
  const LoginState({
    this.status = const FormStatus.initial(),
    this.email = const EmailInput(),
  });

  final FormStatus status;

  final EmailInput email;

  @override
  List<Object?> get props => [status, email];

  @override
  List<FormInput<Object>?> get inputs => [email];

  LoginState copyWith({FormStatus? status, EmailInput? email}) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
    );
  }
}
