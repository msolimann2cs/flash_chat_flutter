import 'package:bloc/bloc.dart';
import 'package:flash_chat_flutter/bloc/model/LoginScreenState.dart';
import 'package:flash_chat_flutter/bloc/repository/firebase_manager.dart';

class LoginProvider extends Cubit<LoginState> {
  LoginProvider() : super(LoginState(showSpinner: false));
  FirebaseManager firebaseManager = FirebaseManager();

  bool login(String email, String password) {
    emit(LoginState(showSpinner: true));
    if (firebaseManager.validateUser(email, password)) {
      emit(LoginState(showSpinner: false));
      return true;
    }
    return false;
  }
}
