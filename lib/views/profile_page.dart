import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overbook_my_show/components/obms_app_bar.dart';
import '../services/auth/auth_service.dart';
import '../services/user/user_service.dart';
import 'add_event_page.dart';


class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authService = AuthService();

  final userService = UserService();

  @override
  Widget build(BuildContext context) {

    final User? user = authService.getCurrentUser();
    String roleText = 'User';


    return Scaffold(
      appBar: ObmsAppBar(
        context: context,
        titleText: "View Profile",
        leadingIcon: Icon(Icons.arrow_back),
        leadingTooltip: "Go back",
        onPress: (){ Navigator.pop(context); },
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            if(userData['isAdmin'] == true){
              roleText = 'Admin';
            }
            return SafeArea(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Name"),
                            SizedBox(width: 30),
                            Text(userData['name']),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Email"),
                            SizedBox(width: 30),
                            Text(userData['email']),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Role"),
                            SizedBox(width: 30),
                            Text(roleText),
                          ],
                        ),

                        if(userData['isAdmin'])
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width * 0.8,
                                  height: 60,
                                  color: Color(0xffF84464),
                                  elevation: 1,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => AddEventPage()),
                                    );
                                  },
                                  child: Text("Add Event",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ]
                          ),
                      ],
                    ),
                  )
              ),
            );
          }
          else if(snapshot.hasError){
            return Center(child: Text("Error ${snapshot.error}"));
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
