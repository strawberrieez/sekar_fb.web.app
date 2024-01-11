import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('toko oren'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              Uri url = Uri.parse('https://github.com/strawberrieez/sekar_fb.web.app');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                'tidak dapat dibuka';
              }
            },
            child: const Text(
              "github",
            ),
          ),
        ),
      ),
    );
  }
}
