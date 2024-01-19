import 'package:flutter/material.dart';
import 'package:sekar_fb/pages/admin/admin_edit.dart';
import 'package:sekar_fb/pages/ctrl/user_ctrl.dart';
import 'package:sekar_fb/pages/ctrl/user_data.dart';

class AdminDetail extends StatefulWidget {
  const AdminDetail({super.key, required this.id});

  final String id;

  @override
  State<AdminDetail> createState() => _AdminDetailState();
}

class _AdminDetailState extends State<AdminDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Barang'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: '3',
            onPressed: () {
              setState(() {});
            },
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 5),
          FloatingActionButton(
            heroTag: '1',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminEdit(id: widget.id)),
              );
            },
            child: const Icon(Icons.edit),
          ),
          const SizedBox(height: 5),
          FloatingActionButton(
            heroTag: '2',
            onPressed: () async {
              await deleteDoc(selectedId);

              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              setState(() {});
            },
            child: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: getDoc(widget.id),
          builder: (context, snapshot) {
            if (productDetail != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  productDetail!.image.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 220,
                          width: 220,
                          child: Image.network(productDetail!.image),
                        ),
                  Text('${productDetail?.nama}'),
                  Text('${productDetail?.harga}'),
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
