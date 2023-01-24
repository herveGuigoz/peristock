import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peristock/domain/domain.dart';
import 'package:peristock/presentation/di.dart';
import 'package:peristock/presentation/shared/form/form.dart';

part 'notifier.dart';
part 'state.dart';

typedef ProductProvider = Provider<Product?>;
typedef ProductFormNotifierProvider = AutoDisposeNotifierProvider<_ProductFormNotifier, ProductForm>;

abstract class ProductFormPresenter {
  static ProductProvider get product => _productProvider;

  static ProductFormNotifierProvider get state => _productForm;
}

final _productProvider = ProductProvider(
  (_) => null,
  name: 'ProductProvider',
);

final _productForm = ProductFormNotifierProvider(
  _ProductFormNotifier.new,
  dependencies: [_productProvider, Dependency.productRepository],
  name: 'ProductFormNotifierProvider',
);
