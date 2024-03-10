import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
  final String documentId;

  const EventTile({
    super.key,
    required this.documentId,
  });

  @override
  Widget build(BuildContext context) {
    CollectionReference events = FirebaseFirestore.instance.collection('events');

    return FutureBuilder<DocumentSnapshot>(
      future: events.doc(documentId).get(),
        builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          Map <String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Container(
            color: Colors.grey,
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 1,
          );
        }
        return Text('loading');
      });
  }
}
