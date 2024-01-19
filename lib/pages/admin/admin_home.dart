import 'package:flutter/material.dart';
import 'package:sekar_fb/pages/ctrl/user_ctrl.dart';
import 'package:sekar_fb/pages/ctrl/user_data.dart';
import 'package:sekar_fb/pages/admin/admin_detail.dart';
import 'package:sekar_fb/pages/admin/admin_input.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  void initState() {
    addToUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('admin')),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: '1',
              onPressed: () {
                setState(() {});
              },
              child: const Icon(Icons.refresh),
            ),
            const SizedBox(height: 5),
            FloatingActionButton(
              heroTag: '2',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminInput()),
                );
              },
              child: const Icon(Icons.add),
            ),
          ],
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
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(data.image),
                            ),
                            selected: selectedId == id,
                            onTap: () {
                              setState(() {
                                selectedId = id;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminDetail(
                                          id: id,
                                        )),
                              );
                            },
                            title: Text(
                              data.nama,
                            ),
                            subtitle: Text(data.createdAt),
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
