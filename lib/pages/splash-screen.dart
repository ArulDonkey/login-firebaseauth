// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/component/global-colors.dart';
import 'package:login_with_firebase/login-page.dart';
import 'package:login_with_firebase/pages/home-screen.dart';
import 'package:login_with_firebase/utils/auth-page.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
//init State
  @override
  void initState() {
    final sp = context.read<SignInProvider>();
    super.initState();

    //create a timer of .. second
    Timer(const Duration(seconds: 2), () {
      sp.isSignIn == false
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPage()))
          : Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.backgroundColors,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 80,
            height: 80,
          ),
        ),
      ),
    );
  }
}
