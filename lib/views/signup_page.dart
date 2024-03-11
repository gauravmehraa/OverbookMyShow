import 'package:flutter/material.dart';
import 'package:overbook_my_show/views/login_page.dart';
import '../components/login_field.dart';
import '../services/auth_service.dart';

class SignupPage extends StatelessWidget{
  SignupPage({super.key});
  final TextEditingController nameCon = TextEditingController();
  final TextEditingController emailCon = TextEditingController();
  final TextEditingController passCon = TextEditingController();
  final TextEditingController confirmPassCon = TextEditingController();


  void signUp(BuildContext context) async {
    final authService = AuthService();

    emailCon.text = emailCon.text.trim();

    //Check null strings
    if(emailCon.text.isEmpty || passCon.text.isEmpty || confirmPassCon.text.isEmpty || nameCon.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("All fields are mandatory")));
      return;
    }

    //Check length of name
    if(!RegExp(r'[a-zA-Z ]+$').hasMatch(nameCon.text)){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter a valid name")));
      return;
    }

    //Check if passwords are same
    if(passCon.text != confirmPassCon.text){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Passwords should be same")));
      return;
    }

    //Check length of password
    if(passCon.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Weak password")));
      return;
    }

    try{
      await authService.signUpWithEmailAndPassword(nameCon.text, emailCon.text, passCon.text);
      Navigator.pop(context);
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
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

                    Text("Create Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(
                        height: 20
                    ),


                    LoginField(
                      icon: const Icon(Icons.person_outline_outlined),
                      controller: nameCon,
                      hintText: "Name",
                      obscureText: false,
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
                      icon: const Icon(Icons.lock_outline_rounded),
                      controller: passCon,
                      hintText: "Password",
                      obscureText: true,
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    LoginField(
                      icon: const Icon(Icons.lock_outline_rounded),
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
                        signUp(context);
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
      ),
    );
  }
}
