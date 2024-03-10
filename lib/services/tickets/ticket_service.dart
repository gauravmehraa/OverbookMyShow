import 'package:cloud_firestore/cloud_firestore.dart';

class TicketService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream userStream = FirebaseFirestore.instance.collection('users').snapshots();
  Stream eventStream = FirebaseFirestore.instance.collection('events').snapshots();
  Stream ticketStream = FirebaseFirestore.instance.collection('tickets').snapshots();


}