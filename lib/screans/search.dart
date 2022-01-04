import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sample/screans/chatscrean.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({Key? key}) : super(key: key);

  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  TextEditingController searchcontroller = TextEditingController();
  String search = "";
  navigatortochatpage(DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Chatscrean(post: post)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text("Search user"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchcontroller,
                decoration: InputDecoration(
                    hintText: "Search user",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                onChanged: (String value) {
                  setState(() {
                    search = value;
                  });
                },
              ),
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:
                    FirebaseFirestore.instance.collection("user").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final data = docs[index].data();
                          String name = data["name"];
                          if (searchcontroller.text.isEmpty) {
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
                          } else if (name
                              .toLowerCase()
                              .contains(searchcontroller.text.toString())) {
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
                          } else {
                            return const SizedBox(
                              height: 0,
                              width: 0,
                            );
                          }
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
