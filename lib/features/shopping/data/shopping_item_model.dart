class ShoppingItemModel {
  final int? id;

  // Local + Supabase common id
  final String uuid;

  final String name;
  final String category;
  final bool isPurchased;

  final bool isSynced;
  final DateTime? deletedAt;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ShoppingItemModel({
    this.id,
    required this.uuid,
    required this.name,
    this.category = 'Other',
    this.isPurchased = false,
    this.isSynced = false,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  ShoppingItemModel copyWith({
    int? id,
    String? uuid,
    String? name,
    String? category,
    bool? isPurchased,
    bool? isSynced,
    DateTime? deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ShoppingItemModel(
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

  factory ShoppingItemModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return ShoppingItemModel(
      id: json['id'] as int?,
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? 'Other',
      isPurchased: json['is_purchased'] ?? false,
      isSynced: json['is_synced'] ?? false,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
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
      'uuid': uuid,
      'name': name,
      'category': category,
      'is_purchased': isPurchased,
      'is_synced': isSynced,
      'deleted_at': deletedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}