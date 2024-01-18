import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sekar_fb/pages/cust/home_page.dart';
import 'package:sekar_fb/pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopeeNet',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      // home: const LoginPage(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
