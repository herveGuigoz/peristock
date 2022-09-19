import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/presentation/products_list/view/products_list.dart';
import 'package:peristock/presentation/settings/settings.dart';
import 'package:peristock/presentation/shopping/views/shopping_list.dart';

class Main extends ConsumerWidget {
  const Main({
    super.key,
    required this.child,
  });

  final Widget child;

  static const destinations = <String>[
    ProductsListView.path,
    ShoppingListView.path,
    SettingsView.path,
  ];

  static int _computeCurrentIndex(BuildContext context) {
    final route = GoRouter.of(context);
    final location = route.location;

    return math.max(0, destinations.indexWhere(location.startsWith));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Stock',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Shopping',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _computeCurrentIndex(context),
        onTap: (index) => GoRouter.of(context).go(destinations[index]),
      ),
    );
  }
}
