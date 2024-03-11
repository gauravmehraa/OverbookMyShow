import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../views/event_page.dart';

class TicketTile extends StatelessWidget {
  final String documentId;

  const TicketTile({
    super.key,
    required this.documentId,
  });

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final User? user = authService.getCurrentUser();
    CollectionReference tickets =
        FirebaseFirestore.instance.collection('tickets');
    CollectionReference events =
    FirebaseFirestore.instance.collection('events');

    return FutureBuilder<DocumentSnapshot>(
        future: tickets.doc(documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            if(data['user'].toString().substring(6) == authService.getCurrentUser()!.uid)
            return Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EventPage(documentId: documentId)),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffc4252a),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width * 1,
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: FutureBuilder<DocumentSnapshot>(
                              future: events.doc(data!['event'].toString().substring(7)).get(),
                              builder: (context, snapshot){
                                if(snapshot.connectionState == ConnectionState.done){
                                  Map<String, dynamic> eventData = snapshot.data!.data() as Map<String, dynamic>;
                                  String scannedText = "No";
                                  if(data!['scanned']) scannedText = "Yes";
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(eventData!['name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Inter',
                                            fontSize: 22,
                                            color: Colors.white,
                                          )),
                                      SizedBox(height: 10),
                                      Text("Ticket ID: ${documentId}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Inter',
                                            fontSize: 15,
                                            color: Colors.white,
                                          )),
                                      SizedBox(height: 10),
                                      Text("Event Timing: ${eventData!['time']}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Inter',
                                            fontSize: 15,
                                            color: Colors.white,
                                          )),
                                      SizedBox(height: 10),
                                      Text(
                                          "Ticket Type: ${data!['type'].toString().toUpperCase()}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Inter',
                                            fontSize: 15,
                                            color: Colors.white,
                                          )),
                                      SizedBox(height: 10),
                                      Text(
                                          "Ticket Scanned: $scannedText",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Inter',
                                            fontSize: 15,
                                            color: Colors.white,
                                          )),
                                    ],
                                  );
                                }
                                return Text("Loading");
                              },
                            ),

                          ),
                        ],
                      )),
                ),
              ),
            );
          }
          return SizedBox(height: 0);
        });
  }
}
