import 'ledger_model.dart';
import 'ledger_timeline_item.dart';
import 'customer_ledger_summary.dart';
import 'customer_dashboard_summary.dart';

abstract class LedgerRepository {
  Future<List<LedgerModel>> getLedger(
      String customerUuid,
      );

  Stream<List<LedgerModel>> watchLedger(
      String customerUuid,
      );

  Stream<List<LedgerTimelineItem>> watchLedgerTimeline(
      String customerUuid,
      );

  Future<void> addEntry(
      LedgerModel entry,
      );

  Future<void> updateEntry(
      LedgerModel entry,
      );

  Future<void> archiveEntry(
      int id,
      );

  Future<List<LedgerModel>> getPendingSyncEntries();

  Future<void> markEntrySynced(
      String uuid,
      );

  Future<void> markEntryPending(
      String uuid,
      );

  Future<void> insertOrUpdateEntry(
      LedgerModel entry,
      );

  Future<Map<String, double>> getAllCustomerBalances();

  Stream<Map<String, double>> watchAllCustomerBalances();
  Future<CustomerLedgerSummary> getCustomerSummary(
      String customerUuid,
      );
  Future<CustomerDashboardSummary> getCustomerDashboardSummary();
  Stream<CustomerLedgerSummary> watchCustomerSummary(
      String customerUuid,
      );

  Stream<CustomerDashboardSummary> watchCustomerDashboardSummary();
}
