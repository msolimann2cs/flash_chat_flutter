import 'package:bloc/bloc.dart';
import 'package:flash_chat_flutter/bloc/model/MainScreenState.dart';
import 'package:flash_chat_flutter/bloc/repository/firebase_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainScreenProvider extends Cubit<MainScreenState> {
  MainScreenProvider()
      : super(MainScreenState(showSpinner: false, privateChat: true));
  FirebaseManager firebaseManager = FirebaseManager();
  //final _firestore = FirebaseFirestore.instance;
  var privateChatStreamSnapshots =
      FirebaseFirestore.instance.collection('Chats').orderBy('id').snapshots();
  var groupChatStreamSnapshots =
      FirebaseFirestore.instance.collection('Chats').orderBy('id').snapshots();

  void getCurrentUser() async {
    emit(MainScreenState(
        showSpinner: true, email: state.email, privateChat: state.privateChat));
    try {
      var user = await firebaseManager.getCurrentUser();
      emit(MainScreenState(
          showSpinner: false,
          email: user!.email,
          privateChat: state.privateChat));
    } catch (e) {
      print(e);
    }
  }

  void changeToGroupChat() {
    emit(MainScreenState(
        showSpinner: false, email: state.email, privateChat: false));
  }

  void changeToPrivateChat() {
    emit(MainScreenState(
        showSpinner: false, email: state.email, privateChat: true));
  }
}
