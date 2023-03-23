import 'package:peristock/application/shared/command.dart';

class CreateShoppingListCommand implements CommandInterface {
  CreateShoppingListCommand({required this.name});

  final String name;
}
