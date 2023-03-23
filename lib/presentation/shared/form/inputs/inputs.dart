part of '../form.dart';

class EmailInput extends FormInput<String> with EmailValidator {
  const EmailInput({
    super.value = '',
    super.isPure = true,
    this.message = 'This value is not a valid email address.',
  });

  @override
  final String message;

  EmailInput copyWith({required String value}) {
    return EmailInput(value: value, isPure: false, message: message);
  }
}

class PasswordInput extends FormInput<String> with RegexValidator {
  const PasswordInput({
    super.value = '',
    super.isPure = true,
    this.message = 'Password must be at least 8 characters long and contain at least one letter and one number.',
  });

  @override
  final String message;

  /// ^ - matches the start of the string.
  /// (?=.*[A-Za-z]) - positive lookahead to ensure that there is at least one letter in the string.
  /// (?=.*\d) - positive lookahead to ensure that there is at least one number in the string.
  /// [\S]{8,} - matches any combination of letters and numbers that is at least 8 characters long.
  /// $ - matches the end of the string.
  @override
  String get pattern => r'^(?=.*[A-Za-z])(?=.*\d)[\S]{8,}$';

  PasswordInput copyWith({required String value}) {
    return PasswordInput(value: value, isPure: false, message: message);
  }
}
