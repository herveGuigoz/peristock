import 'package:peristock/domain/entities/entities.dart';

abstract class ProductRepositoryInterface {
  Future<ProductSnapshot> searchProductByCode(String barcode);

  Future<List<ProductSnapshot>> searchProductsByName(String input, {ProductFilters? filters});
}
