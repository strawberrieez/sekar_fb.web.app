import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sekar_fb/model/users.dart';

Future<void> create(UserX data) async {
  final docId = data.id;
  var nama = data.nama;
  final createdAt = data.createdAt;
  await FirebaseFirestore.instance
      .collection('KoleksiBarang')
      .doc(docId)
      .set({'nama': nama, 'id': docId, 'created_at': createdAt});
  await FirebaseFirestore.instance.collection('DetailBarang').doc(docId).set(data.toMap());
}
