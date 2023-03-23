import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/presentation/settings/settings.dart';
import 'package:peristock/presentation/shopping/lists/read/shopping_lists_view.dart';
import 'package:peristock/presentation/trends/view/trends.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Destination {
  const Destination({required this.label, required this.name, required this.icon});

  final String label;
  final String name;
  final Widget icon;

  @override
  String toString() => 'Destination("$label", "$name")';
}

class Main extends ConsumerWidget {
  const Main({
    required this.child,
    super.key,
  });

  static int _computeCurrentIndex(BuildContext context) {
    final router = GoRouter.of(context);
    final location = router.location;

    return math.max(0, destinations.indexWhere((destination) => router.namedLocation(destination.name) == location));
  }

  static const destinations = <Destination>[
    Destination(
      label: 'Shopping lists',
      name: ShoppingListsView.name,
      icon: Icon(PhosphorIcons.shoppingCartSimple),
    ),
    Destination(
      label: 'Stocks',
      name: TrendsView.name,
      icon: Icon(PhosphorIcons.stack),
    ),
    Destination(
      label: 'Settings',
      name: SettingsView.name,
      icon: Icon(PhosphorIcons.gear),
    ),
  ];

  final Widget child;

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
        onTap: (index) => GoRouter.of(context).goNamed(destinations[index].name),
        currentIndex: currentIndex,
      ),
    );
  }
}
