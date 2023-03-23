import 'package:peristock/adapters/secondaries/openfoodfacts/dto/product.dto.dart';
import 'package:peristock/adapters/secondaries/openfoodfacts/openfoodfacts.dart';
import 'package:peristock/application/logger/logger.dart';
import 'package:peristock/domain/entities/entities.dart';
import 'package:peristock/domain/exceptions/exceptions.dart';
import 'package:peristock/domain/ports/products.dart';
import 'package:peristock/domain/shared/types.dart';

class ProductRepository extends OpenFoodFactsRepository implements ProductRepositoryInterface {
  static const _kDefaultFields = 'code,product_name,nutriments,nutriscore_grade,ecoscore_grade,image_front_small_url';

  @override
  Future<ProductSnapshot> searchProductByCode(String barcode) async {
    final url = buildURL(
      service: 'api',
      ressource: 'product',
      parameters: {'barcode': barcode, 'fields': _kDefaultFields},
    );

    final response = await get(url);

    if ((response.body as Json?)?['status'] != 'success') {
      throw ProductNotFoundException(barcode);
    }

    final json = (response.body! as Json)['product'] as Json;

    return ProductDto.fromJson(json).toDomain();
  }

  @override
  Future<List<ProductSnapshot>> searchProductsByName(String input, {ProductFilters? filters}) async {
    filters.log();

    final parameters = {
      'search_terms': input.trim(),
      'fields': _kDefaultFields,
      'page': 1,
      'page_size': 20,
      'sort_by': 'unique_scans',
      'brands_tags': filters?.brand?.trim(),
      'stores_tags': filters?.store?.trim(),
      'nutrition_grades_tags': filters?.nutriscore?.name,
    }..removeWhere((key, value) => null == value);

    final url = buildURL(service: 'cgi', ressource: 'search.pl', parameters: parameters);

    final response = await get(url);

    if (response.statusCode != 200) {
      throw Exception('Error while searching products by name');
    }

    final json = (response.body! as Json)['products'] as List<Object>;

    return [
      for (final product in json) ProductDto.fromJson(product as Json).toDomain(),
    ];
  }
}
