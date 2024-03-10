import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../views/event_page.dart';

class EventTile extends StatelessWidget {
  final String documentId;

  const EventTile({
    super.key,
    required this.documentId,
  });

  @override
  Widget build(BuildContext context) {
    CollectionReference events =
        FirebaseFirestore.instance.collection('events');

    return FutureBuilder<DocumentSnapshot>(
        future: events.doc(documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            final tickets = data['ticketinfo'];
            final quantity = tickets['vip']['quantity'] + tickets['platinum']['quantity'] + tickets['gold']['quantity'] + tickets['silver']['quantity'];
            return Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventPage(documentId: documentId)),
                  );
                },
                child: Container(
                  color: Color(0xffc4252a),
                  width: MediaQuery.of(context).size.width * 1,
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data!['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Inter',
                                      fontSize: 22,
                                      color: Colors.white,
                                    )
                                ),
                              SizedBox(height: 10),
                                Text(data!['time'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Inter',
                                      fontSize: 15,
                                      color: Colors.white,
                                    )
                                ),
                                SizedBox(height: 10),
                              Text("Tickets left: $quantity",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Roboto',
                                    fontSize: 18,
                                    color: Colors.white,
                                  )
                                ),
                              SizedBox(height: 10),
                              Text(data!['description'],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Inter',
                                    fontSize: 15,
                                    color: Colors.white,
                                  )
                              ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            );
          }
          return Text('loaing');
        });
  }
}
