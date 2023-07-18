// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/login-page.dart';
import 'package:login_with_firebase/pages/home-screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if users has been logged in
          if (snapshot.hasData) {
            return HomePage();
          }
          //.. if users not has been logged in
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
