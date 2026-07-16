import 'package:drift/drift.dart';

class LedgerEntries extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Global unique id for sync
  TextColumn get uuid => text().unique()();

  // Customer UUID
  TextColumn get customerUuid => text()();

  /// credit = Udhari
  /// payment = Payment Received
  TextColumn get type => text()();

  // Amount
  RealColumn get amount => real()();

  // Optional Note
  TextColumn get note => text().nullable()();

  // Entry Date
  DateTimeColumn get entryDate => dateTime()();

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