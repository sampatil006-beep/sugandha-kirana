import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import 'shopping_item_model.dart';
import 'shopping_repository.dart';

class LocalShoppingRepository implements ShoppingRepository {
  final AppDatabase database;

  static const Uuid _uuid = Uuid();

  LocalShoppingRepository(this.database);

  ShoppingItemModel _map(ShoppingItem row) {
    return ShoppingItemModel(
      id: row.id,
      uuid: row.uuid,
      name: row.name,
      category: row.category,
      isPurchased: row.isPurchased,
      isSynced: row.isSynced,
      deletedAt: row.deletedAt,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  @override
  Future<List<ShoppingItemModel>> getAllItems() async {
    final list = await database.shoppingDao.getAllItems();
    return list.map(_map).toList();
  }

  @override
  Stream<List<ShoppingItemModel>> watchItems() {
    return database.shoppingDao
        .watchItems()
        .map((e) => e.map(_map).toList());
  }

  @override
  Future<void> addItem(ShoppingItemModel item) async {
    final uuid =
    item.uuid.isEmpty ? _uuid.v4() : item.uuid;

    await database.into(database.shoppingItems).insert(
      ShoppingItemsCompanion.insert(
        uuid: uuid,
        name: item.name,
        category: drift.Value(item.category),
        isPurchased: drift.Value(item.isPurchased),
        isSynced: const drift.Value(false),
        deletedAt: drift.Value(item.deletedAt),
      ),
    );
  }

  @override
  Future<void> updateItem(
      ShoppingItemModel item,
      ) async {
    await database.update(database.shoppingItems).replace(
      ShoppingItem(
        id: item.id!,
        uuid: item.uuid,
        name: item.name,
        category: item.category,
        isPurchased: item.isPurchased,
        isSynced: false,
        deletedAt: item.deletedAt,
        createdAt: item.createdAt!,
        updatedAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> deleteItem(int id) async {
    await (database.update(database.shoppingItems)
      ..where((t) => t.id.equals(id)))
        .write(
      ShoppingItemsCompanion(
        deletedAt: drift.Value(DateTime.now()),
        isSynced: const drift.Value(false),
      ),
    );
  }

  @override
  Future<void> clearPurchasedItems() async {
    final purchased = await database.shoppingDao.getAllItems();

    for (final item in purchased.where((e) => e.isPurchased)) {
      await deleteItem(item.id);
    }
  }

  @override
  Future<void> clearAllItems() async {
    final items = await database.shoppingDao.getAllItems();

    for (final item in items) {
      await deleteItem(item.id);
    }
  }

  @override
  Future<bool> itemExists(String name) async {
    final items = await database.shoppingDao.getAllItems();

    return items.any(
          (e) => e.name.toLowerCase() == name.toLowerCase(),
    );
  }
  @override
  Future<List<ShoppingItemModel>> getPendingSyncItems() async {
    final items = await database.shoppingDao.getPendingSyncItems();
    return items.map(_map).toList();
  }

  @override
  Future<void> markItemSynced(String uuid) {
    return database.shoppingDao.markItemSynced(uuid);
  }

  @override
  Future<void> markItemPending(String uuid) {
    return database.shoppingDao.markItemPending(uuid);
  }

  @override
  Future<void> insertOrUpdateItem(
      ShoppingItemModel item,
      ) async {
    await database.shoppingDao.insertOrUpdateItem(
      ShoppingItemsCompanion.insert(
        uuid: item.uuid,
        name: item.name,
        category: drift.Value(item.category),
        isPurchased: drift.Value(item.isPurchased),
        isSynced: drift.Value(item.isSynced),
        deletedAt: drift.Value(item.deletedAt),
        createdAt: drift.Value(
          item.createdAt ?? DateTime.now(),
        ),
        updatedAt: drift.Value(
          item.updatedAt ?? DateTime.now(),
        ),
      ),
    );
  }
}