import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShoppingListView extends ConsumerWidget {
  const ShoppingListView({super.key});

  static const String path = '/shopping';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('ShoppingList'),
      ),
    );
  }
}
