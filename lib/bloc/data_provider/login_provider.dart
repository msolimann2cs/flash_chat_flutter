import 'package:bloc/bloc.dart';
import 'package:flash_chat_flutter/bloc/model/LoginScreenState.dart';
import 'package:flash_chat_flutter/bloc/repository/firebase_manager.dart';

class LoginProvider extends Cubit<LoginState> {
  LoginProvider()
      : super(LoginState(showSpinner: false, email: '', password: ''));
  FirebaseManager firebaseManager = FirebaseManager();

  Future<bool> login() async {
    emit(LoginState(
        showSpinner: true, email: state.email, password: state.password));
    if (await firebaseManager.validateUser(state.email!, state.password!)) {
      //print('hi');
      emit(LoginState(
          showSpinner: false, email: state.email, password: state.password));
      return true;
    }
    return false;
  }

  void updateEmail(String email) {
    emit(
        LoginState(showSpinner: false, email: email, password: state.password));
  }

  void updatePassowrd(String password) {
    emit(
        LoginState(showSpinner: false, email: state.email, password: password));
  }
}
