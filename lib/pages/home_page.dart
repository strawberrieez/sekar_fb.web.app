import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sekar_fb/pages/users/user_ctrl.dart';
import 'package:sekar_fb/pages/users/user_data.dart';
import 'package:sekar_fb/pages/users/widgets/user_detail.dart';
import 'package:sekar_fb/pages/users/widgets/user_input.dart';

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
          title: const Center(child: Text('Toko oren')),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserInput()),
                );
              },
              icon: const Icon(Icons.person),
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
          onPressed: () {
            setState(() {});
          },
          child: const Icon(Icons.refresh),
        ),
        body: FutureBuilder(
          future: getColl(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (userList.isEmpty) {
                return const Center(child: Text('barang kosong'));
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                      userList.length,
                      (index) {
                        final data = userList[index];
                        final id = data.id;
                        return Card(
                          child: ListTile(
                            selectedTileColor: Colors.blue,
                            selected: selectedId == id,
                            onTap: () {
                              setState(() {
                                selectedId = id;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const UserDetail()),
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
