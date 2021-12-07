import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, i) => Container(
          padding: const EdgeInsets.all(8),
          child: Text('This works!'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/2L2vwdo60E9yw55m0hiY/messages')
              .snapshots()
              .listen((data) {
            print(data.docs[0]['text']);
            data.docs.forEach((doc) { print(doc['text']); });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
