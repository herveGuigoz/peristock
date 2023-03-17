import 'package:peristock/adapters/openfoodfacts/openfoodfacts.dart';
import 'package:peristock/adapters/openfoodfacts/product.dto.dart';
import 'package:peristock/domain/entities/entities.dart';
import 'package:peristock/domain/exceptions/exceptions.dart';
import 'package:peristock/domain/ports/products.dart';
import 'package:peristock/domain/shared/types.dart';

class ProductRepository extends OpenFoodFactsRepository implements ProductRepositoryInterface {
  static const _kDefaultFields = 'code,product_name,nutriments,nutriscore_grade,ecoscore_grade,image_front_small_url';

  @override
  Future<Product> searchProductByCode(String barcode) async {
    final url = buildURL(
      service: 'api',
      ressource: 'product',
      parameters: {'barcode': barcode, 'fields': _kDefaultFields},
    );

    final response = await fetch<Json>(url);

    if (response.data?['status'] != 'success') {
      throw ProductNotFoundException(barcode);
    }

    final json = response.data!['product'] as Json;

    return ProductDto.fromJson(json).toDomain();
  }

  @override
  Future<List<Product>> searchProductsByName(String input) async {
    final parameters = {
      'search_terms': input.trim(),
      'fields': _kDefaultFields,
      'page': 1,
      'page_size': 20,
      'sort_by': 'unique_scans',
    };

    final url = buildURL(service: 'cgi', ressource: 'search.pl', parameters: parameters);

    final response = await fetch<Json>(url);

    final json = response.data!['products'] as List<dynamic>;

    return [
      for (final product in json) ProductDto.fromJson(product as Json).toDomain(),
    ];
  }
}
