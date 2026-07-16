import 'dart:math';

import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/ledger_entries_table.dart';

part 'ledger_dao.g.dart';

@DriftAccessor(tables: [LedgerEntries])
class LedgerDao extends DatabaseAccessor<AppDatabase>
    with _$LedgerDaoMixin {
  LedgerDao(super.db);

  Stream<List<LedgerEntry>> watchLedger(
      String customerUuid,
      ) {
    return (select(ledgerEntries)
      ..where(
            (tbl) =>
        tbl.customerUuid.equals(customerUuid) &
        tbl.deletedAt.isNull(),
      )
      ..orderBy([
            (tbl) => OrderingTerm.asc(tbl.entryDate),
            (tbl) => OrderingTerm.asc(tbl.id),
      ]))
        .watch();
  }

  Future<List<LedgerEntry>> getLedger(
      String customerUuid,
      ) {
    return (select(ledgerEntries)
      ..where(
            (tbl) =>
        tbl.customerUuid.equals(customerUuid) &
        tbl.deletedAt.isNull(),
      )
      ..orderBy([
            (tbl) => OrderingTerm.asc(tbl.entryDate),
            (tbl) => OrderingTerm.asc(tbl.id),
      ]))
        .get();
  }

  Future<int> insertEntry(
      LedgerEntriesCompanion entry,
      ) {
    return into(ledgerEntries).insert(entry);
  }
  Future<void> insertOrUpdateEntry(
      LedgerEntriesCompanion entry,
      ) async {
    final uuid = entry.uuid.value;

    final existing = await (select(ledgerEntries)
      ..where((t) => t.uuid.equals(uuid)))
        .getSingleOrNull();

    if (existing == null) {
      await into(ledgerEntries).insert(entry);
    } else {
      await (update(ledgerEntries)
        ..where((t) => t.uuid.equals(uuid)))
          .write(entry);
    }
  }
  Future<bool> updateEntry(
      LedgerEntry entry,
      ) {
    return update(ledgerEntries).replace(entry);
  }

  Future<void> archiveEntry(
      int id,
      ) async {
    await (update(ledgerEntries)
      ..where((tbl) => tbl.id.equals(id)))
        .write(
      LedgerEntriesCompanion(
        deletedAt: Value(DateTime.now()),
        isSynced: const Value(false),
      ),
    );
  }

  Future<List<LedgerEntry>> getPendingSyncEntries() {
    return (select(ledgerEntries)
      ..where((tbl) => tbl.isSynced.equals(false)))
        .get();
  }

  Future<void> markEntrySynced(
      String uuid,
      ) {
    return (update(ledgerEntries)
      ..where((tbl) => tbl.uuid.equals(uuid)))
        .write(
      const LedgerEntriesCompanion(
        isSynced: Value(true),
      ),
    );
  }

  Future<void> markEntryPending(
      String uuid,
      ) {
    return (update(ledgerEntries)
      ..where((tbl) => tbl.uuid.equals(uuid)))
        .write(
      const LedgerEntriesCompanion(
        isSynced: Value(false),
      ),
    );
  }

  Future<void> deleteByUuid(
      String uuid,
      ) async {
    await (delete(ledgerEntries)
      ..where((tbl) => tbl.uuid.equals(uuid)))
        .go();
  }

  /// Returns outstanding balance for one customer.
  ///
  /// Formula:
  /// Credit - Payment
  Future<double> getCustomerBalance(
      String customerUuid,
      ) async {
    final entries = await getLedger(customerUuid);

    double balance = 0;

    for (final entry in entries) {
      if (entry.type == 'credit') {
        balance += entry.amount;
      } else if (entry.type == 'payment') {
        balance -= entry.amount;
      }
    }

    return balance;
  }

  /// Returns balances of all customers.
  ///
  /// Key = customerUuid
  /// Value = Outstanding Balance
  Future<Map<String, double>> getAllCustomerBalances() async {
    final rows = await (select(ledgerEntries)
      ..where((tbl) => tbl.deletedAt.isNull()))
        .get();

    final balances = <String, double>{};

    for (final row in rows) {
      final current = balances[row.customerUuid] ?? 0;

      balances[row.customerUuid] =
      row.type == 'credit'
          ? current + row.amount
          : current - row.amount;
    }

    return balances;
  }
  Stream<Map<String, double>> watchAllCustomerBalances() {
    return (select(ledgerEntries)
      ..where((tbl) => tbl.deletedAt.isNull()))
        .watch()
        .map((rows) {
      final balances = <String, double>{};

      for (final row in rows) {
        final current = balances[row.customerUuid] ?? 0;

        balances[row.customerUuid] =
        row.type == 'credit'
            ? current + row.amount
            : current - row.amount;
      }

      return balances;
    });
  }
}