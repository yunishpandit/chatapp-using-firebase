import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample/screans/chatscrean.dart';
import 'package:sample/screans/search.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  navigatortochatpage(DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Chatscrean(post: post)));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Searchpage()));
              },
              child: Card(
                elevation: 4,
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [Text("Search user"), Icon(Icons.search)],
                    ),
                  ),
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("user")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("message")
                  .snapshots(),
              builder: (context, snapshots) {
                if (snapshots.hasData) {
                  final docs = snapshots.data!.docs;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final data = docs[index].data();
                        return InkWell(
                          onTap: () {
                            navigatortochatpage(docs[index]);
                          },
                          child: ListTile(
                            leading: const CircleAvatar(
                              radius: 20,
                            ),
                            title: Text(data["name"]),
                            subtitle: Text(data["email"]),
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
        ],
      ),
    );
  }
}
