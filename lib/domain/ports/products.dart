import 'package:peristock/domain/entities/entities.dart';

abstract class ProductRepositoryInterface {
  Future<Product> searchProductByCode(String barcode);

  Future<List<Product>> searchProductsByName(String input);
}
