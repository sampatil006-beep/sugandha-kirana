// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sellingPriceMeta = const VerificationMeta(
    'sellingPrice',
  );
  @override
  late final GeneratedColumn<double> sellingPrice = GeneratedColumn<double>(
    'selling_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mrpMeta = const VerificationMeta('mrp');
  @override
  late final GeneratedColumn<double> mrp = GeneratedColumn<double>(
    'mrp',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isLooseItemMeta = const VerificationMeta(
    'isLooseItem',
  );
  @override
  late final GeneratedColumn<bool> isLooseItem = GeneratedColumn<bool>(
    'is_loose_item',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_loose_item" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
    'stock',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    name,
    barcode,
    purchasePrice,
    sellingPrice,
    mrp,
    unit,
    isLooseItem,
    stock,
    createdAt,
    updatedAt,
    isSynced,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasePriceMeta);
    }
    if (data.containsKey('selling_price')) {
      context.handle(
        _sellingPriceMeta,
        sellingPrice.isAcceptableOrUnknown(
          data['selling_price']!,
          _sellingPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sellingPriceMeta);
    }
    if (data.containsKey('mrp')) {
      context.handle(
        _mrpMeta,
        mrp.isAcceptableOrUnknown(data['mrp']!, _mrpMeta),
      );
    } else if (isInserting) {
      context.missing(_mrpMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('is_loose_item')) {
      context.handle(
        _isLooseItemMeta,
        isLooseItem.isAcceptableOrUnknown(
          data['is_loose_item']!,
          _isLooseItemMeta,
        ),
      );
    }
    if (data.containsKey('stock')) {
      context.handle(
        _stockMeta,
        stock.isAcceptableOrUnknown(data['stock']!, _stockMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      purchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_price'],
      )!,
      sellingPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}selling_price'],
      )!,
      mrp: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mrp'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      isLooseItem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_loose_item'],
      )!,
      stock: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String uuid;
  final String name;
  final String? barcode;
  final double purchasePrice;
  final double sellingPrice;
  final double mrp;
  final String unit;
  final bool isLooseItem;
  final int stock;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// false = pending sync
  /// true = already synced
  final bool isSynced;

  /// null = active
  /// not null = deleted locally (will sync later)
  final DateTime? deletedAt;
  const Product({
    required this.id,
    required this.uuid,
    required this.name,
    this.barcode,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.mrp,
    required this.unit,
    required this.isLooseItem,
    required this.stock,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['purchase_price'] = Variable<double>(purchasePrice);
    map['selling_price'] = Variable<double>(sellingPrice);
    map['mrp'] = Variable<double>(mrp);
    map['unit'] = Variable<String>(unit);
    map['is_loose_item'] = Variable<bool>(isLooseItem);
    map['stock'] = Variable<int>(stock);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      uuid: Value(uuid),
      name: Value(name),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      purchasePrice: Value(purchasePrice),
      sellingPrice: Value(sellingPrice),
      mrp: Value(mrp),
      unit: Value(unit),
      isLooseItem: Value(isLooseItem),
      stock: Value(stock),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      purchasePrice: serializer.fromJson<double>(json['purchasePrice']),
      sellingPrice: serializer.fromJson<double>(json['sellingPrice']),
      mrp: serializer.fromJson<double>(json['mrp']),
      unit: serializer.fromJson<String>(json['unit']),
      isLooseItem: serializer.fromJson<bool>(json['isLooseItem']),
      stock: serializer.fromJson<int>(json['stock']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'barcode': serializer.toJson<String?>(barcode),
      'purchasePrice': serializer.toJson<double>(purchasePrice),
      'sellingPrice': serializer.toJson<double>(sellingPrice),
      'mrp': serializer.toJson<double>(mrp),
      'unit': serializer.toJson<String>(unit),
      'isLooseItem': serializer.toJson<bool>(isLooseItem),
      'stock': serializer.toJson<int>(stock),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Product copyWith({
    int? id,
    String? uuid,
    String? name,
    Value<String?> barcode = const Value.absent(),
    double? purchasePrice,
    double? sellingPrice,
    double? mrp,
    String? unit,
    bool? isLooseItem,
    int? stock,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Product(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    name: name ?? this.name,
    barcode: barcode.present ? barcode.value : this.barcode,
    purchasePrice: purchasePrice ?? this.purchasePrice,
    sellingPrice: sellingPrice ?? this.sellingPrice,
    mrp: mrp ?? this.mrp,
    unit: unit ?? this.unit,
    isLooseItem: isLooseItem ?? this.isLooseItem,
    stock: stock ?? this.stock,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      sellingPrice: data.sellingPrice.present
          ? data.sellingPrice.value
          : this.sellingPrice,
      mrp: data.mrp.present ? data.mrp.value : this.mrp,
      unit: data.unit.present ? data.unit.value : this.unit,
      isLooseItem: data.isLooseItem.present
          ? data.isLooseItem.value
          : this.isLooseItem,
      stock: data.stock.present ? data.stock.value : this.stock,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('barcode: $barcode, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('mrp: $mrp, ')
          ..write('unit: $unit, ')
          ..write('isLooseItem: $isLooseItem, ')
          ..write('stock: $stock, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    name,
    barcode,
    purchasePrice,
    sellingPrice,
    mrp,
    unit,
    isLooseItem,
    stock,
    createdAt,
    updatedAt,
    isSynced,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.barcode == this.barcode &&
          other.purchasePrice == this.purchasePrice &&
          other.sellingPrice == this.sellingPrice &&
          other.mrp == this.mrp &&
          other.unit == this.unit &&
          other.isLooseItem == this.isLooseItem &&
          other.stock == this.stock &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced &&
          other.deletedAt == this.deletedAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> name;
  final Value<String?> barcode;
  final Value<double> purchasePrice;
  final Value<double> sellingPrice;
  final Value<double> mrp;
  final Value<String> unit;
  final Value<bool> isLooseItem;
  final Value<int> stock;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<DateTime?> deletedAt;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.barcode = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.sellingPrice = const Value.absent(),
    this.mrp = const Value.absent(),
    this.unit = const Value.absent(),
    this.isLooseItem = const Value.absent(),
    this.stock = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String name,
    this.barcode = const Value.absent(),
    required double purchasePrice,
    required double sellingPrice,
    required double mrp,
    required String unit,
    this.isLooseItem = const Value.absent(),
    this.stock = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : uuid = Value(uuid),
       name = Value(name),
       purchasePrice = Value(purchasePrice),
       sellingPrice = Value(sellingPrice),
       mrp = Value(mrp),
       unit = Value(unit);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? barcode,
    Expression<double>? purchasePrice,
    Expression<double>? sellingPrice,
    Expression<double>? mrp,
    Expression<String>? unit,
    Expression<bool>? isLooseItem,
    Expression<int>? stock,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (barcode != null) 'barcode': barcode,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (sellingPrice != null) 'selling_price': sellingPrice,
      if (mrp != null) 'mrp': mrp,
      if (unit != null) 'unit': unit,
      if (isLooseItem != null) 'is_loose_item': isLooseItem,
      if (stock != null) 'stock': stock,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? name,
    Value<String?>? barcode,
    Value<double>? purchasePrice,
    Value<double>? sellingPrice,
    Value<double>? mrp,
    Value<String>? unit,
    Value<bool>? isLooseItem,
    Value<int>? stock,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<DateTime?>? deletedAt,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      mrp: mrp ?? this.mrp,
      unit: unit ?? this.unit,
      isLooseItem: isLooseItem ?? this.isLooseItem,
      stock: stock ?? this.stock,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (sellingPrice.present) {
      map['selling_price'] = Variable<double>(sellingPrice.value);
    }
    if (mrp.present) {
      map['mrp'] = Variable<double>(mrp.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (isLooseItem.present) {
      map['is_loose_item'] = Variable<bool>(isLooseItem.value);
    }
    if (stock.present) {
      map['stock'] = Variable<int>(stock.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('barcode: $barcode, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('mrp: $mrp, ')
          ..write('unit: $unit, ')
          ..write('isLooseItem: $isLooseItem, ')
          ..write('stock: $stock, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $ShoppingItemsTable extends ShoppingItems
    with TableInfo<$ShoppingItemsTable, ShoppingItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShoppingItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Other'),
  );
  static const VerificationMeta _isPurchasedMeta = const VerificationMeta(
    'isPurchased',
  );
  @override
  late final GeneratedColumn<bool> isPurchased = GeneratedColumn<bool>(
    'is_purchased',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_purchased" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    name,
    category,
    isPurchased,
    isSynced,
    deletedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shopping_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShoppingItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('is_purchased')) {
      context.handle(
        _isPurchasedMeta,
        isPurchased.isAcceptableOrUnknown(
          data['is_purchased']!,
          _isPurchasedMeta,
        ),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShoppingItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShoppingItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      isPurchased: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_purchased'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ShoppingItemsTable createAlias(String alias) {
    return $ShoppingItemsTable(attachedDatabase, alias);
  }
}

class ShoppingItem extends DataClass implements Insertable<ShoppingItem> {
  final int id;
  final String uuid;
  final String name;
  final String category;
  final bool isPurchased;
  final bool isSynced;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ShoppingItem({
    required this.id,
    required this.uuid,
    required this.name,
    required this.category,
    required this.isPurchased,
    required this.isSynced,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['is_purchased'] = Variable<bool>(isPurchased);
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ShoppingItemsCompanion toCompanion(bool nullToAbsent) {
    return ShoppingItemsCompanion(
      id: Value(id),
      uuid: Value(uuid),
      name: Value(name),
      category: Value(category),
      isPurchased: Value(isPurchased),
      isSynced: Value(isSynced),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ShoppingItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShoppingItem(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      isPurchased: serializer.fromJson<bool>(json['isPurchased']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'isPurchased': serializer.toJson<bool>(isPurchased),
      'isSynced': serializer.toJson<bool>(isSynced),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ShoppingItem copyWith({
    int? id,
    String? uuid,
    String? name,
    String? category,
    bool? isPurchased,
    bool? isSynced,
    Value<DateTime?> deletedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ShoppingItem(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    name: name ?? this.name,
    category: category ?? this.category,
    isPurchased: isPurchased ?? this.isPurchased,
    isSynced: isSynced ?? this.isSynced,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ShoppingItem copyWithCompanion(ShoppingItemsCompanion data) {
    return ShoppingItem(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      isPurchased: data.isPurchased.present
          ? data.isPurchased.value
          : this.isPurchased,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingItem(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('isPurchased: $isPurchased, ')
          ..write('isSynced: $isSynced, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    name,
    category,
    isPurchased,
    isSynced,
    deletedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShoppingItem &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.category == this.category &&
          other.isPurchased == this.isPurchased &&
          other.isSynced == this.isSynced &&
          other.deletedAt == this.deletedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ShoppingItemsCompanion extends UpdateCompanion<ShoppingItem> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> name;
  final Value<String> category;
  final Value<bool> isPurchased;
  final Value<bool> isSynced;
  final Value<DateTime?> deletedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ShoppingItemsCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.isPurchased = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ShoppingItemsCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String name,
    this.category = const Value.absent(),
    this.isPurchased = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : uuid = Value(uuid),
       name = Value(name);
  static Insertable<ShoppingItem> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? category,
    Expression<bool>? isPurchased,
    Expression<bool>? isSynced,
    Expression<DateTime>? deletedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (isPurchased != null) 'is_purchased': isPurchased,
      if (isSynced != null) 'is_synced': isSynced,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ShoppingItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? name,
    Value<String>? category,
    Value<bool>? isPurchased,
    Value<bool>? isSynced,
    Value<DateTime?>? deletedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ShoppingItemsCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      category: category ?? this.category,
      isPurchased: isPurchased ?? this.isPurchased,
      isSynced: isSynced ?? this.isSynced,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isPurchased.present) {
      map['is_purchased'] = Variable<bool>(isPurchased.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingItemsCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('isPurchased: $isPurchased, ')
          ..write('isSynced: $isSynced, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  @override
  late final GeneratedColumn<String> mobile = GeneratedColumn<String>(
    'mobile',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderFrequencyMeta = const VerificationMeta(
    'reminderFrequency',
  );
  @override
  late final GeneratedColumn<String> reminderFrequency =
      GeneratedColumn<String>(
        'reminder_frequency',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('never'),
      );
  static const VerificationMeta _lastReminderSentAtMeta =
      const VerificationMeta('lastReminderSentAt');
  @override
  late final GeneratedColumn<DateTime> lastReminderSentAt =
      GeneratedColumn<DateTime>(
        'last_reminder_sent_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    name,
    mobile,
    address,
    reminderFrequency,
    lastReminderSentAt,
    createdAt,
    updatedAt,
    isSynced,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Customer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('mobile')) {
      context.handle(
        _mobileMeta,
        mobile.isAcceptableOrUnknown(data['mobile']!, _mobileMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('reminder_frequency')) {
      context.handle(
        _reminderFrequencyMeta,
        reminderFrequency.isAcceptableOrUnknown(
          data['reminder_frequency']!,
          _reminderFrequencyMeta,
        ),
      );
    }
    if (data.containsKey('last_reminder_sent_at')) {
      context.handle(
        _lastReminderSentAtMeta,
        lastReminderSentAt.isAcceptableOrUnknown(
          data['last_reminder_sent_at']!,
          _lastReminderSentAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      mobile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mobile'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      reminderFrequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_frequency'],
      )!,
      lastReminderSentAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_reminder_sent_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String uuid;
  final String name;
  final String? mobile;
  final String? address;
  final String reminderFrequency;
  final DateTime? lastReminderSentAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// false = pending sync
  /// true = already synced
  final bool isSynced;

  /// null = active
  /// not null = deleted locally (will sync later)
  final DateTime? deletedAt;
  const Customer({
    required this.id,
    required this.uuid,
    required this.name,
    this.mobile,
    this.address,
    required this.reminderFrequency,
    this.lastReminderSentAt,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || mobile != null) {
      map['mobile'] = Variable<String>(mobile);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['reminder_frequency'] = Variable<String>(reminderFrequency);
    if (!nullToAbsent || lastReminderSentAt != null) {
      map['last_reminder_sent_at'] = Variable<DateTime>(lastReminderSentAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      uuid: Value(uuid),
      name: Value(name),
      mobile: mobile == null && nullToAbsent
          ? const Value.absent()
          : Value(mobile),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      reminderFrequency: Value(reminderFrequency),
      lastReminderSentAt: lastReminderSentAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReminderSentAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Customer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      mobile: serializer.fromJson<String?>(json['mobile']),
      address: serializer.fromJson<String?>(json['address']),
      reminderFrequency: serializer.fromJson<String>(json['reminderFrequency']),
      lastReminderSentAt: serializer.fromJson<DateTime?>(
        json['lastReminderSentAt'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'mobile': serializer.toJson<String?>(mobile),
      'address': serializer.toJson<String?>(address),
      'reminderFrequency': serializer.toJson<String>(reminderFrequency),
      'lastReminderSentAt': serializer.toJson<DateTime?>(lastReminderSentAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Customer copyWith({
    int? id,
    String? uuid,
    String? name,
    Value<String?> mobile = const Value.absent(),
    Value<String?> address = const Value.absent(),
    String? reminderFrequency,
    Value<DateTime?> lastReminderSentAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Customer(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    name: name ?? this.name,
    mobile: mobile.present ? mobile.value : this.mobile,
    address: address.present ? address.value : this.address,
    reminderFrequency: reminderFrequency ?? this.reminderFrequency,
    lastReminderSentAt: lastReminderSentAt.present
        ? lastReminderSentAt.value
        : this.lastReminderSentAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      mobile: data.mobile.present ? data.mobile.value : this.mobile,
      address: data.address.present ? data.address.value : this.address,
      reminderFrequency: data.reminderFrequency.present
          ? data.reminderFrequency.value
          : this.reminderFrequency,
      lastReminderSentAt: data.lastReminderSentAt.present
          ? data.lastReminderSentAt.value
          : this.lastReminderSentAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('mobile: $mobile, ')
          ..write('address: $address, ')
          ..write('reminderFrequency: $reminderFrequency, ')
          ..write('lastReminderSentAt: $lastReminderSentAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    name,
    mobile,
    address,
    reminderFrequency,
    lastReminderSentAt,
    createdAt,
    updatedAt,
    isSynced,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.mobile == this.mobile &&
          other.address == this.address &&
          other.reminderFrequency == this.reminderFrequency &&
          other.lastReminderSentAt == this.lastReminderSentAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced &&
          other.deletedAt == this.deletedAt);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> name;
  final Value<String?> mobile;
  final Value<String?> address;
  final Value<String> reminderFrequency;
  final Value<DateTime?> lastReminderSentAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<DateTime?> deletedAt;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.mobile = const Value.absent(),
    this.address = const Value.absent(),
    this.reminderFrequency = const Value.absent(),
    this.lastReminderSentAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String name,
    this.mobile = const Value.absent(),
    this.address = const Value.absent(),
    this.reminderFrequency = const Value.absent(),
    this.lastReminderSentAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : uuid = Value(uuid),
       name = Value(name);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? mobile,
    Expression<String>? address,
    Expression<String>? reminderFrequency,
    Expression<DateTime>? lastReminderSentAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (mobile != null) 'mobile': mobile,
      if (address != null) 'address': address,
      if (reminderFrequency != null) 'reminder_frequency': reminderFrequency,
      if (lastReminderSentAt != null)
        'last_reminder_sent_at': lastReminderSentAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  CustomersCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? name,
    Value<String?>? mobile,
    Value<String?>? address,
    Value<String>? reminderFrequency,
    Value<DateTime?>? lastReminderSentAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<DateTime?>? deletedAt,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      address: address ?? this.address,
      reminderFrequency: reminderFrequency ?? this.reminderFrequency,
      lastReminderSentAt: lastReminderSentAt ?? this.lastReminderSentAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (mobile.present) {
      map['mobile'] = Variable<String>(mobile.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (reminderFrequency.present) {
      map['reminder_frequency'] = Variable<String>(reminderFrequency.value);
    }
    if (lastReminderSentAt.present) {
      map['last_reminder_sent_at'] = Variable<DateTime>(
        lastReminderSentAt.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('mobile: $mobile, ')
          ..write('address: $address, ')
          ..write('reminderFrequency: $reminderFrequency, ')
          ..write('lastReminderSentAt: $lastReminderSentAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $LedgerEntriesTable extends LedgerEntries
    with TableInfo<$LedgerEntriesTable, LedgerEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LedgerEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _customerUuidMeta = const VerificationMeta(
    'customerUuid',
  );
  @override
  late final GeneratedColumn<String> customerUuid = GeneratedColumn<String>(
    'customer_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entryDateMeta = const VerificationMeta(
    'entryDate',
  );
  @override
  late final GeneratedColumn<DateTime> entryDate = GeneratedColumn<DateTime>(
    'entry_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    customerUuid,
    type,
    amount,
    note,
    entryDate,
    createdAt,
    updatedAt,
    isSynced,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ledger_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<LedgerEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('customer_uuid')) {
      context.handle(
        _customerUuidMeta,
        customerUuid.isAcceptableOrUnknown(
          data['customer_uuid']!,
          _customerUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerUuidMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('entry_date')) {
      context.handle(
        _entryDateMeta,
        entryDate.isAcceptableOrUnknown(data['entry_date']!, _entryDateMeta),
      );
    } else if (isInserting) {
      context.missing(_entryDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LedgerEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LedgerEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      customerUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_uuid'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      entryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}entry_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $LedgerEntriesTable createAlias(String alias) {
    return $LedgerEntriesTable(attachedDatabase, alias);
  }
}

class LedgerEntry extends DataClass implements Insertable<LedgerEntry> {
  final int id;
  final String uuid;
  final String customerUuid;

  /// credit = Udhari
  /// payment = Payment Received
  final String type;
  final double amount;
  final String? note;
  final DateTime entryDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// false = pending sync
  /// true = already synced
  final bool isSynced;

  /// null = active
  /// not null = deleted locally (will sync later)
  final DateTime? deletedAt;
  const LedgerEntry({
    required this.id,
    required this.uuid,
    required this.customerUuid,
    required this.type,
    required this.amount,
    this.note,
    required this.entryDate,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['customer_uuid'] = Variable<String>(customerUuid);
    map['type'] = Variable<String>(type);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['entry_date'] = Variable<DateTime>(entryDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  LedgerEntriesCompanion toCompanion(bool nullToAbsent) {
    return LedgerEntriesCompanion(
      id: Value(id),
      uuid: Value(uuid),
      customerUuid: Value(customerUuid),
      type: Value(type),
      amount: Value(amount),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      entryDate: Value(entryDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory LedgerEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LedgerEntry(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      customerUuid: serializer.fromJson<String>(json['customerUuid']),
      type: serializer.fromJson<String>(json['type']),
      amount: serializer.fromJson<double>(json['amount']),
      note: serializer.fromJson<String?>(json['note']),
      entryDate: serializer.fromJson<DateTime>(json['entryDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'customerUuid': serializer.toJson<String>(customerUuid),
      'type': serializer.toJson<String>(type),
      'amount': serializer.toJson<double>(amount),
      'note': serializer.toJson<String?>(note),
      'entryDate': serializer.toJson<DateTime>(entryDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  LedgerEntry copyWith({
    int? id,
    String? uuid,
    String? customerUuid,
    String? type,
    double? amount,
    Value<String?> note = const Value.absent(),
    DateTime? entryDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => LedgerEntry(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    customerUuid: customerUuid ?? this.customerUuid,
    type: type ?? this.type,
    amount: amount ?? this.amount,
    note: note.present ? note.value : this.note,
    entryDate: entryDate ?? this.entryDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  LedgerEntry copyWithCompanion(LedgerEntriesCompanion data) {
    return LedgerEntry(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      customerUuid: data.customerUuid.present
          ? data.customerUuid.value
          : this.customerUuid,
      type: data.type.present ? data.type.value : this.type,
      amount: data.amount.present ? data.amount.value : this.amount,
      note: data.note.present ? data.note.value : this.note,
      entryDate: data.entryDate.present ? data.entryDate.value : this.entryDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LedgerEntry(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('customerUuid: $customerUuid, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('note: $note, ')
          ..write('entryDate: $entryDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    customerUuid,
    type,
    amount,
    note,
    entryDate,
    createdAt,
    updatedAt,
    isSynced,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LedgerEntry &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.customerUuid == this.customerUuid &&
          other.type == this.type &&
          other.amount == this.amount &&
          other.note == this.note &&
          other.entryDate == this.entryDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced &&
          other.deletedAt == this.deletedAt);
}

class LedgerEntriesCompanion extends UpdateCompanion<LedgerEntry> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> customerUuid;
  final Value<String> type;
  final Value<double> amount;
  final Value<String?> note;
  final Value<DateTime> entryDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<DateTime?> deletedAt;
  const LedgerEntriesCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.customerUuid = const Value.absent(),
    this.type = const Value.absent(),
    this.amount = const Value.absent(),
    this.note = const Value.absent(),
    this.entryDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  LedgerEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String customerUuid,
    required String type,
    required double amount,
    this.note = const Value.absent(),
    required DateTime entryDate,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : uuid = Value(uuid),
       customerUuid = Value(customerUuid),
       type = Value(type),
       amount = Value(amount),
       entryDate = Value(entryDate);
  static Insertable<LedgerEntry> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? customerUuid,
    Expression<String>? type,
    Expression<double>? amount,
    Expression<String>? note,
    Expression<DateTime>? entryDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (customerUuid != null) 'customer_uuid': customerUuid,
      if (type != null) 'type': type,
      if (amount != null) 'amount': amount,
      if (note != null) 'note': note,
      if (entryDate != null) 'entry_date': entryDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  LedgerEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? customerUuid,
    Value<String>? type,
    Value<double>? amount,
    Value<String?>? note,
    Value<DateTime>? entryDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<DateTime?>? deletedAt,
  }) {
    return LedgerEntriesCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      customerUuid: customerUuid ?? this.customerUuid,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      entryDate: entryDate ?? this.entryDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (customerUuid.present) {
      map['customer_uuid'] = Variable<String>(customerUuid.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (entryDate.present) {
      map['entry_date'] = Variable<DateTime>(entryDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LedgerEntriesCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('customerUuid: $customerUuid, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('note: $note, ')
          ..write('entryDate: $entryDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $ShoppingItemsTable shoppingItems = $ShoppingItemsTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $LedgerEntriesTable ledgerEntries = $LedgerEntriesTable(this);
  late final ProductDao productDao = ProductDao(this as AppDatabase);
  late final ShoppingDao shoppingDao = ShoppingDao(this as AppDatabase);
  late final CustomerDao customerDao = CustomerDao(this as AppDatabase);
  late final LedgerDao ledgerDao = LedgerDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    products,
    shoppingItems,
    customers,
    ledgerEntries,
  ];
}

typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      required String uuid,
      required String name,
      Value<String?> barcode,
      required double purchasePrice,
      required double sellingPrice,
      required double mrp,
      required String unit,
      Value<bool> isLooseItem,
      Value<int> stock,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<DateTime?> deletedAt,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> name,
      Value<String?> barcode,
      Value<double> purchasePrice,
      Value<double> sellingPrice,
      Value<double> mrp,
      Value<String> unit,
      Value<bool> isLooseItem,
      Value<int> stock,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<DateTime?> deletedAt,
    });

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mrp => $composableBuilder(
    column: $table.mrp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLooseItem => $composableBuilder(
    column: $table.isLooseItem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stock => $composableBuilder(
    column: $table.stock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mrp => $composableBuilder(
    column: $table.mrp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLooseItem => $composableBuilder(
    column: $table.isLooseItem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stock => $composableBuilder(
    column: $table.stock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get mrp =>
      $composableBuilder(column: $table.mrp, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<bool> get isLooseItem => $composableBuilder(
    column: $table.isLooseItem,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stock =>
      $composableBuilder(column: $table.stock, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
          Product,
          PrefetchHooks Function()
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<double> purchasePrice = const Value.absent(),
                Value<double> sellingPrice = const Value.absent(),
                Value<double> mrp = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<bool> isLooseItem = const Value.absent(),
                Value<int> stock = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                uuid: uuid,
                name: name,
                barcode: barcode,
                purchasePrice: purchasePrice,
                sellingPrice: sellingPrice,
                mrp: mrp,
                unit: unit,
                isLooseItem: isLooseItem,
                stock: stock,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                deletedAt: deletedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required String name,
                Value<String?> barcode = const Value.absent(),
                required double purchasePrice,
                required double sellingPrice,
                required double mrp,
                required String unit,
                Value<bool> isLooseItem = const Value.absent(),
                Value<int> stock = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                uuid: uuid,
                name: name,
                barcode: barcode,
                purchasePrice: purchasePrice,
                sellingPrice: sellingPrice,
                mrp: mrp,
                unit: unit,
                isLooseItem: isLooseItem,
                stock: stock,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                deletedAt: deletedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
      Product,
      PrefetchHooks Function()
    >;
typedef $$ShoppingItemsTableCreateCompanionBuilder =
    ShoppingItemsCompanion Function({
      Value<int> id,
      required String uuid,
      required String name,
      Value<String> category,
      Value<bool> isPurchased,
      Value<bool> isSynced,
      Value<DateTime?> deletedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ShoppingItemsTableUpdateCompanionBuilder =
    ShoppingItemsCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> name,
      Value<String> category,
      Value<bool> isPurchased,
      Value<bool> isSynced,
      Value<DateTime?> deletedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$ShoppingItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ShoppingItemsTable> {
  $$ShoppingItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPurchased => $composableBuilder(
    column: $table.isPurchased,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShoppingItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShoppingItemsTable> {
  $$ShoppingItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPurchased => $composableBuilder(
    column: $table.isPurchased,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShoppingItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShoppingItemsTable> {
  $$ShoppingItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isPurchased => $composableBuilder(
    column: $table.isPurchased,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ShoppingItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShoppingItemsTable,
          ShoppingItem,
          $$ShoppingItemsTableFilterComposer,
          $$ShoppingItemsTableOrderingComposer,
          $$ShoppingItemsTableAnnotationComposer,
          $$ShoppingItemsTableCreateCompanionBuilder,
          $$ShoppingItemsTableUpdateCompanionBuilder,
          (
            ShoppingItem,
            BaseReferences<_$AppDatabase, $ShoppingItemsTable, ShoppingItem>,
          ),
          ShoppingItem,
          PrefetchHooks Function()
        > {
  $$ShoppingItemsTableTableManager(_$AppDatabase db, $ShoppingItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShoppingItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShoppingItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShoppingItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isPurchased = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ShoppingItemsCompanion(
                id: id,
                uuid: uuid,
                name: name,
                category: category,
                isPurchased: isPurchased,
                isSynced: isSynced,
                deletedAt: deletedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required String name,
                Value<String> category = const Value.absent(),
                Value<bool> isPurchased = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ShoppingItemsCompanion.insert(
                id: id,
                uuid: uuid,
                name: name,
                category: category,
                isPurchased: isPurchased,
                isSynced: isSynced,
                deletedAt: deletedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShoppingItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShoppingItemsTable,
      ShoppingItem,
      $$ShoppingItemsTableFilterComposer,
      $$ShoppingItemsTableOrderingComposer,
      $$ShoppingItemsTableAnnotationComposer,
      $$ShoppingItemsTableCreateCompanionBuilder,
      $$ShoppingItemsTableUpdateCompanionBuilder,
      (
        ShoppingItem,
        BaseReferences<_$AppDatabase, $ShoppingItemsTable, ShoppingItem>,
      ),
      ShoppingItem,
      PrefetchHooks Function()
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      required String uuid,
      required String name,
      Value<String?> mobile,
      Value<String?> address,
      Value<String> reminderFrequency,
      Value<DateTime?> lastReminderSentAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<DateTime?> deletedAt,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> name,
      Value<String?> mobile,
      Value<String?> address,
      Value<String> reminderFrequency,
      Value<DateTime?> lastReminderSentAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<DateTime?> deletedAt,
    });

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reminderFrequency => $composableBuilder(
    column: $table.reminderFrequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReminderSentAt => $composableBuilder(
    column: $table.lastReminderSentAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderFrequency => $composableBuilder(
    column: $table.reminderFrequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReminderSentAt => $composableBuilder(
    column: $table.lastReminderSentAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get mobile =>
      $composableBuilder(column: $table.mobile, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get reminderFrequency => $composableBuilder(
    column: $table.reminderFrequency,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastReminderSentAt => $composableBuilder(
    column: $table.lastReminderSentAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, BaseReferences<_$AppDatabase, $CustomersTable, Customer>),
          Customer,
          PrefetchHooks Function()
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> mobile = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String> reminderFrequency = const Value.absent(),
                Value<DateTime?> lastReminderSentAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                uuid: uuid,
                name: name,
                mobile: mobile,
                address: address,
                reminderFrequency: reminderFrequency,
                lastReminderSentAt: lastReminderSentAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                deletedAt: deletedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required String name,
                Value<String?> mobile = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String> reminderFrequency = const Value.absent(),
                Value<DateTime?> lastReminderSentAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                uuid: uuid,
                name: name,
                mobile: mobile,
                address: address,
                reminderFrequency: reminderFrequency,
                lastReminderSentAt: lastReminderSentAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                deletedAt: deletedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, BaseReferences<_$AppDatabase, $CustomersTable, Customer>),
      Customer,
      PrefetchHooks Function()
    >;
typedef $$LedgerEntriesTableCreateCompanionBuilder =
    LedgerEntriesCompanion Function({
      Value<int> id,
      required String uuid,
      required String customerUuid,
      required String type,
      required double amount,
      Value<String?> note,
      required DateTime entryDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<DateTime?> deletedAt,
    });
typedef $$LedgerEntriesTableUpdateCompanionBuilder =
    LedgerEntriesCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> customerUuid,
      Value<String> type,
      Value<double> amount,
      Value<String?> note,
      Value<DateTime> entryDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<DateTime?> deletedAt,
    });

class $$LedgerEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $LedgerEntriesTable> {
  $$LedgerEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerUuid => $composableBuilder(
    column: $table.customerUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get entryDate => $composableBuilder(
    column: $table.entryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LedgerEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LedgerEntriesTable> {
  $$LedgerEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerUuid => $composableBuilder(
    column: $table.customerUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get entryDate => $composableBuilder(
    column: $table.entryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LedgerEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LedgerEntriesTable> {
  $$LedgerEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get customerUuid => $composableBuilder(
    column: $table.customerUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get entryDate =>
      $composableBuilder(column: $table.entryDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$LedgerEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LedgerEntriesTable,
          LedgerEntry,
          $$LedgerEntriesTableFilterComposer,
          $$LedgerEntriesTableOrderingComposer,
          $$LedgerEntriesTableAnnotationComposer,
          $$LedgerEntriesTableCreateCompanionBuilder,
          $$LedgerEntriesTableUpdateCompanionBuilder,
          (
            LedgerEntry,
            BaseReferences<_$AppDatabase, $LedgerEntriesTable, LedgerEntry>,
          ),
          LedgerEntry,
          PrefetchHooks Function()
        > {
  $$LedgerEntriesTableTableManager(_$AppDatabase db, $LedgerEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LedgerEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LedgerEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LedgerEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> customerUuid = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> entryDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => LedgerEntriesCompanion(
                id: id,
                uuid: uuid,
                customerUuid: customerUuid,
                type: type,
                amount: amount,
                note: note,
                entryDate: entryDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                deletedAt: deletedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required String customerUuid,
                required String type,
                required double amount,
                Value<String?> note = const Value.absent(),
                required DateTime entryDate,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => LedgerEntriesCompanion.insert(
                id: id,
                uuid: uuid,
                customerUuid: customerUuid,
                type: type,
                amount: amount,
                note: note,
                entryDate: entryDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                deletedAt: deletedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LedgerEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LedgerEntriesTable,
      LedgerEntry,
      $$LedgerEntriesTableFilterComposer,
      $$LedgerEntriesTableOrderingComposer,
      $$LedgerEntriesTableAnnotationComposer,
      $$LedgerEntriesTableCreateCompanionBuilder,
      $$LedgerEntriesTableUpdateCompanionBuilder,
      (
        LedgerEntry,
        BaseReferences<_$AppDatabase, $LedgerEntriesTable, LedgerEntry>,
      ),
      LedgerEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$ShoppingItemsTableTableManager get shoppingItems =>
      $$ShoppingItemsTableTableManager(_db, _db.shoppingItems);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$LedgerEntriesTableTableManager get ledgerEntries =>
      $$LedgerEntriesTableTableManager(_db, _db.ledgerEntries);
}
