import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample/home.dart';
import 'package:sample/screans/loginpage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  bool isconnected = false;
  StreamSubscription? sub;
  late StreamSubscription<User?> user;
  @override
  void initState() {
    sub = Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        isconnected = (result != ConnectivityResult.none);
      });
    });
    Timer(const Duration(seconds: 5), () {
      isconnected
          ? user = FirebaseAuth.instance.authStateChanges().listen((user) {
              if (user == null) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Loginpage()),
                    (route) => false);
              } else {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Homepage()),
                    (route) => false);
              }
            })
          : showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Check your internet"),
                  actions: [
                    TextButton(onPressed: () {}, child: const Text("Ok"))
                  ],
                );
              });
    });
    super.initState();
  }

  @override
  void dispose() {
    sub?.cancel();
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: Text("Welcome to chat app",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))));
  }
}
