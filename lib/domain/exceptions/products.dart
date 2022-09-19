class ProductDoesNotExistException implements Exception {
  ProductDoesNotExistException(this.code);

  final String code;

  @override
  String toString() => 'Product does not exist ($code)';
}

class GetProductsFailure implements Exception {
  const GetProductsFailure(this.error);

  /// Original faillure for debug
  final Object error;

  @override
  String toString() => 'An unexpected error occured';
}

class SaveProductFailure implements Exception {
  const SaveProductFailure(this.error);

  /// Original faillure for debug
  final Object error;

  @override
  String toString() => 'An unexpected error occured';
}

class UploadImageFailure implements Exception {
  UploadImageFailure(this.error);

  /// Original faillure for debug
  final Object error;

  @override
  String toString() => 'An unexpected error occured';
}

class ServerDownException implements Exception {
  @override
  String toString() => 'Server is down';
}

class InvalidDLCException implements Exception {
  @override
  String toString() {
    return 'La DLC ne peut pas être infèrieur ou égale à la date du jour.';
  }
}
