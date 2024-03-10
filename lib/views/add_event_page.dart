import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import '../components/login_field.dart';
import '../components/obms_app_bar.dart';
import 'home_page.dart';

class AddEventPage extends StatelessWidget {
  AddEventPage({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController idCon = TextEditingController();
  final TextEditingController nameCon = TextEditingController();
  final TextEditingController descCon = TextEditingController();
  final TextEditingController timeCon = TextEditingController();
  final TextEditingController venueCon = TextEditingController();
  final TextEditingController goldPriceCon = TextEditingController();
  final TextEditingController goldQtyCon = TextEditingController();
  final TextEditingController silverPriceCon = TextEditingController();
  final TextEditingController silverQtyCon = TextEditingController();
  final TextEditingController platinumPriceCon = TextEditingController();
  final TextEditingController platinumQtyCon = TextEditingController();
  final TextEditingController vipPriceCon = TextEditingController();
  final TextEditingController vipQtyCon = TextEditingController();

  void selectTimestamp(context){
    DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMMM yyyy HH:mm',
      initialDateTime: DateTime.now(),
      minDateTime: DateTime(2000),
      maxDateTime: DateTime(3000),
      onMonthChangeStartWithFirstDate: true,
      onConfirm: (dateTime, List<int> index) {
        DateTime selectdate = dateTime;
        print(selectdate);
      },
    );
  }

  void addEvent(context) async {
    print('entering');
    try {
      await _firestore.collection("events").doc(idCon.text).set(
          {
            'name': nameCon.text,
            'description': descCon.text,
            'venue': venueCon.text,
            'ticketinfo': {
              'vip': {
                'price': int.parse(vipPriceCon.text),
                'quantity': int.parse(vipQtyCon.text)
              },
              'platinum': {
                'price': int.parse(platinumPriceCon.text),
                'quantity': int.parse(platinumQtyCon.text)
              },
              'gold': {
                'price': int.parse(goldPriceCon.text),
                'quantity': int.parse(goldQtyCon.text)
              },
              'silver': {
                'silver': int.parse(silverPriceCon.text),
                'quantity': int.parse(silverQtyCon.text)
              },
            }
          }
      );
    }
    catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${e.toString()}")));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ObmsAppBar(
        context: context,
        titleText: "Admin Panel",
        leadingIcon: Icon(Icons.home_filled),
        leadingTooltip: "Home",
        onPress: (){
          Navigator.pop(context);
          MaterialPageRoute(builder: (context) => HomePage());
          },
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Color(0xffc4252a),
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height*2,
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                      child: Image.asset('assets/obms_banner_red.png'),
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Text("Add an Event",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(
                        height: 20
                    ),


                    LoginField(
                      icon: const Icon(Icons.qr_code),
                      controller: idCon,
                      hintText: "Event ID",
                      obscureText: false,
                    ),

                    SizedBox(
                        height: 20
                    ),


                    LoginField(
                      icon: const Icon(Icons.drive_file_rename_outline),
                      controller: nameCon,
                      hintText: "Event Name",
                      obscureText: false,
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    LoginField(
                      icon: const Icon(Icons.description),
                      controller: descCon,
                      hintText: "Description",
                      obscureText: false,
                    ),

                    SizedBox(
                      height: 20,
                    ),


                    GestureDetector(
                      onTap: () {selectTimestamp(context);},
                      child: LoginField(
                        readOnly: true,
                        icon: const Icon(Icons.watch_later_outlined),
                        controller: timeCon,
                        hintText: "Date and Time",
                        obscureText: false,
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    LoginField(
                      icon: const Icon(Icons.location_on_outlined),
                      controller: venueCon,
                      hintText: "Venue",
                      obscureText: false,
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                            "VIP Tickets",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: LoginField(
                              controller: vipPriceCon,
                              hintText: "Price",
                              obscureText: false,
                              icon: const Icon(Icons.confirmation_number_outlined)
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: LoginField(
                              controller: vipQtyCon,
                              hintText: "Quantity",
                              obscureText: false,
                              icon: const Icon(Icons.numbers_outlined)
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          "Platinum Tickets",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: LoginField(
                              controller: platinumPriceCon,
                              hintText: "Price",
                              obscureText: false,
                              icon: const Icon(Icons.confirmation_number_outlined)
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: LoginField(
                              controller: platinumQtyCon,
                              hintText: "Quantity",
                              obscureText: false,
                              icon: const Icon(Icons.numbers_outlined)
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          "Gold Tickets",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: LoginField(
                              controller: goldPriceCon,
                              hintText: "Price",
                              obscureText: false,
                              icon: const Icon(Icons.confirmation_number_outlined)
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: LoginField(
                              controller: goldQtyCon,
                              hintText: "Quantity",
                              obscureText: false,
                              icon: const Icon(Icons.numbers_outlined)
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          "Silver Tickets",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: LoginField(
                              controller: silverPriceCon,
                              hintText: "Price",
                              obscureText: false,
                              icon: const Icon(Icons.confirmation_number_outlined)
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: LoginField(
                              controller: silverQtyCon,
                              hintText: "Quantity",
                              obscureText: false,
                              icon: const Icon(Icons.numbers_outlined)
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    MaterialButton(
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 60,
                      color: Colors.white,
                      elevation: 1,
                      onPressed: () {
                        addEvent(context );
                      },
                      child: Text("Add Event",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
