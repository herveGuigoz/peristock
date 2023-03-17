import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/adapters/supabase/products.dart';
import 'package:peristock/adapters/supabase/session.dart';
import 'package:peristock/adapters/supabase/shopping.dart';
import 'package:peristock/adapters/supabase/user.dart';
import 'package:peristock/domain/domain.dart';
import 'package:peristock/domain/ports/ports.dart';
import 'package:peristock/domain/ports/shopping.dart';

abstract class Dependency {
  static Provider<ShoppingRepositoryInterface> get shoppingRepository => _shoppingRepository;

  static Provider<ProductRepositoryInterface> get productRepository => _productRepository;

  static Provider<UserRepositoryInterface> get authRepository => _authRepository;

  static Provider<SessionRepositoryInterface> get sessionRepository => _sessionRepository;
}

final _shoppingRepository = Provider<ShoppingRepositoryInterface>(
  (ref) => ShoppingRepository(),
  name: 'WishesRepositoryProvider',
);

final _productRepository = Provider<ProductRepositoryInterface>(
  (ref) => ProductRepository(),
  name: 'ProductRepositoryProvider',
);

final _authRepository = Provider<UserRepositoryInterface>(
  (ref) => UserRepository(),
  name: 'UserRepositoryProvider',
);

final _sessionRepository = Provider<SessionRepositoryInterface>(
  (ref) => SessionRepository(),
  name: 'SessionRepositoryProvider',
);
