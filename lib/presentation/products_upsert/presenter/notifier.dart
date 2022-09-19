part of 'presenter.dart';

class _ProductFormNotifier extends StateNotifier<ProductForm> {
  _ProductFormNotifier(this._read) : super(ProductForm.empty());

  _ProductFormNotifier.fromProduct(
    this._read, {
    required Product product,
  }) : super(ProductForm.fromProduct(product));

  final Reader _read;

  ProductRepositoryInterface get _productRepository => _read(Dependency.productRepository);

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      state = state.copyWith(image: Thumbnail.asset(photo.path));
    }
  }

  void setName(String value) {
    state = state.copyWith(name: ProductName(value));
  }

  void setBestBeforeDate(DateTime value) {
    state = state.copyWith(beforeDate: BestBeforeDate(value));
  }

  void setQuantity(int value) {
    state = state.copyWith(quantity: state.quantity.copyWith(value: value));
  }

  void setQuantityType(QuantityType value) {
    state = state.copyWith(quantity: state.quantity.copyWith(type: value));
  }

  void resetForm() {
    state = ProductForm.empty();
  }

  Future<void> submitForm() async {
    if (state.isValid) {
      state = state.copyWith(status: const FormStatus.submissionInProgress());
      try {
        final snapshot = await uploadImage();
        await _productRepository.saveProduct(value: snapshot);
        state = state.copyWith(status: const FormStatus.submissionSucceed());
      } catch (error) {
        state = state.copyWith(status: FormStatus.submissionFailled(error));
      }
    }
  }

  @protected
  Future<ProductSnapshot> uploadImage() async {
    final image = await state.image?.whenOrNull(
      asset: (path) => _productRepository.uploadImage(filePath: path),
    );

    return state.toSnapshot()
      ..copyWith(
        id: _read(_productProvider)?.id,
        image: image,
      );
  }
}
