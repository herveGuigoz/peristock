import 'package:peristock/domain/providers/shopping.dart';

abstract class ShoppingListPresenter {
  static dynamic get state => shoppingListsProvider;
}
