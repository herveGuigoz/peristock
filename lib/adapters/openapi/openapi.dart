import 'package:dio/dio.dart';
import 'package:peristock/domain/domain.dart';

typedef Json = Map<String, dynamic>;

abstract class OpenFoodFactsRepository {
  OpenFoodFactsRepository() {
    _dio = Dio()
      ..options = BaseOptions(
        baseUrl: 'https://fr.openfoodfacts.org/api/v0',
        headers: {'User-Agent': 'Periscope - Android - 1.0'},
        validateStatus: (status) => true,
      );
  }

  late final Dio _dio;

  Future<Product> searchProductByCode(String barcode) async {
    final response = await _dio.get<Json>(
      '/product/$barcode.json',
    );

    if (response.statusCode != 200) {
      throw ServerDownException();
    }

    if ((response.data?['status'] as int? ?? 0) != 1) {
      throw ProductDoesNotExistException(barcode);
    }

    final json = response.data!['product'] as Json;

    return Product(
      id: int.parse(barcode),
      name: json['product_name'] as String,
      bestBeforeDate: DateTime.now(),
      quantity: 1, // todo
      image: json['image_front_small_url'] as String?,
    );
  }

  Future<Product> searchProductByName(String input) async {
    // todo: implement searchProduct
    throw UnimplementedError();
  }
}
