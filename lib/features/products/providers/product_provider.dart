import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../data/product_model.dart';
import '../data/product_repository.dart';
import '../data/local_product_repository.dart';
import '../data/supabase_product_repository.dart';
import '../data/product_sync_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return LocalProductRepository(
    ref.read(appDatabaseProvider),
  );
});
final productSyncRepositoryProvider =
Provider<ProductSyncRepository>((ref) {
  return ProductSyncRepository(
    ref.read(appDatabaseProvider),
  );
});

/// Realtime Products
final productsProvider =
StreamProvider.autoDispose<List<ProductModel>>((ref) {
  return ref.read(productRepositoryProvider).watchProducts();
});

/// Search
final searchProductsProvider =
FutureProvider.family.autoDispose<List<ProductModel>, String>(
      (ref, query) async {
    final repo = ref.read(productRepositoryProvider);

    if (query.trim().isEmpty) {
      return await repo.getAllProducts();
    }

    return await repo.searchProducts(query);
  },
);