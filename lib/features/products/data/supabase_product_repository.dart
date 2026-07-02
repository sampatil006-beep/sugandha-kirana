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
await _client.from(SupabaseTables.products).insert(
product.toJson()..remove('id'),
);
}

@override
Future<List<ProductModel>> getAllProducts() async {
final response = await _client
.from(SupabaseTables.products)
.select()
.order('name');

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
final response = await _client
.from(SupabaseTables.products)
.select()
.eq('id', id)
.maybeSingle();

if (response == null) return null;

return ProductModel.fromJson(
Map<String, dynamic>.from(response),
);
}

@override
Future<List<ProductModel>> searchProducts(
String query,
) async {
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
}
@override
Future<void> updateProduct(ProductModel product) async {
  await _client
      .from(SupabaseTables.products)
      .update(product.toJson()..remove('id'))
      .eq('id', product.id!);
}

@override
Future<void> deleteProduct(int id) async {
  await _client
      .from(SupabaseTables.products)
      .delete()
      .eq('id', id);
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