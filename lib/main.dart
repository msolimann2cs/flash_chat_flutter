import 'package:flash_chat_flutter/presentation%20layer/screens/create_chat.dart';
import 'package:flash_chat_flutter/presentation%20layer/screens/friends_screen.dart';
import 'package:flash_chat_flutter/presentation%20layer/screens/main_screen.dart';
import 'package:flash_chat_flutter/presentation%20layer/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/presentation%20layer/screens/welcome_screen.dart';
import 'package:flash_chat_flutter/presentation%20layer/screens/login_screen.dart';
import 'package:flash_chat_flutter/presentation%20layer/screens/registration_screen.dart';
import 'package:flash_chat_flutter/presentation%20layer/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  // Ensure that Firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(
    // options: FirebaseOptions(
    //     apiKey: "AIzaSyC_6IlPChOpmYzpUfd4DQVAD-MreaZcng4",
    //     authDomain: "flash-chat-flutter-72301.firebaseapp.com",
    //     projectId: "flash-chat-flutter-72301",
    //     storageBucket: "flash-chat-flutter-72301.appspot.com",
    //     messagingSenderId: "862805045389",
    //     appId: "1:862805045389:web:5e68050a1da70ebb1072c4",
    //     measurementId: "G-B6YVCC0QB3"),
  );

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
        FriendsScreen.id: (context) => FriendsScreen(),
      },
    );
  }
}
