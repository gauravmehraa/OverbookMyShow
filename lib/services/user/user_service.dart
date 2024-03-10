import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> getName(String userId) async{
    final userCollection = FirebaseFirestore.instance.collection('users');
    final user = await userCollection.doc(userId).get();
    if(user.exists){
      Map<String, dynamic>? data = user.data();
      var value = data?['name'];
      return value;
    }
    return "";
  }
}