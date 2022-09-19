part of 'presenter.dart';

class ProductForm extends Equatable with FormMixin {
  ProductForm._({
    this.status = const FormStatus.initial(),
    required this.name,
    required this.beforeDate,
    required this.quantity,
    this.image,
  });

  ProductForm.fromProduct(Product product)
      : status = const FormStatus.initial(),
        name = ProductName.initial(product.name),
        beforeDate = BestBeforeDate.initial(product.bestBeforeDate),
        quantity = Quantity.initial(product.quantity, product.quantityType),
        image = product.thumbnail;

  ProductForm.empty()
      : status = const FormStatus.initial(),
        name = const ProductName.initial(),
        beforeDate = BestBeforeDate.initial(),
        quantity = const Quantity.initial(),
        image = null;

  final FormStatus status;
  final ProductName name;
  final BestBeforeDate beforeDate;
  final Quantity quantity;
  final Thumbnail? image;

  @override
  List<Object?> get props => [status, name, beforeDate, quantity, image];

  @override
  List<FormInput<Object>?> get inputs => [name, beforeDate, quantity, image];

  ProductForm copyWith({
    FormStatus? status,
    ProductName? name,
    BestBeforeDate? beforeDate,
    Quantity? quantity,
    Thumbnail? image,
  }) {
    return ProductForm._(
      status: status ?? this.status,
      name: name ?? this.name,
      beforeDate: beforeDate ?? this.beforeDate,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
    );
  }

  ProductSnapshot toSnapshot() {
    return ProductSnapshot(
      name: name.value,
      bestBeforeDate: beforeDate.value,
      quantity: quantity.value,
      quantityType: quantity.type,
      image: image?.whenOrNull(network: (path) => path),
    );
  }
}

class ProductName extends FormInput<String> {
  const ProductName(super.value);

  const ProductName.initial([super.value = '']) : super.initial();

  @override
  String? validator(String value) {
    if (value.isEmpty) return 'Name is required';

    return null;
  }
}

class BestBeforeDate extends FormInput<DateTime> {
  const BestBeforeDate(super.value);

  BestBeforeDate.initial([
    DateTime? date,
  ]) : super.initial(date ?? DateTime.now());

  @override
  String? validator(DateTime value) {
    final daysLeft = value.difference(DateTime.now()).inDays;

    return daysLeft < 1
        ? 'La DLC ne peut pas être infèrieur ou égale à la date du jour.'
        : null;
  }
}

class Quantity extends FormInput<int> with EquatableMixin {
  const Quantity(super.value, [this.type = QuantityType.qt]);

  const Quantity.initial([super.value = 1, this.type = QuantityType.qt])
      : super.initial();

  final QuantityType type;

  @override
  String? validator(int value) {
    if (value < 1) return 'Quantity is missing';
    return null;
  }

  Quantity copyWith({int? value, QuantityType? type}) {
    return Quantity(value ?? this.value, type ?? this.type);
  }

  @override
  List<Object?> get props => [value, type];
}

abstract class Thumbnail extends FormInput<String> {
  const Thumbnail._(super.value, {super.isPure});

  const factory Thumbnail.network(String path) = _NetworkImage;

  const factory Thumbnail.asset(String path) = _AssetImage;

  T? whenOrNull<T>({
    T Function(String path)? network,
    T Function(String path)? asset,
  });

  @override
  String? validator(String? value) => null;
}

class _NetworkImage extends Thumbnail {
  const _NetworkImage(super.path) : super._(isPure: true);

  @override
  T? whenOrNull<T>({
    T Function(String path)? network,
    T Function(String path)? asset,
  }) {
    return network?.call(value);
  }
}

class _AssetImage extends Thumbnail {
  const _AssetImage(super.path) : super._(isPure: false);

  @override
  T? whenOrNull<T>({
    T Function(String path)? network,
    T Function(String path)? asset,
  }) {
    return asset?.call(value);
  }
}

extension on Product {
  Thumbnail? get thumbnail {
    return image != null ? Thumbnail.network(image!) : null;
  }
}
