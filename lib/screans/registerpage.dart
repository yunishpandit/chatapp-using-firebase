import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/services/authintacation.dart';
import 'package:sample/services/firebaseoperation.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({Key? key}) : super(key: key);

  @override
  _RegisterpageState createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Text(
                  "Register Now",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                      hintText: "Enter name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      hintText: "Enter email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                      hintText: "Enter Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                    color: Colors.blue,
                    child: const Text("Register"),
                    onPressed: () {
                      Provider.of<Authinitication>(context, listen: false)
                          .createaccount(context, email.text, password.text)
                          .whenComplete(() {
                        Provider.of<Firebaseoperation>(context, listen: false)
                            .createuser(context, name.text, email.text);
                      });
                    }),
              ],
            ),
          ),
        ));
  }
}
