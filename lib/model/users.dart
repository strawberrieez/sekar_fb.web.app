import 'dart:convert';

class Product {
  final String nama;
  final int harga;
  final String id;
  final String createdAt;
  final String image;
  Product({
    this.nama = '',
    this.harga = 0,
    this.id = '',
    this.createdAt = '',
    this.image = '',
  });

  Product copyWith({
    String? nama,
    int? harga,
    String? id,
    String? createdAt,
    String? image,
  }) {
    return Product(
      nama: nama ?? this.nama,
      harga: harga ?? this.harga,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'nama': nama});
    result.addAll({'harga': harga});
    result.addAll({'id': id});
    result.addAll({'created_at': createdAt});
    result.addAll({'image': image});

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      nama: map['nama'] ?? '',
      harga: map['harga']?.toInt() ?? 0,
      id: map['id'] ?? '',
      createdAt: map['created_at'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserX(nama: $nama, harga: $harga, id: $id, createdAt: $createdAt, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.nama == nama &&
        other.harga == harga &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.image == image;
  }

  @override
  int get hashCode {
    return nama.hashCode ^ harga.hashCode ^ id.hashCode ^ createdAt.hashCode ^ image.hashCode;
  }
}
