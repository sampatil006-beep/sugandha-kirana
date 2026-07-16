import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'dao/product_dao.dart';
import 'dao/shopping_dao.dart';
import 'dao/customer_dao.dart';
import 'dao/ledger_dao.dart';

import 'tables/products_table.dart';
import 'tables/shopping_items_table.dart';
import 'tables/customers_table.dart';
import 'tables/ledger_entries_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Products,
    ShoppingItems,
    Customers,
    LedgerEntries,
  ],
  daos: [
    ProductDao,
    ShoppingDao,
    CustomerDao,
    LedgerDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 6;
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 4) {
        debugPrint(
          'Database upgraded to schema version 4.',
        );
      }

      if (from < 5) {
        await migrator.createTable(customers);
        await migrator.createTable(ledgerEntries);

        debugPrint(
          'Database upgraded to schema version 5.',
        );
      }

      if (from < 6) {
        await migrator.addColumn(
          customers,
          customers.reminderFrequency,
        );

        await migrator.addColumn(
          customers,
          customers.lastReminderSentAt,
        );

        debugPrint(
          'Database upgraded to schema version 6.',
        );
      }
    },
  );
}


QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'sugandha_kirana',
    native: const DriftNativeOptions(),
  );
}