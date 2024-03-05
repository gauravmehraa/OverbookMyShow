import 'package:flutter/material.dart';
import 'package:overbook_my_show/views/login_page.dart';

import '../components/login_field.dart';

class SignupPage extends StatelessWidget{
  SignupPage({super.key});
  final TextEditingController emailCon = TextEditingController();
  final TextEditingController passCon = TextEditingController();
  final TextEditingController confirmPassCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 120, right: 120),
                    child: Image.asset('assets/bms_logo.png'),
                  ),

                  SizedBox(
                    height: 20,
                  ),
            
                  Text("Sign Up for\nOverbookMyShow",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 27,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
            
                  SizedBox(
                    height: 20,
                  ),
            
                  LoginField(
                    icon: const Icon(Icons.email_outlined),
                    controller: emailCon,
                    hintText: "Email",
                    obscureText: false,
                  ),
            
                  SizedBox(
                    height: 30,
                  ),
            
                  LoginField(
                    icon: const Icon(Icons.password),
                    controller: passCon,
                    hintText: "Password",
                    obscureText: true,
                  ),
            
                  SizedBox(
                    height: 30,
                  ),
            
                  LoginField(
                    icon: const Icon(Icons.password),
                    controller: confirmPassCon,
                    hintText: "Confirm Password",
                    obscureText: true,
                  ),
            
                  SizedBox(
                    height: 30,
                  ),
            
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 60,
                    color: Color(0xffF84464),
                    elevation: 1,
                    onPressed: () {

                    },
                    child: Text("Sign Up",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already a member?"),
                        MaterialButton(
                          child: Text("Log In",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffF84464),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
