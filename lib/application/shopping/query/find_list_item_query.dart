import 'package:peristock/application/shared/query.dart';

class FindShoppingListQuery implements QueryInterface {
  const FindShoppingListQuery(this.id);

  final int id;
}
