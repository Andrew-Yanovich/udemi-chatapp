import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats/2L2vwdo60E9yw55m0hiY/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if(streamSnapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          final documents = streamSnapshot.requireData.docs;
          return ListView.builder(
            itemCount: streamSnapshot.requireData.size,
            itemBuilder: (ctx, i) => Container(
              padding: const EdgeInsets.all(8),
              child: Text(documents[i]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance.collection('chats/2L2vwdo60E9yw55m0hiY/messages').add({
            'text': 'This was added by clicking the button!',
          });
        },
      ),
    );
  }
}
