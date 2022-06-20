import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flash_chat_flutter/components/rounded_button.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateChat extends StatefulWidget {
  static String id = 'create_chat_screen';

  @override
  State<CreateChat> createState() => _CreateChatState();
}

class _CreateChatState extends State<CreateChat> {
  final _firestore = FirebaseFirestore.instance;
  var userHolder;
  List<String> users = [];
  var chatName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.plus),
              onPressed: () async {
                Navigator.pushNamed(context, CreateChat.id);
              }),
        ],
        title: Text(
          'Chats',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Material(
            //   color: Colors.white,
            //   child: Text(
            //     'Data',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 20,
            //     ),
            //   ),
            // ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                //Do something with the user input.
                userHolder = value;
              },
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter people you want in the chat'),
            ),
            RoundedButton(
                text: 'Add',
                color: Colors.lightBlueAccent,
                onPress: () {
                  users.add(userHolder);
                }),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                //Do something with the user input.
                chatName = value;
              },
              style: TextStyle(
                color: Colors.black,
              ),
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter Chat Name'),
            ),
            RoundedButton(
                text: 'Create Chat',
                color: Colors.lightBlueAccent,
                onPress: () async {
                  var chat = _firestore
                      .collection('Chats')
                      .orderBy('id', descending: true)
                      .limit(1);
                  var chatRef = await chat.get();
                  var chatID;
                  for (var snapshot in chatRef.docs) {
                    chatID = snapshot.get('id');
                  }
                  chatID++;
                  if (users.length == 2) {
                    _firestore.collection('Chats').add({
                      'id': chatID,
                      'name': chatName,
                      'type': 'pc',
                      'users': users,
                    });
                  } else {
                    _firestore.collection('Chats').add({
                      'id': chatID,
                      'name': chatName,
                      'type': 'gc',
                      'users': users,
                    });
                  }
                }),
          ],
        ),
      ),
    );
  }
}

// var chat = _firestore
//     .collection('Chats')
//     .orderBy('id', descending: true)
//     .limit(1);
// var chatRef = await chat.get();
// var chatID;
// for (var snapshot in chatRef.docs) {
// chatID = snapshot.get('id');
// }
// chatID++;
// print('hi');
// _firestore.collection('Chats').add({
// 'id': chatID,
// 'name': 'Group Chat $chatID',
// 'type': 'gc',
// 'users': ['lol@gmail.com', 'haruyukari2@gmail.com'],
// })
