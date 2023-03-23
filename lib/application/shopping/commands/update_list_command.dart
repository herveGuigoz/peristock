import 'package:peristock/application/shared/command.dart';

class UpdateShoppingListCommand extends CommandInterface {
  UpdateShoppingListCommand({required this.id, required this.name});

  final int id;

  final String name;
}
