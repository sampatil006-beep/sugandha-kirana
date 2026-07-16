class LedgerModel {
  final int? id;

  // Local + Supabase common id
  final String uuid;

  final String customerUuid;

  /// credit = Udhari
  /// payment = Payment Received
  final String type;

  final double amount;

  final String? note;

  final DateTime entryDate;

  final bool isSynced;

  final DateTime? deletedAt;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  const LedgerModel({
    this.id,
    required this.uuid,
    required this.customerUuid,
    required this.type,
    required this.amount,
    this.note,
    required this.entryDate,
    this.isSynced = false,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  LedgerModel copyWith({
    int? id,
    String? uuid,
    String? customerUuid,
    String? type,
    double? amount,
    String? note,
    DateTime? entryDate,
    bool? isSynced,
    DateTime? deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LedgerModel(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      customerUuid: customerUuid ?? this.customerUuid,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      entryDate: entryDate ?? this.entryDate,
      isSynced: isSynced ?? this.isSynced,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory LedgerModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return LedgerModel(
      id: json['id'] as int?,
      uuid: json['uuid'] ?? '',
      customerUuid: json['customer_uuid'] ?? '',
      type: json['type'] ?? 'credit',
      amount: (json['amount'] as num).toDouble(),
      note: json['note'],
      entryDate: DateTime.parse(
        json['entry_date'],
      ),
      isSynced: json['is_synced'] ?? false,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(
        json['deleted_at'],
      )
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(
        json['created_at'],
      )
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(
        json['updated_at'],
      )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'customer_uuid': customerUuid,
      'type': type,
      'amount': amount,
      'note': note,
      'entry_date': entryDate.toIso8601String(),
      'is_synced': isSynced,
      'deleted_at': deletedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  bool get isCredit => type == 'credit';

  bool get isPayment => type == 'payment';
}