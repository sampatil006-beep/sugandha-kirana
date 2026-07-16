import 'package:drift/drift.dart';

class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Global unique id for sync
  TextColumn get uuid => text().unique()();

  // Customer Name
  TextColumn get name => text()();

  // Mobile Number
  TextColumn get mobile => text().nullable()();

// Address
  TextColumn get address => text().nullable()();

// Reminder Frequency
// never | weekly | fortnightly | monthly
  TextColumn get reminderFrequency =>
      text().withDefault(const Constant('never'))();

// Last Reminder Sent
  DateTimeColumn get lastReminderSentAt =>
      dateTime().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// false = pending sync
  /// true = already synced
  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(false))();

  /// null = active
  /// not null = deleted locally (will sync later)
  DateTimeColumn get deletedAt =>
      dateTime().nullable()();
}