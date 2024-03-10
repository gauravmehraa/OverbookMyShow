import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/obms_app_bar.dart';
import '../components/ticket_button.dart';
import '../services/auth/auth_service.dart';
import 'home_page.dart';

class EventPage extends StatelessWidget {
  final String documentId;
  final authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  EventPage({super.key, required this.documentId});

  final Map<String, int> tickets = {};

  void updateTicketQuantity(String ticketType, int quantity) {
    tickets[ticketType] = quantity;
  }



  void buyTickets(context){
    try {

      WriteBatch batch = _firestore.batch();

      tickets.forEach((ticket, index) async{

        for(int count = 0; count < index; count++) {
          await _firestore.collection("tickets").add(
              {
                'event': 'events/$documentId',
                'scanned': false,
                'user': 'users/${authService.getCurrentUser()!.uid}',
                'type': ticket,
              }
          );

          await _firestore.collection("events").doc(documentId).update({
            'ticketinfo.$ticket.quantity': FieldValue.increment(-1),
          });
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Event successfully added")));
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = authService.getCurrentUser();


    return Scaffold(
      appBar: ObmsAppBar(
        context: context,
        titleText: "Book Tickets",
        leadingIcon: Icon(Icons.arrow_back),
        leadingTooltip: "Go back",
        onPress: (){ Navigator.pop(context); Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage())); },
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('events').doc(documentId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final eventData = snapshot.data!.data() as Map<String, dynamic>;
            return SingleChildScrollView(
              child: SafeArea(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 1.6,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(eventData['name'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                              )
                          ),
                          SizedBox(height: 20),
                          Text("About the Event",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                                fontSize: 20,
                              )
                          ),
                          SizedBox(height: 10),
                          Text(eventData['description'],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                              )
                          ),
                          SizedBox(height: 20),
                          Text("Location",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                                fontSize: 20,
                              )
                          ),
                          SizedBox(height: 10),
                          Text(eventData['venue'],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                              )
                          ),
                          SizedBox(height: 20),
                          Text("Date and Time",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                                fontSize: 20,
                              )
                          ),
                          SizedBox(height: 10),
                          Text(eventData['time'],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                              )
                          ),
                          SizedBox(height: 20),
                          Text("Tickets",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                                fontSize: 20,
                              )
                          ),
                          SizedBox(height: 30),
                          TicketButton(
                            eventId: documentId,
                            ticketType: 'vip',
                            onQuantityChange: updateTicketQuantity,
                          ),
                          SizedBox(height: 20,),
                          TicketButton(
                            eventId: documentId,
                            ticketType: 'platinum',
                            onQuantityChange: updateTicketQuantity,
                          ),
                          SizedBox(height: 20,),
                          TicketButton(
                            eventId: documentId,
                            ticketType: 'gold',
                            onQuantityChange: updateTicketQuantity,
                          ),
                          SizedBox(height: 20,),
                          TicketButton(
                            eventId: documentId,
                            ticketType: 'silver',
                            onQuantityChange: updateTicketQuantity,
                          ),
                          SizedBox(height: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MaterialButton(
                                minWidth: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 1,
                                height: 60,
                                color: Color(0xffF84464),
                                elevation: 1,
                                onPressed: () {
                                  buyTickets(context);
                                },
                                child: Text("Book Tickets",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error ${snapshot.error}"));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
