import 'dart:async';

import 'package:peristock/adapters/secondaries/supabase/supabase.dart';
import 'package:peristock/application/logger/logger.dart';
import 'package:peristock/domain/domain.dart';
import 'package:peristock/domain/ports/shopping.dart';

class ShoppingRepository extends SupabaseRepository implements ShoppingRepositoryInterface {
  ShoppingRepository();

  @override
  Future<ShoppingList> createList(ShoppingListSnapshot snapshot) async {
    final response = await post(
      '/rest/v1/shopping_lists',
      headers: {'Content-Type': 'application/json', 'Prefer': 'return=representation'},
      queryParameters: {'select': '*, list_items(*)'},
      body: snapshot.toJson(),
    );

    if (response.statusCode != 201) {
      throw BadRequestException(response.toString());
    }

    return ShoppingList.fromJson((response.body! as List<Object>)[0] as Json);
  }

  @override
  FutureOr<void> createListItem(ListItemSnapshot snapshot) async {
    final response = await post(
      '/rest/v1/list_items',
      headers: {'Content-Type': 'application/json', 'Prefer': 'return=representation'},
      body: snapshot.toJson(),
    );

    if (response.statusCode != 201) {
      throw BadRequestException(response.toString());
    }
  }

  @override
  FutureOr<void> deleteList(ShoppingList item) async {
    final response = await delete('/rest/v1/shopping_lists', queryParameters: {'id': 'eq.${item.id}'});

    if (response.statusCode != 204) {
      throw BadRequestException(response.toString());
    }
  }

  @override
  FutureOr<void> deleteListItem(ListItem item) async {
    final response = await delete('/rest/v1/list_items', queryParameters: {'id': 'eq.${item.id}'});

    if (response.statusCode != 204) {
      throw BadRequestException(response.toString());
    }
  }

  @override
  Future<ShoppingList> getListById(int id) async {
    final response = await get(
      '/rest/v1/shopping_lists',
      queryParameters: {'select': '*, list_items(*)', 'id': 'eq.$id'},
    );

    if (response.statusCode != 200 || response.body is! List<Object> || (response.body! as List<Object>).isEmpty) {
      throw const BadRequestException();
    }

    return ShoppingList.fromJson((response.body! as List<Object>).first as Json);
  }

  @override
  Future<ListItem> getListItemById(int id) async {
    final response = await get(
      '/rest/v1/list_items',
      queryParameters: {'select': '*', 'id': 'eq.$id'},
    );

    if (response.statusCode != 200 || response.body is! List<Object> || (response.body! as List<Object>).isEmpty) {
      throw BadRequestException(response.toString());
    }

    return ListItem.fromJson((response.body! as List<Object>).first as Json);
  }

  @override
  Future<List<ShoppingList>> getListsCollection() async {
    final response = await get(
      '/rest/v1/shopping_lists',
      queryParameters: {
        'select': '*, list_items(*)',
        'order': 'created_at.desc',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response);
    }

    return (response.body! as List<Object>).map((e) => ShoppingList.fromJson(e as Json)).toList();
  }

  @override
  FutureOr<ShoppingList> updateList(ShoppingListSnapshot snapshot) async {
    final response = await patch(
      '/rest/v1/shopping_lists',
      headers: {'Content-Type': 'application/json', 'Prefer': 'return=representation'},
      queryParameters: {'id': 'eq.${snapshot.id}', 'select': '*, list_items(*)'},
      body: snapshot.toJson(),
    );

    response.log();

    if (response.statusCode != 200) {
      Error.throwWithStackTrace(BadRequestException(response.toString()), StackTrace.current);
    }

    return ShoppingList.fromJson((response.body! as List<Object>)[0] as Json);
  }

  @override
  FutureOr<void> updateListItem(ListItemSnapshot snapshot) {
    throw UnimplementedError();
  }
}
