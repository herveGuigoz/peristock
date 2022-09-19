part of 'presenter.dart';

class LoginState extends Equatable with FormMixin {
  const LoginState({
    this.status = const FormStatus.initial(),
    this.email = const Email.initial(),
  });

  final FormStatus status;

  final Email email;

  @override
  List<Object?> get props => [status, email];

  @override
  List<FormInput<Object>?> get inputs => [email];

  LoginState copyWith({FormStatus? status, Email? email}) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
    );
  }
}

class Email extends FormInput<String> {
  const Email(super.value);
  const Email.initial() : super.initial('');

  static final RegExp _emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  @override
  String? validator(String value) {
    return _emailRegExp.hasMatch(value) ? null : 'Inavlid email adress';
  }
}
