// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/component/global-colors.dart';
import 'package:login_with_firebase/utils/auth-page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  void initState() {
    super.initState();
    getData();
  }

  //user sign out
  void signUsersOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    // change read to watch!!!
    final sp = context.watch<SignInProvider>();
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage("${sp.imagelUrl}"),
                radius: 50,
              ),
              const SizedBox(height: 20),
              Text(
                "Welcome to the App",
                style: TextStyle(
                  color: GlobalColors.textHomeColors,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "${sp.email}",
                style: TextStyle(
                  color: GlobalColors.textColors,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "UID :",
                    style: TextStyle(
                      color: GlobalColors.textColors,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "${sp.uid}",
                    style: TextStyle(
                      color: GlobalColors.textColors,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Provider :",
                    style: TextStyle(
                      color: GlobalColors.textColors,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "${sp.provider}",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
