import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overbook_my_show/components/obms_app_bar.dart';
import '../components/ticket_tile.dart';
import '../services/auth/auth_service.dart';
import 'home_page.dart';

class TicketsPage extends StatelessWidget {
  TicketsPage({super.key});

  final authService = AuthService();
  List <String> ticketIds = [];

  Future getTicketIds() async {
    await FirebaseFirestore.instance.collection('tickets').get().then(
            (snapshot) =>
            snapshot.docs.forEach(
                    (document) {
                  ticketIds.add(document.reference.id);
                }
            )
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? user = authService.getCurrentUser();

    return Scaffold(
      appBar: ObmsAppBar(
        context: context,
        titleText: "View Tickets",
        leadingIcon: Icon(Icons.arrow_back),
        leadingTooltip: "Go back",
        onPress: (){ Navigator.pop(context); Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage())); },
      ),
      body: SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width * 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Expanded(
                    child: FutureBuilder(
                      future: getTicketIds(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                            itemCount: ticketIds.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [ TicketTile(documentId: ticketIds[index])],
                              );
                            }
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
