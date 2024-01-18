import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sekar_fb/model/users.dart';
import 'package:sekar_fb/pages/ctrl/user_ctrl.dart';
import 'package:sekar_fb/pages/ctrl/user_data.dart';

class AdminEdit extends StatefulWidget {
  const AdminEdit({super.key});

  @override
  State<AdminEdit> createState() => _AdminEditState();
}

class _AdminEditState extends State<AdminEdit> {
  @override
  void initState() {
    super.initState();
    debugPrint(selectedId);
    getDoc(selectedId);
    editNama.text = '${productDetail?.nama}';
    editHarga.text = '${productDetail?.harga}';
    debugPrint(productDetail.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('update'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              width: 250,
              child: Image.network(pickedImage == null ? '${productDetail?.image}' : '${pickedImage?.path}'),
            ),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () async {
                  pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                  setState(() {});
                },
                child: const Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 5),
                    Text(
                      "Tambahkan foto produk",
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: editNama,
                onChanged: (value) {
                  setState(() {
                    scNama = value.isNotEmpty;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Masukkan nama barang',
                  labelText: 'nama barang',
                  suffixIcon: scNama
                      ? IconButton(
                          onPressed: () {
                            editNama.clear();
                            setState(() {
                              scNama = false;
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
                controller: editHarga,
                onChanged: (value) {
                  setState(() {
                    scHarga = value.isNotEmpty;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Masukkan harga barang',
                  labelText: 'harga barang',
                  suffixIcon: scHarga
                      ? IconButton(
                          onPressed: () {
                            editHarga.clear();
                            setState(() {
                              scHarga = false;
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
                // pickedImageUpdate = pickedImage;
                final valNama = editNama.text;
                final valHarga = int.parse(editHarga.text);
                // await updateDoc(newUserUpdate);
                setState(() {
                  isLoading = true;
                });
                await upload();
                setState(() {});
                final newUserUpdate = Product(
                    nama: valNama,
                    harga: valHarga,
                    image: imageUrl,
                    id: productDetail!.id,
                    createdAt: productDetail!.createdAt);
                await updateDoc(newUserUpdate);
                setState(() {
                  isLoading = false;
                });
                inputHarga.clear();
                inputNama.clear();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: Text(isLoading ? 'loading...' : 'update'),
            ),
          ],
        ),
      ),
    );
  }
}
