// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../form.dart';

enum FormInputStatus {
  /// The form input has not been touched.
  pure,

  /// The form input is valid.
  valid,

  /// The form input is not valid.
  invalid,
}

@immutable
abstract class FormInput<T> {
  const FormInput(
    T value, {
    bool isPure = false,
  }) : this._(value, isPure: isPure);

  const FormInput._(this.value, {this.isPure = true});

  const FormInput.initial(T value) : this._(value);

  /// The value of the given [FormInput].
  /// For example, if you have a `FormInput` for `FirstName`,
  /// the value could be 'Joe'.
  final T value;

  /// If the input has been modified.
  final bool isPure;

  /// A function that must return a validation error if the provided
  /// [value] is invalid and `null` otherwise.
  String? validator(T value);

  String? get error => isPure ? null : validator(value);

  @override
  bool operator ==(covariant FormInput<T> other) {
    if (identical(this, other)) return true;

    return other.value == value && other.isPure == isPure;
  }

  @override
  int get hashCode => value.hashCode ^ isPure.hashCode;

  @override
  String toString() => '$runtimeType(value: $value, isValid: $isValid)';
}

extension FormInputExtension<T> on FormInput<T> {
  /// Whether the [FormInput] value is valid according to the
  /// overridden `validator`.
  bool get isValid => validator(value) == null;

  /// Whether the [FormInput] value is not valid.
  bool get invalid => !isValid;
}
