import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/services/firebaseoperation.dart';

class Chatscrean extends StatefulWidget {
  final DocumentSnapshot post;

  const Chatscrean({Key? key, required this.post}) : super(key: key);
  @override
  _ChatscreanState createState() => _ChatscreanState();
}

class _ChatscreanState extends State<Chatscrean> {
  TextEditingController sendmessage = TextEditingController();
  final date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.post["name"]),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("user")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("message")
                        .doc(widget.post["uid"])
                        .collection("chat")
                        .orderBy("time", descending: true)
                        .snapshots(),
                    builder: (context, snapshots) {
                      if (snapshots.hasData) {
                        final docs = snapshots.data!.docs;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              reverse: true,
                              itemCount: docs.length,
                              itemBuilder: (context, index) {
                                final data = docs[index].data();
                                // DateTime dt =
                                //     (data['time'] as Timestamp).toDate();
                                // var input = DateFormat("'MM/dd/yyyy, hh:mm a'")
                                //     .parse(dt.toString());
                                // var output = DateFormat('HH:mm')
                                //     .format(input); // 31/12/2000, 22:00
                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: data["uid"] !=
                                          FirebaseAuth.instance.currentUser!.uid
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: data["uid"] !=
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid
                                                  ? Colors.blue
                                                  : Colors.grey[400],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onDoubleTap: () {
                                                    FirebaseFirestore.instance
                                                        .collection("user")
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                        .collection("message")
                                                        .doc(widget.post["uid"])
                                                        .collection("chat")
                                                        .doc(docs[index].id)
                                                        .delete();
                                                  },
                                                  child: Text(
                                                    data["message"],
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Text(
                                            Provider.of<Firebaseoperation>(
                                                    context,
                                                    listen: false)
                                                .formatTimestamp(data["time"]),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                            ))
                                      ],
                                    ),
                                  ],
                                );
                              }),
                        );
                      } else {
                        return const Center(
                          child: Text("loading"),
                        );
                      }
                    }),
              ),
            ),
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: sendmessage,
                      maxLines: null,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Enter message"),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<Firebaseoperation>(context, listen: false)
                          .createmessagemy(widget.post["uid"], sendmessage.text,
                              widget.post["name"])
                          .whenComplete(() {
                        Provider.of<Firebaseoperation>(context, listen: false)
                            .createmessageother(widget.post["uid"],
                                sendmessage.text, widget.post["name"]);
                      }).whenComplete(() {
                        Provider.of<Firebaseoperation>(context, listen: false)
                            .createmessageusermy(context, widget.post["uid"],
                                widget.post["name"], widget.post["email"]);
                        Provider.of<Firebaseoperation>(context, listen: false)
                            .createmessageuserother(
                                context,
                                widget.post["uid"],
                                Provider.of<Firebaseoperation>(context,
                                        listen: false)
                                    .getinitusername
                                    .toString(),
                                widget.post["email"]);
                      }).whenComplete(() {
                        sendmessage.clear();
                      });
                    },
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
