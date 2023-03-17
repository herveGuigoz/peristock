import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/domain/entities/entities.dart';
import 'package:peristock/domain/providers/shopping.dart';
import 'package:peristock/presentation/shared/layouts/layouts.dart';
import 'package:peristock/presentation/shared/theme/theme.dart';

class ListItemsView extends ConsumerWidget {
  const ListItemsView({
    super.key,
    required this.id,
  });

  /// The id of the shopping list.
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.watch(shoppingListProvider(id));

    return Scaffold(
      body: future.when(
        data: ListItemsLayout.new,
        error: ErrorLayout.new,
        loading: LoadingLayout.new,
      ),
    );
  }
}

class ListItemsLayout extends ConsumerWidget {
  const ListItemsLayout(this.value, {super.key});

  final ShoppingList value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
         SliverAppBar(
          title: Text(value.name),
        ),
        SliverPadding(
          padding: EdgeInsets.all(theme.spacing.regular),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Text(value.items[index].name),
              childCount: value.items.length,
            ),
          ),
        ),
      ],
    );
  }
}
