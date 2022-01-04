import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/Tabs/homepage.dart';
import 'package:sample/Tabs/profile.dart';
import 'package:sample/services/firebaseoperation.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var select = 0;
  List<Widget> children = [const Home(), const Profile()];
  void selectindex(int index) {
    setState(() {
      select = index;
    });
  }

  @override
  void initState() {
    Provider.of<Firebaseoperation>(context, listen: false).getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Chat App",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: selectindex,
          items: const [
            BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person))
          ],
        ),
        body: children[select]);
  }
}
