import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sekar_fb/pages/admin/admin_home.dart';
import 'package:sekar_fb/pages/ctrl/user_ctrl.dart';
import 'package:sekar_fb/pages/ctrl/user_data.dart';
import 'package:sekar_fb/pages/cust/detail_cust.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    addToUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('toko oren')),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminHome()),
                );
              },
              icon: const Icon(Icons.person),
            ),
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.currentUser!.delete();
              },
              icon: const Icon(Icons.delete_forever),
            ),
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          onPressed: () {
            setState(() {});
          },
          child: const Icon(Icons.refresh),
        ),
        body: FutureBuilder(
          future: getColl(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (produkList.isEmpty) {
                return const Center(child: Text('barang kosong'));
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                      produkList.length,
                      (index) {
                        final data = produkList[index];
                        final id = data.id;
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(backgroundImage: NetworkImage(data.image)),
                            selected: selectedId == id,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailCust(
                                          id: id,
                                        )),
                              );
                              setState(() {
                                selectedId = id;
                              });
                            },
                            title: Text(
                              data.nama,
                            ),
                            subtitle: Text('Rp. ${data.harga}'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    isEnd
                        ? const Text('is end')
                        : snapshot.connectionState == ConnectionState.waiting
                            ? const CircularProgressIndicator()
                            : OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    addToUserList();
                                  });
                                },
                                child: const Text('load more'),
                              )
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
