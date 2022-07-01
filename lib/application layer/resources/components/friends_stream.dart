import 'package:flash_chat_flutter/bloc/data_provider/new_chat_provider.dart';
import 'package:flash_chat_flutter/bloc/model/new_chat_state.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flash_chat_flutter/application layer/resources/components/chat_holder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'friend_card.dart';

class friendsStream extends StatelessWidget {
  const friendsStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewChatProvider>(
      create: (context) => NewChatProvider(),
      child: BlocBuilder<NewChatProvider, NewChatState>(
        builder: (context, state) {
          return StreamBuilder<QuerySnapshot>(
            stream: BlocProvider.of<NewChatProvider>(context)
                .friendsStreamSnapshots, //orderBy('timestamp').snapshots() //  .doc('Group Chats').collection('Chats')
            builder: (context, snapshot) {
              List<friend> myFriends = [];
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              final users = snapshot.data!.docs;
              BlocProvider.of<NewChatProvider>(context).getCurrentUser();
              for (var user in users) {
                final userEmail = user['email'];
                if (userEmail == state.email) {
                  final List userFriends = user['friends'];
                  for (int i = 0; i < userFriends.length; i++) {
                    String? email = userFriends[i].toString();
                    String? name =
                        email?.substring(0, email.indexOf('@gmail.com', 0));
                    final friendCard = friend(
                      name: name,
                      email: email,
                    );
                    myFriends.add(friendCard);
                  }
                }
              }

              return Expanded(
                child: ListView(
                  //controller: scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  children: myFriends,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
