import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/database/app_database.dart';
import '../../../core/supabase/tables.dart';
import 'product_model.dart';
import 'product_repository.dart';

class SupabaseProductRepository implements ProductRepository {
  final AppDatabase database;
  final SupabaseClient _client = Supabase.instance.client;

  SupabaseProductRepository(this.database);

  @override
  Future<void> addProduct(ProductModel product) async {
    try {
      await _client
          .from(SupabaseTables.products)
          .upsert(
        product.toJson()..remove('id'),
        onConflict: 'uuid',
      );

      debugPrint("✅ Product synced to Supabase");
    } catch (e, s) {
      debugPrint("❌ SUPABASE UPSERT ERROR: $e");
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }
  @override
  Future<void> upsertProduct(ProductModel product) async {
    try {
      await _client
          .from(SupabaseTables.products)
          .upsert(
        product.toJson()..remove('id'),
        onConflict: 'uuid',
      );

      debugPrint(
        "✅ Product synced: ${product.name}",
      );
    } catch (e, s) {
      debugPrint("❌ UPSERT ERROR: $e");
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {

    debugPrint("========== GET ALL PRODUCTS ==========");

    final response = await _client
        .from(SupabaseTables.products)
        .select()
        .order('name');

    debugPrint("RAW RESPONSE = $response");

    return (response as List)
        .map(
          (e) => ProductModel.fromJson(
        Map<String, dynamic>.from(e),
      ),
    )
        .toList();
  }

  @override
  Future<ProductModel?> getProductById(int id) async {
    try {
      final response = await _client
          .from(SupabaseTables.products)
          .select()
          .eq('id', id)
          .maybeSingle();

      if (response == null) return null;

      return ProductModel.fromJson(
        Map<String, dynamic>.from(response),
      );
    } catch (e) {
      debugPrint("❌ SUPABASE GET BY ID ERROR: $e");
      return null;
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final response = await _client
          .from(SupabaseTables.products)
          .select()
          .ilike('name', '%$query%');

      return (response as List)
          .map(
            (e) => ProductModel.fromJson(
          Map<String, dynamic>.from(e),
        ),
      )
          .toList();
    } catch (e) {
      debugPrint("❌ SUPABASE SEARCH ERROR: $e");
      return [];
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    await _client
        .from(SupabaseTables.products)
        .update(product.toJson()..remove('id'))
        .eq('uuid', product.uuid);
  }

  @override
  Future<void> deleteProduct(int id) async {
    final product = await getProductById(id);

    if (product == null) return;

    await _client
        .from(SupabaseTables.products)
        .update({
      'deleted_at': DateTime.now().toIso8601String(),
      'is_synced': true,
    })
        .eq('uuid', product.uuid);
  }

  Future<void> uploadProducts(List<ProductModel> products) async {
    if (products.isEmpty) return;

    try {
      final data = products
          .map((e) => e.toJson()..remove('id'))
          .toList();

      await _client
          .from(SupabaseTables.products)
          .upsert(
        data,
        onConflict: 'uuid',
      );

      debugPrint("✅ Uploaded ${products.length} products");
    } catch (e, s) {
      debugPrint("❌ BULK UPLOAD ERROR: $e");
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }
  @override
  Future<List<ProductModel>> downloadProducts({
    DateTime? updatedAfter,
  }) async {
    try {
      dynamic query = _client
          .from(SupabaseTables.products)
          .select();

      if (updatedAfter != null) {
        query = query.gt(
          'updated_at',
          updatedAfter.toIso8601String(),
        );
      }

      final response = await query.order(
        'updated_at',
        ascending: true,
      );

      return (response as List)
          .map(
            (e) => ProductModel.fromJson(
          Map<String, dynamic>.from(e),
        ),
      )
          .toList();
    } catch (e, s) {
      debugPrint("❌ DOWNLOAD PRODUCTS ERROR: $e");
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  @override
  Stream<List<ProductModel>> watchProducts() {
    return _client
        .from(SupabaseTables.products)
        .stream(primaryKey: ['id'])
        .order('name')
        .map(
          (rows) => rows
          .map(
            (e) => ProductModel.fromJson(
          Map<String, dynamic>.from(e),
        ),
      )
          .toList(),
    );
  }
}