import 'package:drift/drift.dart';

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get barcode => text().nullable()();

  RealColumn get purchasePrice => real()();

  RealColumn get sellingPrice => real()();

  RealColumn get mrp => real()();

  TextColumn get unit => text()();

  BoolColumn get isLooseItem =>
      boolean().withDefault(const Constant(false))();

  IntColumn get stock =>
      integer().withDefault(const Constant(0))();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}