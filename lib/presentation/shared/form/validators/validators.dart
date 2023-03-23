part of '../form.dart';

mixin RegexValidator on FormInput<String> {
  String get pattern;

  String get message;

  @override
  String? validator(String value) => RegExp(pattern).hasMatch(value) ? null : message;
}

mixin EmailValidator on FormInput<String> {
  static final regex = RegExp(
    r"^[a-zA-Z0-9.!#$%&\'*+\\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$",
  );

  String get message;

  @override
  String? validator(String value) => regex.hasMatch(value) ? null : message;
}
