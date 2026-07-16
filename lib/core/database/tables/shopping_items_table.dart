import 'package:drift/drift.dart';

class ShoppingItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get uuid => text().unique()();

  TextColumn get name => text()();

  TextColumn get category =>
      text().withDefault(const Constant('Other'))();

  BoolColumn get isPurchased =>
      boolean().withDefault(const Constant(false))();

  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(false))();

  DateTimeColumn get deletedAt =>
      dateTime().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}