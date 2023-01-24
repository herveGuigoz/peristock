import 'package:peristock/domain/entities/entities.dart';
import 'package:peristock/domain/ports/products_repository.dart';
import 'package:peristock/domain/shared/collection.dart';

class ProductRepository implements ProductRepositoryInterface {
  @override
  Future<void> deleteProduct({required int id}) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Collection<Product>> findCollection({required int page, required int itemsPerPage}) async {
    return Collection.empty();
  }

  @override
  Future<Product> findItem({required int id}) {
    // TODO: implement findItem
    throw UnimplementedError();
  }

  @override
  Future<void> saveProduct({required ProductSnapshot value}) {
    // TODO: implement saveProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> searchProductByCode(String barcode) {
    // TODO: implement searchProductByCode
    throw UnimplementedError();
  }

  @override
  Future<Product> searchProductByName(String input) {
    // TODO: implement searchProductByName
    throw UnimplementedError();
  }

  @override
  Future<String> uploadImage({required String filePath}) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }
}
