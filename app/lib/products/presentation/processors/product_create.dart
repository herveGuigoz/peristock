part of 'processors.dart';

class CreateProductProcessor extends ProductSnapshotProcessor {
  @override
  Future<Result<void>> submitForm(ProviderContainer container) async {
    if (state.name?.isEmpty ?? true) {
      return Result.failure(Exception('The name is required'));
    }

    final result = await CreateProduct(
      container.read(Dependency.productRepository),
    ).execute(state);

    result.onSuccess(
      (_) => container.invalidate(productsProvider.firstPage),
    );

    return result;
  }
}
