import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Get current user function
  User? getCurrentUser(){
    return _auth.currentUser;
  }

  //Sign in function
  Future<UserCredential> signInWithEmailAndPassword(String email, password) async {
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }


  //Sign up function
  Future<UserCredential> signUpWithEmailAndPassword(String name, email, password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      _firestore.collection("users").doc(userCredential.user!.uid).set(
          {
            'id': userCredential.user!.uid,
            'name': name,
            'email': email,
            'password': password,
            'isAdmin': false,
          }
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //Sign out function
  Future<void> signOut() async{
    return await _auth.signOut();
  }
}