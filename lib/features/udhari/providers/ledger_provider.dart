import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../products/providers/product_provider.dart';

import '../data/customer_ledger_summary.dart';
import '../data/ledger_model.dart';
import '../data/ledger_repository.dart';
import '../data/ledger_timeline_item.dart';
import '../data/local_ledger_repository.dart';
import '../data/customer_dashboard_summary.dart';
import '../data/ledger_filter.dart';
import '../data/ledger_sync_repository.dart';

final ledgerRepositoryProvider = Provider<LedgerRepository>((ref) {
  return LocalLedgerRepository(
    ref.read(appDatabaseProvider),
  );
});

final ledgerProvider =
StreamProvider.family<List<LedgerModel>, String>(
      (ref, customerUuid) {
    return ref
        .read(ledgerRepositoryProvider)
        .watchLedger(customerUuid);
  },
);

final ledgerTimelineProvider =
StreamProvider.family<List<LedgerTimelineItem>, String>(
      (ref, customerUuid) {
    return ref
        .read(ledgerRepositoryProvider)
        .watchLedgerTimeline(customerUuid);
  },
);

final customerBalancesProvider =
StreamProvider.autoDispose<Map<String, double>>(
      (ref) {
    return ref
        .read(ledgerRepositoryProvider)
        .watchAllCustomerBalances();
  },
);

final customerSummaryProvider =
StreamProvider.family<CustomerLedgerSummary, String>(
      (ref, customerUuid) {
    return ref
        .read(ledgerRepositoryProvider)
        .watchCustomerSummary(customerUuid);
  },
);
final customerDashboardSummaryProvider =
StreamProvider<CustomerDashboardSummary>((ref) {
  return ref
      .read(ledgerRepositoryProvider)
      .watchCustomerDashboardSummary();
});
final ledgerFilterProvider =
StateProvider<LedgerFilter>((ref) {
  return LedgerFilter.all;
});
final ledgerSyncRepositoryProvider =
Provider<LedgerSyncRepository>((ref) {
  return LedgerSyncRepository(
    ref.read(appDatabaseProvider),
  );
});