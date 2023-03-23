import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/adapters/primaries/storage/storage.dart';
import 'package:peristock/adapters/secondaries/supabase/products.dart';
import 'package:peristock/adapters/secondaries/supabase/session.dart';
import 'package:peristock/adapters/secondaries/supabase/shopping.dart';
import 'package:peristock/adapters/secondaries/supabase/user.dart';
import 'package:peristock/domain/ports/products.dart';
import 'package:peristock/domain/ports/session.dart';
import 'package:peristock/domain/ports/shopping.dart';
import 'package:peristock/domain/ports/storage.dart';
import 'package:peristock/domain/ports/user.dart';

abstract class Dependency {
  static Provider<ShoppingRepositoryInterface> get shoppingRepository => _shoppingRepository;

  static Provider<ProductRepositoryInterface> get productRepository => _productRepository;

  static Provider<UserRepositoryInterface> get authRepository => _authRepository;

  static Provider<SessionRepositoryInterface> get sessionRepository => _sessionRepository;

  static Provider<StorageInterface> get storage => _storageInterface;
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

final _storageInterface = Provider<StorageInterface>(
  (ref) => Storage.instance,
  name: 'StorageInterfaceProvider',
);
