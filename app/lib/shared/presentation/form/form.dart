import 'package:freezed_annotation/freezed_annotation.dart';

part 'form.freezed.dart';
part 'inputs/inputs.dart';
part 'validators/validators.dart';

@freezed
class FormStatus with _$FormStatus {
  // Class representing the status of a form at any given point in time.
  const FormStatus._();

  /// Indicates whether the form is untouched.
  const factory FormStatus.untouched() = _Untouched;

  /// The form has been completely validated.
  const factory FormStatus.valid() = _Valid;

  /// The form contains one or more invalid inputs.
  const factory FormStatus.invalid() = _Invalid;

  /// The form is in the process of being submitted.
  const factory FormStatus.submissionInProgress() = _InProgress;

  /// The form has been submitted successfully.
  const factory FormStatus.submissionSuccess() = _Success;

  /// The form submission failed.
  const factory FormStatus.submissionFailure(Object error) = _Failure;

  bool get isValid => this is! _Untouched && this is! _Invalid;

  bool get isInProgress => this is _InProgress;

  void onError(void Function(Object error) onError) {
    whenOrNull(submissionFailure: (error) => onError(error));
  }
}

/// Mixin that handles validation.
mixin FormMixin {
  /// Returns a [FormStatus] given a list of [FormInput].
  @protected
  // ignore: strict_raw_type
  FormStatus validate(List<FormInput> inputs) {
    return inputs.every((element) => element.pure)
        ? const FormStatus.untouched()
        : inputs.any((input) => input.valid == false)
            ? const FormStatus.invalid()
            : const FormStatus.valid();
  }
}
