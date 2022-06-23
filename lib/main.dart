import 'package:flash_chat_flutter/screens/create_chat.dart';
import 'package:flash_chat_flutter/screens/main_screen.dart';
import 'package:flash_chat_flutter/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/screens/welcome_screen.dart';
import 'package:flash_chat_flutter/screens/login_screen.dart';
import 'package:flash_chat_flutter/screens/registration_screen.dart';
import 'package:flash_chat_flutter/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  // Ensure that Firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  //
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFFF7F7F7),
        bottomAppBarColor: Colors.white,
        appBarTheme: AppBarTheme(foregroundColor: Colors.black),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        MainScreen.id: (context) => MainScreen(),
        CreateChat.id: (context) => CreateChat(),
        ProfilePage.id: (context) => ProfilePage(),
      },
    );
  }
}
