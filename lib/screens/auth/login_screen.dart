import 'dart:developer';
import 'dart:io';
import 'dart:js';

import 'package:chatapp/helper/dialogs.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      // app bar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Welcome to We Chat'),
      ),
      body: Stack(children: [
        AnimatedPositioned(
            top: mq.height * .15,
            right: _isAnimate ? mq.width * .25 : -mq.width * .5,
            width: mq.width * .5,
            duration: Duration(seconds: 1),
            child: Image.asset('images/google.png')),
        Positioned(
            bottom: mq.height * .15,
            width: mq.width * .9,
            left: mq.width * .05,
            height: mq.height * .05,
            child: ElevatedButton.icon(
                onPressed: () {
                  _handleGoogleButtonClick();
                },
                icon: Image.asset(
                  'images/google.png',
                  height: mq.height * 0.03,
                ),
                label: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 19),
                      children: [
                        TextSpan(text: 'Sign in with '),
                        TextSpan(
                            text: 'Google',
                            style: TextStyle(fontWeight: FontWeight.w500))
                      ]),
                ))),
      ]),
    );
  }
}

_handleGoogleButtonClick() {
  // for showing progress bar
  Dialogs.showProgressBar(context as BuildContext);
  _signInWithGoogle().then((user) {
    // for hiding progress bar
    Navigator.pop(context as BuildContext);
    if (user != null) {
      Navigator.pushReplacement(context as BuildContext,
          MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  });
}

Future<UserCredential?> _signInWithGoogle() async {
  try {
    await InternetAddress.lookup('google.com');
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (e) {
    log('\n_signInWithGoogle(): $e');
    Dialogs.showSnackBar(
        context as BuildContext, 'something went wrong check internet');
    return null;
  }
}
