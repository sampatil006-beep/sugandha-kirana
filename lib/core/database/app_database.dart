import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'dao/product_dao.dart';
import 'tables/products_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Products],
  daos: [ProductDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'sugandha_kirana',
    native: const DriftNativeOptions(),
  );
}