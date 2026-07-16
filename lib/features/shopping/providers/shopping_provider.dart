import '../../products/providers/product_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../data/local_shopping_repository.dart';
import '../data/shopping_sync_repository.dart';
import '../data/shopping_item_model.dart';
import '../data/shopping_repository.dart';

final shoppingRepositoryProvider =
Provider<ShoppingRepository>((ref) {
  return LocalShoppingRepository(
    ref.read(appDatabaseProvider),
  );
});

final shoppingSyncRepositoryProvider =
Provider<ShoppingSyncRepository>((ref) {
  return ShoppingSyncRepository(
    ref.read(appDatabaseProvider),
  );
});

final shoppingItemsProvider =
StreamProvider.autoDispose<List<ShoppingItemModel>>(
      (ref) {
    return ref
        .read(shoppingRepositoryProvider)
        .watchItems();
  },
);