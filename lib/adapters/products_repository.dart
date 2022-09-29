import 'dart:io';

import 'package:peristock/adapters/dtos/product.dart';
import 'package:peristock/adapters/openapi_repository.dart';
import 'package:peristock/adapters/paginator.dart';
import 'package:peristock/domain/domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProductRepository extends OpenFoodFactsRepository implements ProductRepositoryInterface {
  SupabaseProductRepository(
    SupabaseClient supabaseClient,
  ) : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  static const String _table = 'product';

  static const String _bucket = 'thumbnails';

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
        items: [
          for (final item in response.data as List<dynamic>) SupabseProduct.fromJson(item as Json).toDomain(),
        ],
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

    return SupabseProduct.fromJson(json.first as Json).toDomain();
  }

  @override
  Future<void> saveProduct({required ProductSnapshot value}) async {
    try {
      final response = await _supabaseClient.from(_table).upsert({
        if (value.id != null) 'id': value.id,
        'name': value.name,
        'best_before_date': value.bestBeforeDate?.toIso8601String(),
        'image': value.image,
        'quantity': value.quantity,
        'quantity_type': value.quantityType.name,
      }).execute();

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
