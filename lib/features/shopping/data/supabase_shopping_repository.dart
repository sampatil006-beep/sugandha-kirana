import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/database/app_database.dart';
import '../../../core/supabase/tables.dart';
import 'shopping_item_model.dart';
import 'shopping_repository.dart';

class SupabaseShoppingRepository
    implements ShoppingRepository {
  final AppDatabase database;

  final SupabaseClient _client =
      Supabase.instance.client;

  SupabaseShoppingRepository(this.database);

  @override
  Future<List<ShoppingItemModel>> getAllItems() async {
    final response = await _client
        .from(SupabaseTables.shoppingItems)
        .select()
        .order('category')
        .order('is_purchased')
        .order('name');

    return (response as List)
        .map(
          (e) => ShoppingItemModel.fromJson(
        Map<String, dynamic>.from(e),
      ),
    )
        .toList();
  }

  @override
  Stream<List<ShoppingItemModel>> watchItems() {
    return _client
        .from(SupabaseTables.shoppingItems)
        .stream(primaryKey: ['id'])
        .order('category')
        .order('is_purchased')
        .order('name')
        .map(
          (rows) => rows
          .map(
            (e) => ShoppingItemModel.fromJson(
          Map<String, dynamic>.from(e),
        ),
      )
          .toList(),
    );
  }

  @override
  Future<void> addItem(
      ShoppingItemModel item,
      ) async {
    await _client
        .from(SupabaseTables.shoppingItems)
        .insert(
      item.toJson()..remove('id'),
    );
  }

  @override
  Future<void> updateItem(
      ShoppingItemModel item,
      ) async {
    await _client
        .from(SupabaseTables.shoppingItems)
        .update(item.toJson()..remove('id'))
        .eq('id', item.id!);
  }

  @override
  Future<void> deleteItem(int id) async {
    await _client
        .from(SupabaseTables.shoppingItems)
        .delete()
        .eq('id', id);
  }

  @override
  Future<void> clearPurchasedItems() async {
    await _client
        .from(SupabaseTables.shoppingItems)
        .delete()
        .eq('is_purchased', true);
  }

  @override
  Future<void> clearAllItems() async {
    await _client
        .from(SupabaseTables.shoppingItems)
        .delete()
        .neq('id', 0);
  }

  @override
  Future<bool> itemExists(
      String name,
      ) async {
    final response = await _client
        .from(SupabaseTables.shoppingItems)
        .select('id')
        .ilike('name', name)
        .limit(1);

    return response.isNotEmpty;
  }
  @override
  Future<List<ShoppingItemModel>> getPendingSyncItems() async {
    throw UnimplementedError();
  }

  @override
  Future<void> markItemSynced(String uuid) async {
    throw UnimplementedError();
  }

  @override
  Future<void> markItemPending(String uuid) async {
    throw UnimplementedError();
  }

  @override
  Future<void> insertOrUpdateItem(
      ShoppingItemModel item,
      ) async {
    await _client
        .from(SupabaseTables.shoppingItems)
        .upsert(
      item.toJson()..remove('id'),
      onConflict: 'uuid',
    );
  }
}