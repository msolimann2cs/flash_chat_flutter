import 'package:equatable/equatable.dart';
import 'package:flash_chat_flutter/bloc/repository/firebase_manager.dart';
import 'package:bloc/bloc.dart';

class LoginState extends Equatable {
  LoginState({this.showSpinner, this.email, this.password});
  String? email;
  String? password;
  bool? showSpinner;

  @override
  // TODO: implement props
  List<Object?> get props => [showSpinner, email, password];
}
