import 'package:flash_chat_flutter/bloc/model/new_chat_state.dart';
import 'package:flash_chat_flutter/bloc/repository/firebase_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc/bloc.dart';

class NewChatProvider extends Cubit<NewChatState> {
  NewChatProvider() : super(NewChatState(showSpinner: false, email: ''));
  FirebaseManager firebaseManager = FirebaseManager();

  var friendsStreamSnapshots =
      FirebaseFirestore.instance.collection('users').snapshots();

  void getCurrentUser() async {
    emit(NewChatState(showSpinner: true, email: state.email));
    try {
      var user = await firebaseManager.getCurrentUser();
      emit(NewChatState(showSpinner: false, email: user!.email));
    } catch (e) {
      print(e);
    }
  }
}
