import 'package:flutter/material.dart';
import 'package:sekar_fb/pages/ctrl/user_ctrl.dart';
import 'package:sekar_fb/pages/ctrl/user_data.dart';

class DetailCust extends StatefulWidget {
  const DetailCust({super.key, required this.id});

  final String id;

  @override
  State<DetailCust> createState() => _DetailCustState();
}

class _DetailCustState extends State<DetailCust> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail cust'),
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
                  // Text('$productDetail?.nama'),
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
