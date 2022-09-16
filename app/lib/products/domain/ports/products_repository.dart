import 'package:peristock/products/domain/entities/entities.dart';
import 'package:peristock/shared/domain/domain.dart';

abstract class ProductRepositoryInterface {
  Future<Product> searchProductByCode(String barcode);

  Future<Product> searchProductByName(String input);

  Future<Collection<Product>> findCollection({required int page});

  Future<Product> findItem({required int id});

  Future<void> saveProduct({required ProductSnapshot value});

  Future<void> deleteProduct({required int id});

  Future<String> uploadImage({required String filePath});
}
