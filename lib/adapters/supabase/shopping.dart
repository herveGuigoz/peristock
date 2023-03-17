import 'dart:async';

import 'package:peristock/adapters/supabase/supabase.dart';
import 'package:peristock/domain/domain.dart';
import 'package:peristock/domain/ports/shopping.dart';

class ShoppingRepository extends SupabaseRepository implements ShoppingRepositoryInterface {
  @override
  Future<List<ShoppingList>> findAll() async {
    final response = await get<List<dynamic>>(
      '/rest/v1/lists',
      queryParameters: {
        'select': '*, list_items(*)',
        'order': 'created_at.desc',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response);
    }

    return response.body.map((e) => ShoppingList.fromJson(e as Json)).toList();
  }

  @override
  FutureOr<void> createList(ShoppingListSnapshot snapshot) async {
    await post<void>('/rest/v1/lists', body: snapshot.toJson());
  }

  @override
  FutureOr<ShoppingList> updateList(ShoppingListSnapshot snapshot) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  FutureOr<void> addItem(ListItemSnapshot snapshot) async {
    await post<void>('/rest/v1/items', body: snapshot.toJson());
  }

  @override
  FutureOr<void> deleteList(ShoppingList list) {
    // TODO: implement deleteList
    throw UnimplementedError();
  }
}
