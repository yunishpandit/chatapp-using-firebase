import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample/home.dart';
import 'package:sample/screans/loginpage.dart';

class Authinitication with ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future loginaccount(
      BuildContext context, String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
          (route) => false);
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future createaccount(
      BuildContext context, String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
          (route) => false);
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future forgerpassword(BuildContext context, String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.maybeOf(context)!.showSnackBar(snackBar);
    }
  }

  Future logout(
    BuildContext context,
  ) async {
    try {
      await firebaseAuth.signOut().whenComplete(() {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Loginpage()),
            (route) => false);
      });
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.maybeOf(context)!.showSnackBar(snackBar);
    }
  }
}
