import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/domain/entities/entities.dart';
import 'package:peristock/presentation/shared/layouts/layouts.dart';
import 'package:peristock/presentation/shopping/items/read/presenter/presenter.dart';
import 'package:peristock/presentation/shopping/items/upsert/view/upsert_item.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

class ShoppingListView extends ConsumerWidget {
  const ShoppingListView({
    super.key,
    required this.id,
  });

  static const String name = 'ShoppingListView';

  /// The id of the shopping list.
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final future = ref.watch(shoppingListProvider(id));

    return Scaffold(
      body: future.when(data: ShoppingListLayout.new, error: ErrorLayout.new, loading: LoadingLayout.new),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: theme.colorScheme.tertiary,
        onPressed: () => context.goNamed(CreateListItemView.name, params: {'id': '$id'}),
        child: const Icon(PhosphorIcons.plus),
      ),
    );
  }
}

class ShoppingListLayout extends ConsumerWidget {
  const ShoppingListLayout(this.value, {super.key});

  final ShoppingList value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(value.name),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListItemTile(value.listItems[index]),
            childCount: value.listItems.length,
          ),
        ),
      ],
    );
  }
}

class ListItemTile extends StatelessWidget {
  const ListItemTile(this.item, {super.key});

  final ListItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.product.name),
      onTap: () => ListItemActions.show(context, item: item),
    );
  }
}

class ListItemActions extends StatelessWidget {
  const ListItemActions({
    super.key,
    required this.item,
  });

  static Future<void> show(BuildContext context, {required ListItem item}) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (_) => ListItemActions(item: item),
      useRootNavigator: true,
    );
  }

  final ListItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTileTheme(
      data: ListTileThemeData(
        iconColor: theme.colorScheme.tertiary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(PhosphorIcons.pencil),
            title: const Text('Edit'),
            onTap: () => context.goNamed(EditListItemView.name, params: {'id': '${item.id}'}),
          ),
          const DeleteActionButon(),
        ],
      ),
    );
  }
}

class DeleteActionButon extends StatefulWidget {
  const DeleteActionButon({super.key});

  @override
  State<DeleteActionButon> createState() => _DeleteActionButonState();
}

class _DeleteActionButonState extends State<DeleteActionButon> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: const Icon(PhosphorIcons.trashSimple),
      title: tapped ? Text('Click to confirm', style: TextStyle(color: theme.colorScheme.error)) : const Text('Delete'),
      onTap: () {
        if (tapped) {
          context.pop();
        } else {
          setState(() => tapped = true);
        }
      },
    );
  }
}
