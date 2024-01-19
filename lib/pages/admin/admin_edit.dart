import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sekar_fb/model/users.dart';
import 'package:sekar_fb/pages/ctrl/user_ctrl.dart';
import 'package:sekar_fb/pages/ctrl/user_data.dart';

class AdminEdit extends StatefulWidget {
  const AdminEdit({super.key, required this.id});
  final String id;
  @override
  State<AdminEdit> createState() => _AdminEditState();
}

class _AdminEditState extends State<AdminEdit> {
  @override
  void initState() {
    super.initState();
    editNama.text = '${productDetail?.nama}';
    editHarga.text = '${productDetail?.harga}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('update'),
      ),
      body: FutureBuilder(
        future: getDoc(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  pickedImageUpload == null
                      ? Card(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white10,
                            ),
                            height: 200,
                            width: 200,
                            child: Image.network(productDetail!.image),
                          ),
                        )
                      : SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.network(pickedImageUpload!.path),
                        ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      pickedImageUpload = await ImagePicker().pickImage(source: ImageSource.gallery);
                      setState(() {});
                    },
                    child: const Text(
                      "edit image",
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
                      final valNama = editNama.text;
                      final valHarga = int.parse(editHarga.text);
                      final newUserUpdate = Product(
                        nama: valNama,
                        harga: valHarga,
                        image: await upload(),
                        id: snapshot.data!.id,
                        createdAt: snapshot.data!.createdAt,
                      );
                      setState(() {
                        isLoading = true;
                      });

                      await updateDoc(newUserUpdate);
                      setState(() {
                        isLoading = false;
                      });
                      inputHarga.clear();
                      inputNama.clear();

                      Navigator.pop(context);
                    },
                    child: Text(isLoading ? 'loading...' : 'update'),
                  ),
                ],
              ),
            );
          }
          return const Text('text');
        },
      ),
    );
  }
}
