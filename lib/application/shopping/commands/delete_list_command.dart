import 'package:peristock/application/shared/command.dart';
import 'package:peristock/domain/domain.dart';

class DeleteShoppingListCommand implements CommandInterface {
  DeleteShoppingListCommand({required this.item});

  final ShoppingList item;
}
