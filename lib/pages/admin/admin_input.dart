import 'package:flutter/material.dart';
import 'package:sekar_fb/model/users.dart';
import 'package:sekar_fb/pages/ctrl/user_ctrl.dart';
import 'package:sekar_fb/pages/ctrl/user_data.dart';
import 'package:image_picker/image_picker.dart';

class AdminInput extends StatefulWidget {
  const AdminInput({super.key});

  @override
  State<AdminInput> createState() => _AdminInputState();
}

class _AdminInputState extends State<AdminInput> {
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
            pickedImage == null
                ? const SizedBox.shrink()
                : SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.network('${pickedImage?.path}'),
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
                controller: inputNama,
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
                            inputNama.clear();
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
                controller: inputHarga,
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
                            inputHarga.clear();
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
                pickedImageUpload = pickedImage;
                await upload();
                final valNama = inputNama.text;
                final valHarga = int.parse(inputHarga.text);
                final docId = UniqueKey().toString();
                final newUser = Product(
                  createdAt: DateTime.now().toString(),
                  nama: valNama,
                  harga: valHarga,
                  id: docId,
                  image: imageUrl,
                );
                setState(() {
                  isLoading = true;
                });
                await create(newUser);
                setState(() {
                  isLoading = false;
                });
                inputHarga.clear();
                inputNama.clear();
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
