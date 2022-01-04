import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/screans/registerpage.dart';
import 'package:sample/services/authintacation.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Welcome back",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
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
                child: const Text("LogIn"),
                onPressed: () {
                  Provider.of<Authinitication>(context, listen: false)
                      .loginaccount(context, email.text, password.text);
                }),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have a account"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Registerpage()));
                    },
                    child: const Text("Register"))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
