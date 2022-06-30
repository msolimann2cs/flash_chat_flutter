import 'package:flash_chat_flutter/bloc/data_provider/main_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_flutter/application layer/resources/components/chat_holder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flash_chat_flutter/bloc/model/MainScreenState.dart';

class PrivateChatStream extends StatelessWidget {
  const PrivateChatStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainScreenProvider>(
      create: (context) => MainScreenProvider(),
      child: BlocBuilder<MainScreenProvider, MainScreenState>(
          builder: (context, state) {
        return StreamBuilder<QuerySnapshot>(
          stream: BlocProvider.of<MainScreenProvider>(context)
              .privateChatStreamSnapshots,
          //orderBy('timestamp').snapshots() //  .doc('Group Chats').collection('Chats')
          builder: (context, snapshot) {
            List<ChatHolderNew> allChats = [];
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              );
            }
            final chats = snapshot.data!.docs;

            for (var chat in chats) {
              //final chatID = chat['text'];
              final chatName = chat['name'];
              final List chatUsers = chat['users'];
              //print(chatUsers);
              final chatID = chat.id; //chat['id'];
              //final timeStamp = message['timestamp'];
              bool userPresent = false;
              String? name = chatUsers[1];
              name = name?.substring(0, name.indexOf('@gmail.com', 0));
              final chatHolder = ChatHolderNew(
                chatName: name,
                //text: chatID,
                chatID: chatID,
                isCurrentUser: userPresent,
              );
              BlocProvider.of<MainScreenProvider>(context).getCurrentUser();
              //print(BlocProvider.of<MainScreenProvider>(context).email);
              for (var userEmail in chatUsers) {
                if (state.email == userEmail && chatUsers.length == 2) {
                  // old condition = oggedInUser!.email == userEmail && chatUsers.length == 2
                  userPresent = true;
                  allChats.add(chatHolder);
                } else {
                  userPresent = false;
                }
              }
            }
            return Expanded(
              child: ListView(
                //reverse: true,
                controller: scrollController,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                children: allChats,
              ),
            );
          },
        );
      }),
    );
  }
}
