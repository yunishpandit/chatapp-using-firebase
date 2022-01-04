import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/services/authintacation.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
          child: const Text("LogOut"),
          color: Colors.blue,
          onPressed: () {
            Provider.of<Authinitication>(context, listen: false)
                .logout(context);
          }),
    );
  }
}
