import 'package:peristock/application/shared/query.dart';

class FindShoppingListsQuery implements QueryInterface {
  const FindShoppingListsQuery({this.page = 1});

  final int page;
}
