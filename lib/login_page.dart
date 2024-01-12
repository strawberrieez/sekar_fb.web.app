import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:universal_html/html.dart' as html;

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('toko oren')),
          actions: [
            IconButton(
              onPressed: () {
                html.window.open('https://github.com/strawberrieez/sekar_fb.web.app', 'sekar_fb.web.app');
              },
              icon: const Icon(SimpleIcons.github),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    final anon = await FirebaseAuth.instance.signInAnonymously();
                    debugPrint(anon.toString());
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Sign in anonymous"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    final google = GoogleAuthProvider().setCustomParameters({'prompt': 'select_account'});
                    await FirebaseAuth.instance.signInWithPopup(google);
                  },
                  child: const Row(
                    children: [
                      Icon(SimpleIcons.google),
                      SizedBox(width: 8),
                      Text("Sign in with google"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
