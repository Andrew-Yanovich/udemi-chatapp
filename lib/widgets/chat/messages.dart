import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final snapshotData = chatSnapshot.requireData;
        return ListView.builder(
          reverse: true,
          itemCount: snapshotData.size,
          itemBuilder: (ctx, index) => MessageBubble(
            message: snapshotData.docs[index]['text'],
          ),
        );
      },
    );
  }
}
