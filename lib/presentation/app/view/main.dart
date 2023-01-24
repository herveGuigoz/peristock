import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/presentation/products_list/view/products_list.dart';
import 'package:peristock/presentation/settings/settings.dart';
import 'package:peristock/presentation/shopping/views/shopping_list.dart';
import 'package:peristock/presentation/trends/view/trends.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Main extends ConsumerWidget {
  const Main({
    super.key,
    required this.child,
  });

  final Widget child;

  static const destinations = <String>[
    ProductsListView.path,
    ShoppingListView.path,
    TrendsView.path,
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
            icon: Icon(PhosphorIcons.stack),
            label: 'Stock',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.shoppingCartSimple),
            label: 'Wishes',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.trendUp),
            label: 'Trends',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.gear),
            label: 'Settings',
          ),
        ],
        currentIndex: _computeCurrentIndex(context),
        onTap: (index) => GoRouter.of(context).go(destinations[index]),
      ),
    );
  }
}
