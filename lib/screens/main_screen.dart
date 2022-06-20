import 'package:flash_chat_flutter/screens/chat_screen.dart';
import 'package:flash_chat_flutter/screens/create_chat.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/services/firebase_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

FirebaseManager firebaseManager = FirebaseManager();
final _firestore = FirebaseFirestore.instance;
final scrollController = ScrollController();
var loggedInUser;

class MainScreen extends StatefulWidget {
  static String id = 'main_screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void getCurrentUser() async {
    loggedInUser = await firebaseManager.getCurrentUser();
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: BottomAppBar(
          elevation: 0,
          color: Colors.white,
          child: Material(
            elevation: 0,
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            //height: 55,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(FontAwesomeIcons.solidComment),
                  Icon(FontAwesomeIcons.solidUser),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ChatsStream(),
          ],
        ),
      ),
    );
  }
}

class ChatsStream extends StatelessWidget {
  const ChatsStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Chats')
          .orderBy('id')
          .snapshots(), //orderBy('timestamp').snapshots() //  .doc('Group Chats').collection('Chats')
      builder: (context, snapshot) {
        List<ChatHolder> allChats = [];
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
          final chatUsers = chat['users'];
          final chatID = chat.id; //chat['id'];
          //final timeStamp = message['timestamp'];
          bool userPresent = false;

          final chatHolder = ChatHolder(
            chatName: chatName,
            //text: chatID,
            chatID: chatID,
            isCurrentUser: userPresent,
          );
          for (var userEmail in chatUsers) {
            if (loggedInUser!.email == userEmail) {
              userPresent = true;
              allChats.add(chatHolder);
            } else {
              userPresent = false;
            }
          }
          // if (userPresent) {
          //   allChats.add(chatHolder);
          // }
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
  }
}

class ChatHolder extends StatelessWidget {
  ChatHolder({this.chatName, this.chatID, this.isCurrentUser});
  final String? chatName;
  final String? chatID;
  //final String? lastText;
  final bool? isCurrentUser;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Text(
          //   chatName!,
          //   style: TextStyle(
          //     fontSize: 12,
          //     color: Colors.black,
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              //Navigator.pushNamed(context, ChatScreen.id, arguments: chatID);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChatScreen(
                  chatID: chatID,
                );
              }));
            },
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              elevation: 0,
              color: Colors.lightBlueAccent
                  .shade100, //isCurrentUser! ? Colors.green : Colors.green,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Center(
                  child: Text(
                    chatName!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
