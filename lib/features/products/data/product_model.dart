class ProductModel {
  final int? id;
  final String name;
  final String? barcode;
  final double purchasePrice;
  final double sellingPrice;
  final double mrp;
  final String unit;
  final bool isLooseItem;
  final int stock;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductModel({
    this.id,
    required this.name,
    this.barcode,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.mrp,
    required this.unit,
    required this.isLooseItem,
    this.stock = 0,
    this.createdAt,
    this.updatedAt,
  });

  ProductModel copyWith({
    int? id,
    String? name,
    String? barcode,
    double? purchasePrice,
    double? sellingPrice,
    double? mrp,
    String? unit,
    bool? isLooseItem,
    int? stock,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
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
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int?,
      name: json['name'] ?? '',
      barcode: json['barcode'],
      purchasePrice: (json['purchase_price'] as num).toDouble(),
      sellingPrice: (json['selling_price'] as num).toDouble(),
      mrp: (json['mrp'] as num).toDouble(),
      unit: json['unit'] ?? 'Piece',
      isLooseItem: json['is_loose_item'] ?? false,
      stock: json['stock'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'barcode': barcode,
      'purchase_price': purchasePrice,
      'selling_price': sellingPrice,
      'mrp': mrp,
      'unit': unit,
      'is_loose_item': isLooseItem,
      'stock': stock,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  bool get isWeighted =>
      unit.toLowerCase() == 'kg' ||
          unit.toLowerCase() == 'gram';

  bool get isLiquid =>
      unit.toLowerCase() == 'litre' ||
          unit.toLowerCase() == 'ml';
}