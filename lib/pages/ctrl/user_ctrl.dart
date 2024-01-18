import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sekar_fb/model/users.dart';
import 'package:sekar_fb/pages/ctrl/user_data.dart';

Future<void> create(Product data) async {
  final docId = data.id;
  final nama = data.nama;
  final harga = data.harga;
  final createdAt = data.createdAt;
  final image = data.image;
  await FirebaseFirestore.instance.collection('Barang').doc(docId).set({
    'nama': nama,
    'id': docId,
    'created_at': createdAt,
    'image': image,
    'harga': harga,
  });
  await FirebaseFirestore.instance.collection('DetailBarang').doc(docId).set(data.toMap());
  produkList.insert(0, data);
}

Future<List<Product>> getColl() async {
  List<Product> products = [];

  final result = await FirebaseFirestore.instance
      .collection('Barang')
      .orderBy(
        'created_at',
        descending: true,
      )
      .limit(5)
      .startAfter([produkList.isEmpty ? '9999-99-99' : produkList.last.createdAt]).get();
  for (var doc in result.docs) {
    products.add(Product.fromMap(doc.data()));
  }
  return products;
}

Future<Product> getDoc(String id) async {
  final result = await FirebaseFirestore.instance.collection('DetailBarang').doc(id).get();
  productDetail = Product.fromMap(result.data() ?? {});

  return productDetail!;
}

addToUserList() async {
  final dataCol = await getColl();
  produkList.addAll(dataCol);
  if (dataCol.length < 5) {
    isEnd = true;
  }
}

Future<void> deleteDoc(String id) async {
  await FirebaseFirestore.instance.collection('Barang').doc(id).delete();
  await FirebaseFirestore.instance.collection('DetailBarang').doc(id).delete();
  final index = produkList.indexWhere((element) => element.id == id);
  produkList.removeAt(index);
}

Future<String> upload() async {
  final namaPhoto = pickedImageUpload?.name;
  final typePhoto = pickedImageUpload?.mimeType;
  final data = await pickedImageUpload!.readAsBytes();
  final metaData = SettableMetadata(contentType: typePhoto);
  final uploadImage = await FirebaseStorage.instance.ref(namaPhoto).putData(data, metaData);

  imageUrl = await uploadImage.ref.getDownloadURL();
  debugPrint(uploadImage.toString());
  return imageUrl;
}

Future<void> updateDoc(Product data) async {
  final docId = data.id;
  final nama = data.nama;
  final createdAt = data.createdAt;
  final image = data.image;
  debugPrint(docId);
  await FirebaseFirestore.instance.collection('Barang').doc(docId).set({
    'nama': nama,
    'id': docId,
    'created_at': createdAt,
    'image': image,
  });
  await FirebaseFirestore.instance.collection('DetailBarang').doc(docId).set(data.toMap());
  final index = produkList.indexWhere((element) => element.id == docId);
  produkList[index] = data;
}

void initProduct() async {
  await getDoc(selectedId);
}
