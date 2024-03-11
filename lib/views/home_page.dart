import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overbook_my_show/components/obms_app_bar.dart';
import 'package:overbook_my_show/views/profile_page.dart';
import '../components/event_tile.dart';
import '../services/auth_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final authService = AuthService();
  List <String> eventIds = [];

  Future getEventIds() async {
    await FirebaseFirestore.instance.collection('events').get().then(
            (snapshot) =>
            snapshot.docs.forEach(
                    (document) {
                  eventIds.add(document.reference.id);
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
          titleText: "OverbookMyShow",
          leadingIcon: Icon(Icons.person_rounded),
          leadingTooltip: "View Profile",
          onPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
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
                        future: getEventIds(),
                        builder: (context, snapshot) {
                          return ListView.builder(
                              itemCount: eventIds.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [ EventTile(documentId: eventIds[index])],
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
