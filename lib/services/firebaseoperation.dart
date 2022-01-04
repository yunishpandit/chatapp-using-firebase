import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Firebaseoperation with ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? inituserName;
  String? get getinitusername => inituserName;
  String? messagetime;

  Future createuser(BuildContext context, String name, String email) async {
    try {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(firebaseAuth.currentUser!.uid)
          .set({
        "uid": firebaseAuth.currentUser!.uid,
        "name": name,
        "email": email
      });
    } on Exception catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future createmessagemy(
    String otheruseruid,
    String message,
    String name,
  ) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("message")
        .doc(otheruseruid)
        .collection("chat")
        .add({
      "uid": firebaseAuth.currentUser!.uid,
      "name": name,
      "message": message,
      "time": DateTime.now()
    });
  }

  Future createmessageother(
      String otheruseruid, String message, String name) async {
    FirebaseFirestore.instance
        .collection("user")
        .doc(otheruseruid)
        .collection("message")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("chat")
        .add({
      "uid": firebaseAuth.currentUser!.uid,
      "name": name,
      "message": message,
      "time": DateTime.now()
    });
  }

  Future createmessageusermy(BuildContext context, String otheruseruid,
      String name, String email) async {
    try {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(firebaseAuth.currentUser!.uid)
          .collection("message")
          .doc(otheruseruid)
          .set({"uid": otheruseruid, "name": name, "email": email});
    } on Exception catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future createmessageuserother(BuildContext context, String otheruseruid,
      String name, String email) async {
    try {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(otheruseruid)
          .collection("message")
          .doc(firebaseAuth.currentUser!.uid)
          .set({
        "uid": firebaseAuth.currentUser!.uid,
        "name": name,
        "email": firebaseAuth.currentUser!.email
      });
    } on Exception catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future getdata() async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((docs) {
      inituserName = docs.data()!["name"];
    });
  }

  String formatTimestamp(Timestamp timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');

    var diff = now.difference(timestamp.toDate());
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(timestamp.toDate());
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }
    return format.format(timestamp.toDate());
  }
}
