import 'package:peristock/domain/entities/entities.dart';
import 'package:peristock/domain/shared/collection.dart';

abstract class ProductRepositoryInterface {
  Future<Product> searchProductByCode(String barcode);

  Future<Product> searchProductByName(String input);

  Future<Collection<Product>> findCollection({required int page, required int itemsPerPage});

  Future<Product> findItem({required int id});

  Future<void> saveProduct({required ProductSnapshot value});

  Future<void> deleteProduct({required int id});

  Future<String> uploadImage({required String filePath});
}
