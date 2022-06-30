import 'package:flash_chat_flutter/bloc/repository/firebase_manager.dart';
import 'package:bloc/bloc.dart';

class LoginState {
  LoginState({this.showSpinner});
  String? email;
  String? password;
  bool? showSpinner;
}
