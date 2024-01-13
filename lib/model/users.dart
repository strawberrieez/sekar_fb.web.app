import 'dart:convert';

class UserX {
  final String nama;
  final int harga;
  final String id;
  final String createdAt;
  UserX({
    this.nama = '',
    this.harga = 0,
    this.id = '',
    this.createdAt = '',
  });

  UserX copyWith({
    String? nama,
    int? harga,
    String? id,
    String? createdAt,
  }) {
    return UserX(
      nama: nama ?? this.nama,
      harga: harga ?? this.harga,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'nama': nama});
    result.addAll({'harga': harga});
    result.addAll({'id': id});
    result.addAll({'created_at': createdAt});

    return result;
  }

  factory UserX.fromMap(Map<String, dynamic> map) {
    return UserX(
      nama: map['nama'] ?? '',
      harga: map['harga']?.toInt() ?? 0,
      id: map['id'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserX.fromJson(String source) => UserX.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserX(nama: $nama, harga: $harga, id: $id, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserX &&
        other.nama == nama &&
        other.harga == harga &&
        other.id == id &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return nama.hashCode ^ harga.hashCode ^ id.hashCode ^ createdAt.hashCode;
  }
}
