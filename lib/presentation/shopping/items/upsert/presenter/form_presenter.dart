import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:peristock/domain/entities/entities.dart';
import 'package:peristock/presentation/shared/form/form.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_presenter.freezed.dart';
part 'form_state.dart';

final snapshotProvider = Provider<ListItemSnapshot>((ref) => throw UnimplementedError());

final productFormNotifierProvider = AutoDisposeNotifierProvider<ProductFormNotifier, ProductFormState>(
  ProductFormNotifier.new,
  dependencies: [snapshotProvider],
);

class ProductFormNotifier extends AutoDisposeNotifier<ProductFormState> {
  @override
  ProductFormState build() => const ProductFormState();

  void nameChanged(String value) {
    final name = NameInput(value: value, isPure: false);
    state = state.copyWith(name: name);
  }

  void quantityChanged(String value) {
    final quantity = QuantityInput(value: value, isPure: false);
    state = state.copyWith(quantity: quantity);
  }

  void priceChanged(String value) {
    final price = PriceInput(value: value, isPure: false);
    state = state.copyWith(price: price);
  }

  void noteChanged(String value) {
    final note = NoteInput(value: value, isPure: false);
    state = state.copyWith(note: note);
  }

  Future<void> submit() async {
    if (!state.isValid && state.isPure) return;

    state = state.copyWith(status: const FormStatus.submissionInProgress());

    var snapshot = ref.read(snapshotProvider);
    snapshot = snapshot.copyWith(
      product: Product(
        name: state.name.value,
      ),
      quantity: int.parse(state.quantity.value),
      price: state.price.value.isNotEmpty ? double.parse(state.price.value) : null,
    );
  }
}
