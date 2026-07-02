import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../data/local_product_repository.dart';
import '../data/product_model.dart';
import '../data/product_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return LocalProductRepository(
    ref.read(appDatabaseProvider),
  );
});

final productsProvider =
FutureProvider.autoDispose<List<ProductModel>>((ref) async {
  return ref.read(productRepositoryProvider).getAllProducts();
});

final searchProductsProvider =
FutureProvider.family.autoDispose<List<ProductModel>, String>(
      (ref, query) async {
    if (query.trim().isEmpty) {
      return ref.read(productRepositoryProvider).getAllProducts();
    }

    return ref.read(productRepositoryProvider).searchProducts(query);
  },
);