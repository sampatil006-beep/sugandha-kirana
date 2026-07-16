class CustomerLedgerSummary {
  final double outstanding;
  final double totalCredit;
  final double totalPayment;
  final int totalTransactions;

  const CustomerLedgerSummary({
    required this.outstanding,
    required this.totalCredit,
    required this.totalPayment,
    required this.totalTransactions,
  });
}