// ignore_for_file: format-comment
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/application/shopping/commands/create_list_command_handler.dart';
import 'package:peristock/application/shopping/commands/delete_list_command_handler.dart';
import 'package:peristock/application/shopping/commands/update_list_command_handler.dart';
import 'package:peristock/application/shopping/query/find_list_collection_query_handler.dart';
import 'package:peristock/application/shopping/query/find_list_item_query.dart';
import 'package:peristock/application/shopping/query/find_list_item_query_handler.dart';
import 'package:peristock/domain/entities/entities.dart';

// *
// QUERIES
// *
final findShoppingListQueryHandler =
    AsyncNotifierFamilyProvider<FindShoppingListQueryHandler, ShoppingList, FindShoppingListQuery>(
  FindShoppingListQueryHandler.new,
);

final findShoppingListsQueryHandler = AsyncNotifierProvider<FindShoppingListsQueryHandler, List<ShoppingList>>(
  FindShoppingListsQueryHandler.new,
);

// *
// * COMMANDS
// *
final createShoppingListCommandHandler = Provider<CreateShoppingListCommandHandler>(
  CreateShoppingListCommandHandler.new,
);

final updateShoppingListCommandHandler = Provider<UpdateShoppingListCommandHandler>(
  UpdateShoppingListCommandHandler.new,
);

final deleteShoppingListCommandHandler = Provider<DeleteShoppingListCommandHandler>(
  DeleteShoppingListCommandHandler.new,
);
