import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/domain/entities/entities.dart';
import 'package:peristock/presentation/di.dart';

final searchProductsProvider = FutureProvider.family<List<Product>, String>(
  (ref, query) async => ref.read(Dependency.productRepository).searchProductsByName(query),
);

final filtersProvider = StateNotifierProvider<FiltersNotifier, List<Filter>>(
  (ref) => FiltersNotifier(),
);

class FiltersNotifier extends StateNotifier<List<Filter>> {
  FiltersNotifier() : super(_kDefaultFilters);

  static const List<Filter> _kDefaultFilters = [
    Filter(name: 'Name', key: 'name'),
    Filter(name: 'Brand', key: 'brand'),
    Filter(name: 'Category', key: 'category'),
    Filter(name: 'Price', key: 'price'),
  ];

  void operator []=(String key, String value) {
    final index = state.indexWhere((filter) => filter.key == key);

    if (index == -1) return;

    state = [
      ...state.sublist(0, index),
      state[index].copyWith(value: value),
      ...state.sublist(index + 1),
    ];
  }
}

@immutable
class Filter {
  const Filter({
    required this.name,
    required this.key,
    this.value,
  });

  final String name;

  final String key;

  final String? value;

  Filter copyWith({required String value}) {
    return Filter(name: name, key: key, value: value);
  }

  @override
  bool operator ==(covariant Filter other) {
    if (identical(this, other)) return true;

    return other.name == name && other.key == key && other.value == value;
  }

  @override
  int get hashCode => name.hashCode ^ key.hashCode ^ value.hashCode;
}
