import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sekar_fb/model/users.dart';
import 'package:sekar_fb/pages/users/user_ctrl.dart';
import 'package:sekar_fb/pages/users/user_data.dart';

class UserInput extends StatefulWidget {
  const UserInput({super.key});

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Toko oren')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: ctrlNama,
                onChanged: (value) {
                  setState(() {
                    showClearNama = value.isNotEmpty;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Masukkan nama barang',
                  labelText: 'nama barang',
                  suffixIcon: showClearNama
                      ? IconButton(
                          onPressed: () {
                            ctrlNama.clear();
                            setState(() {
                              showClearNama = false;
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: ctrlHarga,
                onChanged: (value) {
                  setState(() {
                    showClearHarga = value.isNotEmpty;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Masukkan harga barang',
                  labelText: 'harga barang',
                  suffixIcon: showClearHarga
                      ? IconButton(
                          onPressed: () {
                            ctrlHarga.clear();
                            setState(() {
                              showClearHarga = false;
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final valNama = ctrlNama.text;
                final valHarga = int.parse(ctrlHarga.text);
                final docId = UniqueKey().toString();
                final newUser = UserX(
                  createdAt: DateTime.now().toString(),
                  nama: valNama,
                  harga: valHarga,
                  id: docId,
                );
                setState(() {
                  isLoading = true;
                });
                await FirebaseFirestore.instance.collection('username').doc(docId).set({'nama': valNama, 'id': docId});
                setState(() {
                  isLoading = false;
                });
                ctrlHarga.clear();
                ctrlNama.clear();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: Text(isLoading ? 'loading...' : 'submit'),
            ),
          ],
        ),
      ),
    );
  }
}
