import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/shopping_items_table.dart';

part 'shopping_dao.g.dart';

@DriftAccessor(tables: [ShoppingItems])
class ShoppingDao extends DatabaseAccessor<AppDatabase>
    with _$ShoppingDaoMixin {
  ShoppingDao(super.db);
  Future<int> insertItem(
      ShoppingItemsCompanion item,
      ) {
    return into(shoppingItems).insert(item);
  }

  Future<void> insertOrUpdateItem(
      ShoppingItemsCompanion item,
      ) async {
    final uuid = item.uuid.value;

    final existing = await (select(shoppingItems)
      ..where((t) => t.uuid.equals(uuid)))
        .getSingleOrNull();

    if (existing == null) {
      await into(shoppingItems).insert(item);
    } else {
      await (update(shoppingItems)
        ..where((t) => t.uuid.equals(uuid)))
          .write(item);
    }
  }

  Future<List<ShoppingItem>> getPendingSyncItems() {
    return (select(shoppingItems)
      ..where((t) => t.isSynced.equals(false)))
        .get();
  }

  Future<void> markItemSynced(String uuid) {
    return (update(shoppingItems)
      ..where((t) => t.uuid.equals(uuid)))
        .write(
      const ShoppingItemsCompanion(
        isSynced: Value(true),
      ),
    );
  }

  Future<void> markItemPending(String uuid) {
    return (update(shoppingItems)
      ..where((t) => t.uuid.equals(uuid)))
        .write(
      const ShoppingItemsCompanion(
        isSynced: Value(false),
      ),
    );
  }

  Future<void> deleteByUuid(String uuid) async {
    await (delete(shoppingItems)
      ..where((t) => t.uuid.equals(uuid)))
        .go();
  }

  Future<List<ShoppingItem>> getAllItems() {
    return (select(shoppingItems)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([
            (t) => OrderingTerm.asc(t.category),
            (t) => OrderingTerm.asc(t.isPurchased),
            (t) => OrderingTerm.asc(t.name),
      ]))
        .get();
  }

  Stream<List<ShoppingItem>> watchItems() {
    return (select(shoppingItems)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([
            (t) => OrderingTerm.asc(t.category),
            (t) => OrderingTerm.asc(t.isPurchased),
            (t) => OrderingTerm.asc(t.name),
      ]))
        .watch();
  }
}