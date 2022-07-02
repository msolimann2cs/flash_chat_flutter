import 'package:flash_chat_flutter/bloc/data_provider/new_chat_provider.dart';
import 'package:flash_chat_flutter/bloc/model/new_chat_state.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_flutter/presentation layer/screens/chat_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class friend extends StatefulWidget {
  friend({this.name, this.email});
  final name;
  final email;
  @override
  State<friend> createState() => _friendState();
}

class _friendState extends State<friend> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<NewChatProvider>(context),
      //create: (context) => NewChatProvider(),
      child: BlocBuilder<NewChatProvider, NewChatState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () async {
              bool createChat = false;
              print(widget.email);
              var chat1 = _firestore
                  .collection('Chats')
                  .orderBy('id', descending: true);
              var chatRef1 = await chat1.get();
              List chatUsers = [];
              for (var snapshot in chatRef1.docs) {
                chatUsers = snapshot.get('users');
                var chatID = snapshot.id;
                print(chatUsers);
                for (var user in chatUsers) {
                  if (chatUsers.length == 2 && user == widget.email) {
                    //redirect user to their chat
                    print('working?');
                    createChat = false;
                    print(chatID.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ChatScreen(
                            chatID: chatID.toString(),
                          );
                        },
                      ),
                    );
                    return;
                  }
                }
                createChat = true;
              }
              if (createChat == true) {
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
                _firestore.collection('Chats').add({
                  'id': chatID,
                  'name': chatID.toString(),
                  'type': 'pc',
                  'users': [state.email, widget.email],
                });
                createChat = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ChatScreen(
                        chatID: chatID.toString(),
                      );
                    },
                  ),
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Color(0xFFF7F7F7),
                    )),
                    child: Material(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      elevation: 0.6,
                      color: Colors.white,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Center(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: CircleAvatar(
                                  radius: 23,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      AssetImage('images/EmptyProfile.png'),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        widget.name,
                                        style: TextStyle(
                                          //color: Colors.black54,
                                          color: Color(0xFF595959),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
