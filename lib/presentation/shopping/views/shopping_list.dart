import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/presentation/shared/theme/theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ShoppingListView extends ConsumerWidget {
  const ShoppingListView({super.key});

  static const String path = '/shopping';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: theme.palette.secondaryContainer,
        onPressed: () {},
        child: const Icon(PhosphorIcons.plus),
      ),
      body: const Center(
        child: Text('ShoppingList'),
      ),
    );
  }
}
