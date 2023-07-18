// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/component/global-colors.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  //user sign out
  void signUsersOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.buttonColors,
        actions: [
          IconButton(
            onPressed: signUsersOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      backgroundColor: GlobalColors.mainColors,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Log in has been!!!'),
            const SizedBox(height: 20),
            Text(
              "by User : " + user.email!,
            ),
          ],
        ),
      ),
    );
  }
}
