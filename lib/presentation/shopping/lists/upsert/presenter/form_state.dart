part of 'form_presenter.dart';

@freezed
class ShoppingListFormState with _$ShoppingListFormState, FormMixin {
  const factory ShoppingListFormState.create({
    @Default(ListName.initial()) ListName name,
    @Default(FormStatus.initial()) FormStatus status,
  }) = CreateShoppingListFormState;

  const factory ShoppingListFormState.edit({
    required ListName name,
    @Default(FormStatus.initial()) FormStatus status,
  }) = EditShoppingListFormState;

  const ShoppingListFormState._();

  @override
  List<FormInput<Object>?> get inputs => [name];
}

class ListName extends FormInput<String> {
  const ListName(String value) : super(value: value, isPure: false);

  const ListName.initial([String value = '']) : super(value: value, isPure: true);

  @override
  String? validator(String value) => value.isEmpty ? 'Name cannot be empty' : null;
}
