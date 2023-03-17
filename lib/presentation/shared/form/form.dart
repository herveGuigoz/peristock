// ignore_for_file: strict_raw_type

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

  void onError(void Function(Object error) onError) {
    whenOrNull(submissionFailled: (error) => onError(error));
  }

  bool get isInProgress => this is _InProgress;

  bool get isSucceed => this is _Succeed;
}

/// Mixin that handles validation.
mixin FormMixin {
  List<FormInput<Object>?> get inputs;

  bool get isValid {
    return inputs.every((input) => input?.isValid ?? true);
  }

  bool get isPure {
    return inputs.every((input) => input?.isPure ?? true);
  }
}
