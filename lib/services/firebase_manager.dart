import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseManager {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        // loggedInUser = user;
        // print(loggedInUser!.email);
        return user;
      }
    } catch (e) {
      print(e);
    }
  }
}
