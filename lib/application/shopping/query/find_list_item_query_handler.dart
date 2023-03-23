import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/application/di.dart';
import 'package:peristock/application/shopping/query/find_list_item_query.dart';
import 'package:peristock/domain/entities/entities.dart';

class FindShoppingListQueryHandler extends FamilyAsyncNotifier<ShoppingList, FindShoppingListQuery> {
  @override
  FutureOr<ShoppingList> build(FindShoppingListQuery arg) async {
    final result = await ref.read(Dependency.shoppingRepository).getListById(arg.id);
    
    return result;
  }
}
