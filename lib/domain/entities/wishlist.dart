part of 'entities.dart';

@freezed
class Wishlist with _$Wishlist {
  const factory Wishlist({
    required int id,
    required String name,
    required List<Product> products,
    String? image,
  }) = _Wishlist;

  factory Wishlist.fromJson(Map<String, dynamic> json) => _$WishlistFromJson(json);
}

@freezed
class WishlistSnapshot with _$WishlistSnapshot {
  const factory WishlistSnapshot({
    int? id,
    String? name,
    @Default([]) List<Product> products,
    String? image,
  }) = _WishlistSnapshot;
}
