import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/application layer/resources/constants.dart';

class EmailField extends StatelessWidget {
  EmailField({this.onChanged});
  void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.center,
      onChanged: onChanged,
      style: TextStyle(
        color: Colors.black,
      ),
      decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
    );
  }
}
