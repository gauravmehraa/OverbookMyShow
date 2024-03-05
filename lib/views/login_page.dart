import 'package:flutter/material.dart';
import 'package:overbook_my_show/views/signup_page.dart';
import '../components/login_field.dart';
import '../services/auth_gate.dart';
import '../services/auth_service.dart';

class LoginPage extends StatelessWidget{
  LoginPage({super.key});

  final TextEditingController emailCon = TextEditingController();
  final TextEditingController passCon = TextEditingController();

  void signIn(BuildContext context) async {
    final authService = AuthService();
    try{
      await authService.signInWithEmailAndPassword(emailCon.text, passCon.text);
    }
    catch(e){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          )
      );
    }
  }

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

                  Text("Enter your credentials",
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

                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 60,
                    color: Color(0xffF84464),
                    elevation: 1,
                    onPressed: () {
                      signIn(context);
                    },
                    child: Text("Log In",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("New User?"),
                        MaterialButton(
                          child: Text("Create an account",
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
                              MaterialPageRoute(builder: (context) => SignupPage()),
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
