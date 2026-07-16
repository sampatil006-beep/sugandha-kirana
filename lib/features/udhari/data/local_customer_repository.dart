import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';

import 'customer_model.dart';
import 'customer_repository.dart';

class LocalCustomerRepository implements CustomerRepository {
  final AppDatabase database;

  static const Uuid _uuid = Uuid();

  LocalCustomerRepository(this.database);

  CustomerModel _map(Customer row) {
    return CustomerModel(
      id: row.id,
      uuid: row.uuid,
      name: row.name,
      mobile: row.mobile,
      address: row.address,
      isSynced: row.isSynced,
      deletedAt: row.deletedAt,
      lastReminderSentAt: row.lastReminderSentAt,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  @override
  Future<List<CustomerModel>> getAllCustomers() async {
    final list = await database.customerDao.getAllCustomers();
    return list.map(_map).toList();
  }

  @override
  Stream<List<CustomerModel>> watchCustomers() {
    return database.customerDao
        .watchCustomers()
        .map((list) => list.map(_map).toList());
  }

  @override
  Future<CustomerModel?> getCustomerById(int id) async {
    final customer =
    await database.customerDao.getCustomerById(id);

    return customer == null ? null : _map(customer);
  }

  @override
  Future<CustomerModel?> getCustomerByUuid(
      String uuid) async {
    final customer =
    await database.customerDao.getCustomerByUuid(uuid);

    return customer == null ? null : _map(customer);
  }

  @override
  Future<void> addCustomer(
      CustomerModel customer) async {
    final uuid =
    customer.uuid.isEmpty ? _uuid.v4() : customer.uuid;

    await database.customerDao.insertCustomer(
      CustomersCompanion.insert(
        uuid: uuid,
        name: customer.name,
        mobile: drift.Value(customer.mobile),
        address: drift.Value(customer.address),
        reminderFrequency: const drift.Value('never'),
        lastReminderSentAt:
        drift.Value(customer.lastReminderSentAt),
        isSynced: const drift.Value(false),
        deletedAt: drift.Value(customer.deletedAt),
      ),
    );
  }

  @override
  Future<void> updateCustomer(
      CustomerModel customer) async {
    await database.customerDao.updateCustomer(
      Customer(
        id: customer.id!,
        uuid: customer.uuid,
        name: customer.name,
        mobile: customer.mobile,
        address: customer.address,
        reminderFrequency: 'never',
        lastReminderSentAt:
        customer.lastReminderSentAt,
        isSynced: false,
        deletedAt: customer.deletedAt,
        createdAt: customer.createdAt!,
        updatedAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> archiveCustomer(int id) async {
    await database.customerDao.archiveCustomer(id);
  }
  @override
  Future<double> getOutstandingBalance(
      String customerUuid,
      ) {
    return database.ledgerDao.getCustomerBalance(
      customerUuid,
    );
  }

  @override
  Stream<double> watchOutstandingBalance(
      String customerUuid,
      ) {
    return database.ledgerDao
        .watchLedger(customerUuid)
        .map((entries) {
      double balance = 0;

      for (final entry in entries) {
        if (entry.type == 'credit') {
          balance += entry.amount;
        } else if (entry.type == 'payment') {
          balance -= entry.amount;
        }
      }

      return balance;
    });
  }
  @override
  Future<List<CustomerModel>> getPendingSyncCustomers() async {
    final customers =
    await database.customerDao.getPendingSyncCustomers();

    return customers.map(_map).toList();
  }

  @override
  Future<void> markCustomerSynced(String uuid) {
    return database.customerDao.markCustomerSynced(uuid);
  }
  @override
  Future<void> markCustomerPending(
      String uuid,
      ) {
    return database.customerDao.markCustomerPending(
      uuid,
    );
  }
  @override
  Future<void> upsertCustomer(
      CustomerModel customer,
      ) async {
    await database.customerDao.insertOrUpdateCustomer(
      CustomersCompanion.insert(
        uuid: customer.uuid,
        name: customer.name,
        mobile: drift.Value(customer.mobile),
        address: drift.Value(customer.address),
        reminderFrequency: const drift.Value('never'),
        lastReminderSentAt:
        drift.Value(customer.lastReminderSentAt),
        isSynced: drift.Value(customer.isSynced),
        deletedAt: drift.Value(customer.deletedAt),
      ),
    );
  }
}