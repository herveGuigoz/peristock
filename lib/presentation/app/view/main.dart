import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/application/log/log.dart';
import 'package:peristock/presentation/products/read/products_list.dart';
import 'package:peristock/presentation/settings/settings.dart';
import 'package:peristock/presentation/shared/theme/theme.dart';
import 'package:peristock/presentation/shopping/lists/read/view/shopping_list.dart';
import 'package:peristock/presentation/trends/view/trends.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Destination {
  const Destination({required this.label, required this.path, required this.icon});

  final String label;
  final String path;
  final Widget icon;

  @override
  String toString() => 'Destination("$label", "$path")';
}

class Main extends ConsumerWidget {
  const Main({
    super.key,
    required this.child,
  });

  final Widget child;

  static const destinations = <Destination>[
    Destination(
      label: 'Products',
      path: ProductsListView.path,
      icon: Icon(PhosphorIcons.barcode),
    ),
    Destination(
      label: 'Wishlists',
      path: ShoppingListsView.path,
      icon: Icon(PhosphorIcons.shoppingCartSimple),
    ),
    Destination(
      label: 'Stocks',
      path: TrendsView.path,
      icon: Icon(PhosphorIcons.stack),
    ),
    Destination(
      label: 'Settings',
      path: SettingsView.path,
      icon: Icon(PhosphorIcons.gear),
    ),
  ];

  static int _computeCurrentIndex(BuildContext context) {
    final route = GoRouter.of(context);
    final location = route.location;

    return math.max(0, destinations.indexWhere((destination) => location.startsWith(destination.path)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = _computeCurrentIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          for (final destination in destinations)
            BottomNavigationBarItem(
              icon: destination.icon,
              label: destination.label,
            ),
        ],
        currentIndex: currentIndex,
        onTap: (index) => GoRouter.of(context).go(destinations[index].path),
      ),
    );
  }
}
