import 'ledger_model.dart';

class LedgerTimelineItem {
  final LedgerModel entry;
  final double runningBalance;

  const LedgerTimelineItem({
    required this.entry,
    required this.runningBalance,
  });
}