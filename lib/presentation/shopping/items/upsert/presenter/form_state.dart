part of 'form_presenter.dart';

@freezed
class ProductFormState with _$ProductFormState, FormMixin {
  const factory ProductFormState({
    @Default(FormStatus.initial()) FormStatus status,
    @Default(NameInput()) NameInput name,
    @Default(QuantityInput()) QuantityInput quantity,
    @Default(PriceInput()) PriceInput price,
    @Default(NoteInput()) NoteInput note,
  }) = _ProductFormState;

  factory ProductFormState.fromSnapshot(ListItemSnapshot snapshot) {
    return ProductFormState(
      name: NameInput(value: snapshot.product?.name ?? ''),
      quantity: QuantityInput(value: snapshot.quantity?.toString() ?? ''),
      price: PriceInput(value: snapshot.price?.toString() ?? ''),
      note: const NoteInput(),
    );
  }

  const ProductFormState._();

  @override
  List<FormInput<Object>?> get inputs => [name, quantity, price, note];
}

class NameInput extends FormInput<String> with RegexValidator {
  const NameInput({super.value = '', super.isPure = true});

  @override
  String get message => 'This field is required.';

  @override
  String get pattern => r'^\S.*$';
}

class QuantityInput extends FormInput<String> with RegexValidator {
  const QuantityInput({super.value = '', super.isPure = true});

  @override
  String get message => 'This field is required.';

  @override
  String get pattern => r'^[\d*\.?\d*]{1,}$';
}

class PriceInput extends FormInput<String> {
  const PriceInput({super.value = '', super.isPure = true});

  @override
  String? validator(String value) => null;
}

class NoteInput extends FormInput<String> {
  const NoteInput({super.value = '', super.isPure = true});

  @override
  String? validator(String value) => null;
}
