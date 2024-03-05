import 'package:flutter/material.dart';
import 'package:overbook_my_show/services/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout(){
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          //logout
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),
    );
  }
}
