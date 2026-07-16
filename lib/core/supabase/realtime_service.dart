import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_service.dart';

class RealtimeService {
  RealtimeService._();

  static final RealtimeService instance =
  RealtimeService._();

  RealtimeChannel? _customersChannel;
  RealtimeChannel? _ledgerChannel;

  void start({
    required Future<void> Function() onCustomersChanged,
    required Future<void> Function() onLedgerChanged,
  }) {
    _customersChannel ??=
        SupabaseService.client.channel('customers_sync');

    _customersChannel!
        .onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: 'customers',
      callback: (payload) async {
        print('CUSTOMER EVENT');
        print(payload);

        await onCustomersChanged();
      },
    )
        .subscribe((status, error) {
      print('CUSTOMER CHANNEL: $status');
      print(error);
    });

    _ledgerChannel ??=
        SupabaseService.client.channel('ledger_sync');

    _ledgerChannel!
        .onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: 'ledger_entries',
      callback: (payload) async {
        print('LEDGER EVENT');
        print(payload);

        await onLedgerChanged();
      },
    )
        .subscribe((status, error) {
      print('LEDGER CHANNEL: $status');
      print(error);
    });
  }

  Future<void> dispose() async {
    if (_customersChannel != null) {
      await SupabaseService.client.removeChannel(
        _customersChannel!,
      );
    }

    if (_ledgerChannel != null) {
      await SupabaseService.client.removeChannel(
        _ledgerChannel!,
      );
    }
  }
}