part of 'processors.dart';

typedef ProductSnapshotProvider = AutoDisposeStateNotifierProvider<
    ProductSnapshotProcessor, ProductSnapshot>;

final productSnapshotProvider = ProductSnapshotProvider(
  (ref) => throw UnimplementedError(),
);

abstract class ProductSnapshotProcessor extends StateNotifier<ProductSnapshot> {
  ProductSnapshotProcessor([super.state = const ProductSnapshot()]);

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      state = state.copyWith(asset: photo.path);
    }
  }

  void setName(String value) {
    state = state.copyWith(name: value);
  }

  void setBestBeforeDate([DateTime? value]) {
    state = state.copyWith(bestBeforeDate: value);
  }

  void setQuantity(int value) {
    state = state.copyWith(quantity: value);
  }

  void setQuantityType(QuantityType value) {
    state = state.copyWith(quantityType: value);
  }

  Future<Result<void>> submitForm(ProviderContainer container);
}
