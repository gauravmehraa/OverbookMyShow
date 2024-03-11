import 'package:flutter/material.dart';
import 'login_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(
                height: 60,
              ),

              Text("Welcome To\nOverbookMyShow!",
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

              Text(
                "It all ends here.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),

              SizedBox(
                height: 50,
              ),

              Padding(
                padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Image.asset('assets/obms_banner.png'),
              ),

              SizedBox(
                height: 50,
              ),

              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        spreadRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text("Your access to all things entertainment is here!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text("With OverbookMyShow, discover the latest movies, biggest concerts, most awaited sporting events, plays, and various other LIVE event experiences. If you identify as an ‘entertainment enthusiast’, then BookMyShow is a must-have app on your phone. No matter what mood you’re in, there’s something for everyone.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            color: Color(0xffF84464),
                            elevation: 1,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                            child: Text("Get Started",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
