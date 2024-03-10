import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../views/home_page.dart';
import '../../views/landing_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            print("has data");
            return HomePage();
          }
          else{
            print("no data");
            return LandingPage();
          }
        }
      ),
    );
  }
}