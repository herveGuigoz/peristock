import 'dart:io';

import 'package:peristock/adapters/openapi_repository.dart';
import 'package:peristock/adapters/paginator.dart';
import 'package:peristock/domain/domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProductRepository extends OpenFoodFactsRepository implements ProductRepositoryInterface {
  SupabaseProductRepository(
    SupabaseClient supabaseClient,
  ) : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  static const String _table = 'Product';

  static const String _bucket = 'uploads';

  @override
  Future<Collection<Product>> findCollection({required int page, required int itemsPerPage}) async {
    try {
      final paginator = Paginator(currentPage: page, itemsPerPage: itemsPerPage);

      final response = await _supabaseClient
          .from(_table)
          .select()
          .range(paginator.offset, paginator.to)
          .execute(count: CountOption.exact);

      if (response.hasError) {
        throw GetProductsFailure(response.error!.message);
      }

      return Collection(
        items: [for (final item in response.data as List<dynamic>) ProductCodec.fromJson(item as Map<String, dynamic>)],
        totalItems: response.count!,
      );
    } catch (error) {
      throw GetProductsFailure(error);
    }
  }

  @override
  Future<Product> findItem({required int id}) async {
    final query = _supabaseClient.from(_table).select().eq('id', id);
    final response = await query.execute();

    if (response.hasError) {
      throw Exception(response.error); // todo
    }

    final json = response.data as List<dynamic>;

    if (json.isEmpty) {
      throw Exception('Product not found'); // todo
    }

    return ProductCodec.fromJson(json.first as Map<String, dynamic>);
  }

  @override
  Future<void> saveProduct({required ProductSnapshot value}) async {
    try {
      final response = await _supabaseClient.from(_table).upsert(ProductCodec.toJson(value)).execute();

      if (response.hasError) {
        throw SaveProductFailure(response.error!.message);
      }
    } catch (error) {
      throw SaveProductFailure(error);
    }
  }

  @override
  Future<void> deleteProduct({required int id}) async {
    await _supabaseClient.from(_table).delete().eq('id', id).execute();
  }

  @override
  Future<String> uploadImage({required String filePath}) async {
    final storage = _supabaseClient.storage.from(_bucket);
    final uri = Uri.parse(filePath);
    final path = uri.pathSegments.last;

    final response = await storage.upload(path, File(filePath));

    if (response.hasError) {
      throw UploadImageFailure(response.error!);
    }

    return storage.getPublicUrl(path).data!;
  }
}

abstract class ProductCodec {
  static Product fromJson(Map<String, dynamic> json) {
    return Product.fromJson(
      json
        ..['bestBeforeDate'] = json['best_before_date']
        ..['quantityType'] = json['quantity_type'],
    );
  }

  static Map<String, dynamic> toJson(ProductSnapshot instance) {
    return {
      if (instance.id != null) 'id': instance.id,
      'name': instance.name,
      'best_before_date': instance.bestBeforeDate?.toIso8601String(),
      'image': instance.image,
      'quantity': instance.quantity,
      'quantity_type': instance.quantityType.name,
    };
  }
}
