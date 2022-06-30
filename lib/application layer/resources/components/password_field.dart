import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/application layer/resources/constants.dart';

class PasswordField extends StatelessWidget {
  PasswordField({this.onChanged});
  void Function(String?)? onChanged;
  @override
  Widget build(context) {
    return TextField(
      obscureText: true,
      textAlign: TextAlign.center,
      onChanged: onChanged,
      style: TextStyle(
        color: Colors.black,
      ),
      decoration:
          kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
    );
  }
}
