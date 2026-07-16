import 'shopping_item_model.dart';

abstract class ShoppingRepository {
  Future<List<ShoppingItemModel>> getAllItems();

  Stream<List<ShoppingItemModel>> watchItems();

  Future<void> addItem(
      ShoppingItemModel item,
      );

  Future<void> updateItem(
      ShoppingItemModel item,
      );

  Future<void> deleteItem(
      int id,
      );

  Future<void> clearPurchasedItems();

  Future<void> clearAllItems();

  Future<bool> itemExists(
      String name,
      );

  Future<List<ShoppingItemModel>> getPendingSyncItems();

  Future<void> markItemSynced(String uuid);

  Future<void> markItemPending(String uuid);

  Future<void> insertOrUpdateItem(
      ShoppingItemModel item,
      );
}