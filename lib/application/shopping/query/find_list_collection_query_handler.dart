import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/application/di.dart';
import 'package:peristock/domain/entities/entities.dart';

class FindShoppingListsQueryHandler extends AsyncNotifier<List<ShoppingList>> {
  FindShoppingListsQueryHandler();

  @override
  FutureOr<List<ShoppingList>> build() async {
    final result = await ref.read(Dependency.shoppingRepository).getListsCollection();
    
    return result;
  }
}
