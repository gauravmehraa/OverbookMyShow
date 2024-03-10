import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TicketButton extends StatefulWidget {
  final String eventId;
  final String ticketType;
  final Function(String, int) onQuantityChange;

  const TicketButton({
    super.key,
    required this.eventId,
    required this.ticketType,
    required this.onQuantityChange,
  });


  @override
  State<TicketButton> createState() => _TicketButtonState();
}

class _TicketButtonState extends State<TicketButton> {

  int quantity = 0;

  void incrementQuantity(){
    setState((){
      quantity++;
      widget.onQuantityChange(widget.ticketType, quantity);
    });
  }

  void decrementQuantity(){
    if(quantity == 0) return;
    setState((){
      quantity--;
      widget.onQuantityChange(widget.ticketType, quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('events').doc(widget.eventId).snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          final eventData = snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width * 1,
                height: 60,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${widget.ticketType.toUpperCase()} - Rs. ${eventData['ticketinfo'][widget.ticketType]['price']}", style: TextStyle(fontWeight: FontWeight.w700),),
                    SizedBox(width: 20,),
                    SizedBox(width: 20,),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffc4252a),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 40,
                      child: Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: decrementQuantity,
                              child: Icon(Icons.remove, color: Colors.white),
                            ),
                            Text("${quantity}", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 20)),
                            GestureDetector(
                              onTap: incrementQuantity,
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Text("Tickets left: ${eventData['ticketinfo'][widget.ticketType]['quantity']}"),
              ),
            ],
          );
        }
        else if(snapshot.hasError){
          return Center(child: Text("Error ${snapshot.error}"));
        }
        return const Center(child: CircularProgressIndicator(),);
      },
    );
  }
}
