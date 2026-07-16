import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../core/supabase/tables.dart';

class CustomerSyncRepository {
  final AppDatabase database;

  CustomerSyncRepository(this.database);

  Future<void> syncPendingCustomers() async {
    final pending =
    await database.customerDao.getPendingSyncCustomers();

    for (final customer in pending) {
      try {
        await SupabaseService.client
            .from(SupabaseTables.customers)
            .upsert(
          {
            'uuid': customer.uuid,
            'name': customer.name,
            'mobile': customer.mobile,
            'address': customer.address,
            'reminder_frequency': 'never',
            'last_reminder_sent_at':
            customer.lastReminderSentAt
                ?.toIso8601String(),
            'created_at':
            customer.createdAt?.toIso8601String(),
            'updated_at':
            customer.updatedAt?.toIso8601String(),
            'deleted_at':
            customer.deletedAt?.toIso8601String(),
            'is_synced': true,
          },
          onConflict: 'uuid',
        );

        await database.customerDao
            .markCustomerSynced(customer.uuid);
      } catch (e) {
        print('Customer Sync Error: $e');
      }
    }
  }

  Future<void> downloadCustomers() async {
    final response = await SupabaseService.client
        .from(SupabaseTables.customers)
        .select()
        .order('updated_at');

    for (final item in response) {
      if (item['deleted_at'] != null) {
        await database.customerDao.deleteByUuid(
          item['uuid'],
        );
        continue;
      }

      await database.customerDao
          .insertOrUpdateCustomer(
        CustomersCompanion.insert(
          uuid: item['uuid'],
          name: item['name'],
          mobile: Value(item['mobile']),
          address: Value(item['address']),
          reminderFrequency: Value(
            item['reminder_frequency'],
          ),
          lastReminderSentAt: Value(
            item['last_reminder_sent_at'] != null
                ? DateTime.parse(
              item['last_reminder_sent_at'],
            )
                : null,
          ),
          isSynced: const Value(true),
          createdAt: Value(
            item['created_at'] != null
                ? DateTime.parse(
              item['created_at'],
            )
                : DateTime.now(),
          ),
          updatedAt: Value(
            item['updated_at'] != null
                ? DateTime.parse(
              item['updated_at'],
            )
                : DateTime.now(),
          ),
          deletedAt: Value(
            item['deleted_at'] != null
                ? DateTime.parse(
              item['deleted_at'],
            )
                : null,
          ),
        ),
      );
    }
  }
}