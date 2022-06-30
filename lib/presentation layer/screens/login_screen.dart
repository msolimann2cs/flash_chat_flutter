import 'package:flash_chat_flutter/bloc/data_provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flash_chat_flutter/application layer/resources/components/rounded_button.dart';
import 'package:flash_chat_flutter/application layer/resources/components/password_field.dart';
import 'package:flash_chat_flutter/application layer/resources/components/email_field.dart';
import 'package:flash_chat_flutter/bloc/repository/firebase_manager.dart';
import 'package:flash_chat_flutter/bloc/model/LoginScreenState.dart';
import 'package:flash_chat_flutter/presentation%20layer/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginProvider>(
      create: (context) => LoginProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<LoginProvider, LoginState>(
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state.showSpinner!,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Flexible(
                      child: Hero(
                        tag: 'logo',
                        child: Container(
                          height: 200.0,
                          child: Image.asset('images/HaruChatLogo.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    EmailField(
                      onChanged: (value) =>
                          BlocProvider.of<LoginProvider>(context).state.email =
                              value,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    PasswordField(
                      onChanged: (value) =>
                          BlocProvider.of<LoginProvider>(context)
                              .state
                              .password = value,
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    RoundedButton(
                      text: 'Log in',
                      color: Colors.lightBlueAccent,
                      onPress: () {
                        if (BlocProvider.of<LoginProvider>(context)
                            .login(state.email!, state.password!))
                          Navigator.pushNamed(context, MainScreen.id);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
