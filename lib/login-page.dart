// ignore_for_file: file_names, sized_box_for_whitespace, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_with_firebase/component/global-colors.dart';
import 'package:login_with_firebase/component/my-button.dart';
import 'package:login_with_firebase/component/my-colom.dart';
import 'package:login_with_firebase/pages/home-screen.dart';
import 'package:login_with_firebase/provider/internet-provider.dart';
import 'package:login_with_firebase/utils/auth-page.dart';
import 'package:login_with_firebase/utils/next-screen.dart';
import 'package:login_with_firebase/utils/snack-bar.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing Controller
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();

  final RoundedLoadingButtonController facebookController =
      RoundedLoadingButtonController();

  // sign user in method
  void signUserIn() async {
    //...show loading dialog
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.yellow[700],
          ),
        );
      },
    );

    // ... show try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      // ... wrong email
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      }
      // ... wrong password
      else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }

    Navigator.pop(context);
  }

  // Wrong email pop up
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorect email'),
        );
      },
    );
  }

  // Wrong password pop uo
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorect password'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.mainColors,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                // logo
                Container(
                  height: 200,
                  child: Image.asset('assets/images/logo.png'),
                ),
                const SizedBox(height: 10),
                // Welcome to this app!!!
                Text(
                  'Welcome to this app!!!',
                  style: TextStyle(
                    color: GlobalColors.textColors,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 25),
                // Username textField
                MyInputColom(
                  controller: emailController,
                  hintText: 'email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                // Password textField
                MyInputColom(
                  controller: passwordController,
                  hintText: 'password',
                  obscureText: true,
                ),
                // Forget Password
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Button Sign In
                MyButton(
                  onTap: signUserIn,
                ),
                const SizedBox(height: 50),
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text(
                          'Or Continue with',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // login with google/twitter in button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Button Google
                    RoundedLoadingButton(
                      onPressed: () {
                        handleGoogleSignIn();
                      },
                      controller: googleController,
                      height: 60,
                      width: 80,
                      borderRadius: 16,
                      color: Colors.grey[200],
                      child: Wrap(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/google-color-svgrepo-com.svg',
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Button Twitter
                    RoundedLoadingButton(
                      onPressed: () {
                        handleGoogleSignIn();
                      },
                      controller: facebookController,
                      height: 60,
                      width: 80,
                      borderRadius: 16,
                      color: Colors.grey[200],
                      child: Wrap(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/twitter-3-logo-svgrepo-com.svg',
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // handle google sign in
  Future handleGoogleSignIn() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(context, "Check Your Internet Connection", Colors.red);
      googleController.reset();
      // facebookController.reset();
    } else {
      await sp.signInWithGoogle().then(
            (value) => {
              if (sp.hasError == true)
                {
                  openSnackbar(context, sp.errorCode.toString(), Colors.red),
                  googleController.reset(),
                }
              else
                {
                  // checking whether user exists or not
                  sp.checkUserExists().then(
                    (value) async {
                      if (value == true) {
                        // user exists
                      } else {
                        // user does not exist
                        sp.saveDataToFirestore().then((value) => sp
                            .saveDataToSharedPreferences()
                            .then((value) => sp.setSignIn().then((value) {
                                  googleController.success();
                                  handleAfterSignIn();
                                })));
                      }
                    },
                  )
                }
            },
          );
    }
  }

  // handle after sign
  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      nextScreenReplacement(
        context,
        const HomePage(),
      );
    });
  }
}
