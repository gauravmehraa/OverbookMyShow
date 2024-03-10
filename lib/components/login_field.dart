import 'package:flutter/material.dart';

class LoginField extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Icon icon;

  const LoginField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context){
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: icon,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black87),
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}