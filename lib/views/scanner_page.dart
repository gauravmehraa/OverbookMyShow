import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/login_field.dart';
import '../components/obms_app_bar.dart';
import 'home_page.dart';

class ScannerPage extends StatelessWidget {
  ScannerPage({super.key});

  final TextEditingController idCon = TextEditingController();

  void scanTicket(context) async {
    try {
      CollectionReference tickets =
          FirebaseFirestore.instance.collection('tickets');
      var ticket = await tickets.doc(idCon.text).get();

      if (!ticket['scanned']) {
        tickets.doc(idCon.text).update({
          'scanned': true,
        });
        idCon.text = '';
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ticket already checked-in")));
      }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Successfully checked in")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid ticket ID")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ObmsAppBar(
        context: context,
        titleText: "Scan Ticket",
        leadingIcon: Icon(Icons.arrow_back),
        leadingTooltip: "Go back",
        onPress: () {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.6,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LoginField(
                  icon: const Icon(Icons.numbers_outlined),
                  controller: idCon,
                  hintText: "Ticket ID",
                  obscureText: false,
                ),
                SizedBox(height: 30),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  height: 60,
                  color: Color(0xffF84464),
                  elevation: 1,
                  onPressed: () {
                    scanTicket(context);
                  },
                  child: Text(
                    "Check In",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
