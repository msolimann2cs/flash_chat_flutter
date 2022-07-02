import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:flash_chat_flutter/bloc/model/LoginScreenState.dart';
import 'package:flash_chat_flutter/presentation%20layer/screens/main_screen.dart';
import 'package:flutter/material.dart';

//part 'package:flash_chat_flutter/presentation layer/screens/login_screen/LoginScreenState.dart';

class FirebaseManager {
  FirebaseManager();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<bool> validateUser(String email, String password) async {
    //emit(LoginState(showSpinner: true));
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        //emit(LoginState(showSpinner: false));
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        return user;
      }
    } catch (e) {
      print(e);
    }
  }
}
