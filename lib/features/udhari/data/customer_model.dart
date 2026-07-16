class CustomerModel {
  final int? id;

  // Local + Supabase common id
  final String uuid;

  final String name;
  final String? mobile;
  final String? address;

  final bool isSynced;
  final DateTime? deletedAt;

  final DateTime? lastReminderSentAt;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CustomerModel({
    this.id,
    required this.uuid,
    required this.name,
    this.mobile,
    this.address,
    this.isSynced = false,
    this.deletedAt,
    this.lastReminderSentAt,
    this.createdAt,
    this.updatedAt,
  });

  CustomerModel copyWith({
    int? id,
    String? uuid,
    String? name,
    String? mobile,
    String? address,
    bool? isSynced,
    DateTime? deletedAt,
    DateTime? lastReminderSentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      address: address ?? this.address,
      isSynced: isSynced ?? this.isSynced,
      deletedAt: deletedAt ?? this.deletedAt,
      lastReminderSentAt:
      lastReminderSentAt ?? this.lastReminderSentAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory CustomerModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return CustomerModel(
      id: json['id'] as int?,
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      mobile: json['mobile'],
      address: json['address'],
      isSynced: json['is_synced'] ?? false,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      lastReminderSentAt:
      json['last_reminder_sent_at'] != null
          ? DateTime.parse(
        json['last_reminder_sent_at'],
      )
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
      'mobile': mobile,
      'address': address,
      'is_synced': isSynced,
      'deleted_at': deletedAt?.toIso8601String(),
      'last_reminder_sent_at':
      lastReminderSentAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}