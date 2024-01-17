import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sekar_fb/model/users.dart';
import 'package:sekar_fb/pages/users/user_data.dart';

Future<void> create(UserX data) async {
  final docId = data.id;
  var nama = data.nama;
  final createdAt = data.createdAt;
  await FirebaseFirestore.instance
      .collection('KoleksiBarang')
      .doc(docId)
      .set({'nama': nama, 'id': docId, 'created_at': createdAt});
  await FirebaseFirestore.instance.collection('DetailBarang').doc(docId).set(data.toMap());
  userList.insert(0, data);
}

Future<List<UserX>> getColl() async {
  List<UserX> users = [];

  // final result = await FirebaseFirestore.instance.collection('username').get();
  final result = await FirebaseFirestore.instance
      .collection('KoleksiBarang')
      .orderBy(
        'created_at',
        descending: true,
      )
      .limit(5)
      .startAfter([userList.isEmpty ? '9999-99-99' : userList.last.createdAt]).get();
  for (var doc in result.docs) {
    users.add(UserX.fromMap(doc.data()));
  }
  return users;
}

Future<UserX> getDoc(String id) async {
  final result = await FirebaseFirestore.instance.collection('DetailBarang').doc(id).get();
  final user = UserX.fromMap(result.data() ?? {});
  return user;
}

addToUserList() async {
  final dataCol = await getColl();
  userList.addAll(dataCol);
  if (dataCol.length < 5) {
    isEnd = true;
  }
}

Future<void> deleteDoc(String id) async {
  await FirebaseFirestore.instance.collection('KoleksiBarang').doc(id).delete();
  await FirebaseFirestore.instance.collection('DetailBarang').doc(id).delete();
  final index = userList.indexWhere((element) => element.id == id);
  userList.removeAt(index);
}

Future<void> updateDoc(UserX data) async {
  final docId = data.id;
  var nama = data.nama;
  final createdAt = data.createdAt;
  await FirebaseFirestore.instance
      .collection('KoleksiBarang')
      .doc(docId)
      .set({'nama': nama, 'id': docId, 'created_at': createdAt});
  await FirebaseFirestore.instance.collection('DetailBarang').doc(docId).set(data.toMap());
  final index = userList.indexWhere((element) => element.id == docId);
  userList[index] = data;
}

Future<String> upload() async {
  final namaPhoto = pickedImageUpload?.name;
  final typePhoto = pickedImageUpload?.mimeType;
  final data = await pickedImageUpload!.readAsBytes();
  final metaData = SettableMetadata(contentType: typePhoto);
  final uploadImage = await FirebaseStorage.instance.ref('gallery/$namaPhoto').putData(data, metaData);

  imageUrl = await uploadImage.ref.getDownloadURL();
  debugPrint(uploadImage.toString());
  return uploadImage.toString();
}
