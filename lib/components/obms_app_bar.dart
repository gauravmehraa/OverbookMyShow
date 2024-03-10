import 'package:flutter/material.dart';
import '../services/auth/auth_gate.dart';
import '../services/auth/auth_service.dart';

class ObmsAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String titleText;
  final BuildContext context;
  final Icon leadingIcon;
  final String leadingTooltip;
  final VoidCallback onPress;

  const ObmsAppBar({
    super.key,
    required this.titleText,
    required this.context,
    required this.leadingIcon,
    required this.leadingTooltip,
    required this.onPress,
  });

  void logout(){
    final authService = AuthService();
    authService.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthGate()));
  }


  @override
  Size get preferredSize => Size.fromHeight(MediaQuery.of(context).size.width * 0.15);

  @override
  Widget build(BuildContext context){
    return AppBar(
      backgroundColor: const Color(0xff1F2533),
      centerTitle: true,
      leading: IconButton(
        icon: leadingIcon,
        color: Colors.white,
        tooltip: leadingTooltip,
        onPressed: onPress,
      ),
      title: Text(
          titleText,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Inter'
        ),
      ),
      actions: [IconButton(onPressed: logout, icon: const Icon(Icons.logout_rounded), color: Colors.white,),],
    );
  }
}