import 'package:flash_chat_flutter/application%20layer/resources/components/bottom_bar.dart';
import 'package:flash_chat_flutter/application%20layer/resources/components/friends_stream.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/presentation layer/screens/profile_page.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({Key? key}) : super(key: key);
  static String id = 'friends_screen';

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                child: Text(
                  'Friends',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              friendsStream(),
              BottomBar()
            ],
          ),
        ),
      ),
    );
  }
}
