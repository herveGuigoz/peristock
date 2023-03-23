import 'package:freezed_annotation/freezed_annotation.dart';

part 'form.freezed.dart';
part 'inputs/inputs.dart';
part 'validators/validators.dart';

@freezed
class FormStatus with _$FormStatus {
  // Class representing the status of a form at any given point in time.
  const FormStatus._();

  /// The form has not yet been submitted.
  const factory FormStatus.initial() = _Initial;

  /// The form is in the process of being submitted.
  const factory FormStatus.submissionInProgress() = _InProgress;

  /// The form has been submitted successfully.
  const factory FormStatus.submissionSucceed() = _Succeed;

  /// The form submission failed.
  const factory FormStatus.submissionFailled(Object error) = _Failled;

  bool get isInProgress => this is _InProgress;

  bool get isSucceed => this is _Succeed;

  bool get hasError => this is _Failled;

  void onError(void Function(Object error) onError) {
    whenOrNull(submissionFailled: (error) => onError(error));
  }
}

/// Mixin that handles validation.
mixin FormMixin {
  List<FormInput<Object>?> get inputs;

  bool get isPure {
    return inputs.every((input) => input?.isPure ?? true);
  }

  bool get isValid {
    return inputs.every((input) => input?.isValid ?? true);
  }
}

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
  const FormInput({
    required this.value,
    this.isPure = true,
  });

  /// The value of the given [FormInput].
  /// For example, if you have a `FormInput` for `FirstName`,
  /// the value could be 'Joe'.
  final T value;

  /// If the input has been modified.
  final bool isPure;

  String? get error => isPure ? null : validator(value);

  /// A function that must return a validation error if the provided
  /// [value] is invalid and `null` otherwise.
  String? validator(T value);

  @override
  bool operator ==(covariant FormInput<T> other) {
    if (identical(this, other)) return true;

    return other.value == value && other.isPure == isPure;
  }

  // ignore: member-ordering
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
