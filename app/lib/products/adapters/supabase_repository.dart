import 'dart:io';

import 'package:peristock/products/adapters/openapi_repository.dart';
import 'package:peristock/products/domain/products.dart';
import 'package:peristock/shared/domain/collection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProductRepository extends OpenFoodFactsRepository
    implements ProductRepositoryInterface {
  SupabaseProductRepository(
    SupabaseClient supabaseClient,
  ) : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  static const String _table = 'Product';

  static const String _bucket = 'uploads';

  @override
  Future<Collection<Product>> findCollection({required int page}) async {
    try {
      final paginator = Paginator(currentPage: page);

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
          for (final item in response.data as List<dynamic>)
            SupabaseProductCodec.fromJson(item as Map<String, dynamic>)
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

    return SupabaseProductCodec.fromJson(json.first as Map<String, dynamic>);
  }

  @override
  Future<void> saveProduct({required ProductSnapshot value}) async {
    try {
      final response = await _supabaseClient
          .from(_table)
          .insert(SupabaseProductCodec.toJson(value))
          .execute();

      if (response.hasError) {
        throw InsertProductFailure(response.error!.message);
      }
    } catch (error) {
      throw InsertProductFailure(error);
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

abstract class SupabaseProductCodec {
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

class Paginator {
  Paginator({
    required this.currentPage,
    this.itemsPerPage = 30,
  });

  final int currentPage;

  final int itemsPerPage;

  int get offset => (currentPage - 1) * itemsPerPage;

  int get to => (offset + itemsPerPage) - 1;
}
