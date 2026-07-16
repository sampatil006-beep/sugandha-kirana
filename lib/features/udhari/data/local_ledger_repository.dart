import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';

import 'ledger_model.dart';
import 'ledger_repository.dart';
import 'ledger_timeline_item.dart';
import 'customer_ledger_summary.dart';
import 'customer_dashboard_summary.dart';

class LocalLedgerRepository implements LedgerRepository {
  final AppDatabase database;

  static const Uuid _uuid = Uuid();

  LocalLedgerRepository(this.database);

  LedgerModel _map(LedgerEntry row) {
    return LedgerModel(
      id: row.id,
      uuid: row.uuid,
      customerUuid: row.customerUuid,
      type: row.type,
      amount: row.amount,
      note: row.note,
      entryDate: row.entryDate,
      isSynced: row.isSynced,
      deletedAt: row.deletedAt,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  @override
  Future<List<LedgerModel>> getLedger(
      String customerUuid,
      ) async {
    final list =
    await database.ledgerDao.getLedger(customerUuid);

    return list.map(_map).toList();
  }

  @override
  Stream<List<LedgerModel>> watchLedger(
      String customerUuid,
      ) {
    return database.ledgerDao
        .watchLedger(customerUuid)
        .map((list) => list.map(_map).toList());
  }
  @override
  Stream<List<LedgerTimelineItem>> watchLedgerTimeline(
      String customerUuid,
      ) {
    return database.ledgerDao.watchLedger(customerUuid).map((rows) {
      double runningBalance = 0;

      final timeline = <LedgerTimelineItem>[];

      for (final row in rows) {
        final entry = _map(row);

        if (entry.isCredit) {
          runningBalance += entry.amount;
        } else {
          runningBalance -= entry.amount;
        }

        timeline.add(
          LedgerTimelineItem(
            entry: entry,
            runningBalance: runningBalance,
          ),
        );
      }

      return timeline;
    });
  }
  @override
  Future<void> addEntry(
      LedgerModel entry,
      ) async {
    final uuid =
    entry.uuid.isEmpty ? _uuid.v4() : entry.uuid;

    await database.ledgerDao.insertEntry(
      LedgerEntriesCompanion.insert(
        uuid: uuid,
        customerUuid: entry.customerUuid,
        type: entry.type,
        amount: entry.amount,
        entryDate: entry.entryDate,
        note: drift.Value(entry.note),
        isSynced: const drift.Value(false),
        deletedAt: drift.Value(entry.deletedAt),
      ),
    );
  }

  @override
  Future<void> updateEntry(
      LedgerModel entry,
      ) async {
    await database.ledgerDao.updateEntry(
      LedgerEntry(
        id: entry.id!,
        uuid: entry.uuid,
        customerUuid: entry.customerUuid,
        type: entry.type,
        amount: entry.amount,
        note: entry.note,
        entryDate: entry.entryDate,
        isSynced: false,
        deletedAt: entry.deletedAt,
        createdAt: entry.createdAt!,
        updatedAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> archiveEntry(int id) async {
    await database.ledgerDao.archiveEntry(id);
  }

  @override
  Future<List<LedgerModel>> getPendingSyncEntries() async {
    final list =
    await database.ledgerDao.getPendingSyncEntries();

    return list.map(_map).toList();
  }

  @override
  Future<void> markEntrySynced(
      String uuid,
      ) async {
    await database.ledgerDao.markEntrySynced(uuid);
  }

  @override
  Future<void> markEntryPending(
      String uuid,
      ) async {
    await database.ledgerDao.markEntryPending(uuid);
  }

  @override
  Future<void> insertOrUpdateEntry(
      LedgerModel entry,
      ) async {
    if (entry.id == null) {
      await addEntry(entry);
      return;
    }

    await updateEntry(entry);
  }
  @override
  Future<Map<String, double>> getAllCustomerBalances() {
    return database.ledgerDao.getAllCustomerBalances();
  }
  @override
  Stream<Map<String, double>> watchAllCustomerBalances() {
    return database.ledgerDao.watchAllCustomerBalances();
  }
  @override
  Future<CustomerDashboardSummary>
  getCustomerDashboardSummary() async {
    final balances = await getAllCustomerBalances();

    int customersDue = 0;
    double totalOutstanding = 0;

    for (final amount in balances.values) {
      if (amount > 0) {
        customersDue++;
        totalOutstanding += amount;
      }
    }

    return CustomerDashboardSummary(
      customersDue: customersDue,
      totalOutstanding: totalOutstanding,
    );
  }
  @override
  Stream<CustomerDashboardSummary>
  watchCustomerDashboardSummary() {
    return watchAllCustomerBalances().map((balances) {
      int customersDue = 0;
      double outstanding = 0;

      for (final balance in balances.values) {
        if (balance > 0) {
          customersDue++;
          outstanding += balance;
        }
      }

      return CustomerDashboardSummary(
        customersDue: customersDue,
        totalOutstanding: outstanding,
      );
    });
  }
  @override
  Future<CustomerLedgerSummary> getCustomerSummary(
      String customerUuid,
      ) async {
    final entries = await getLedger(customerUuid);

    double totalCredit = 0;
    double totalPayment = 0;

    for (final entry in entries) {
      if (entry.isCredit) {
        totalCredit += entry.amount;
      } else {
        totalPayment += entry.amount;
      }
    }

    return CustomerLedgerSummary(
      outstanding: totalCredit - totalPayment,
      totalCredit: totalCredit,
      totalPayment: totalPayment,
      totalTransactions: entries.length,
    );
  }
  @override
  Stream<CustomerLedgerSummary> watchCustomerSummary(
      String customerUuid,
      ) {
    return database.ledgerDao
        .watchLedger(customerUuid)
        .map((rows) {
      double credit = 0;
      double payment = 0;

      for (final row in rows) {
        if (row.type == 'credit') {
          credit += row.amount;
        } else {
          payment += row.amount;
        }
      }

      return CustomerLedgerSummary(
        outstanding: credit - payment,
        totalCredit: credit,
        totalPayment: payment,
        totalTransactions: rows.length,
      );
    });
  }
}