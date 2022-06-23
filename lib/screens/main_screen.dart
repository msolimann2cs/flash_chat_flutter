import 'package:flash_chat_flutter/components/rounded_button.dart';
import 'package:flash_chat_flutter/screens/chat_screen.dart';
import 'package:flash_chat_flutter/screens/create_chat.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/services/firebase_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flash_chat_flutter/constants.dart';

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
      backgroundColor: Color(0xFFF7F7F7),
      // appBar: AppBar(
      //   leading: null,
      //   actions: <Widget>[
      //     IconButton(
      //         icon: Icon(
      //           FontAwesomeIcons.plus,
      //           color: Colors.black,
      //         ),
      //         onPressed: () async {
      //           Navigator.pushNamed(context, CreateChat.id);
      //         }),
      //   ],
      //   title: Text(
      //     'Chats',
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 30,
      //       color: Colors.black,
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      // ),

      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      //   child: BottomAppBar(
      //     elevation: 0,
      //     color: Colors.white,
      //     child: Container(
      //       decoration: BoxDecoration(
      //           border: Border.all(
      //             color: Color(0xFFD4D4D4),
      //           ),
      //           borderRadius: BorderRadius.only(
      //               bottomLeft: Radius.circular(0),
      //               bottomRight: Radius.circular(0),
      //               topRight: Radius.circular(40),
      //               topLeft: Radius.circular(40))),
      //       child: Material(
      //         elevation: 0,
      //         color: Colors.white,
      //         borderRadius: BorderRadius.only(
      //             bottomLeft: Radius.circular(0),
      //             bottomRight: Radius.circular(0),
      //             topRight: Radius.circular(40),
      //             topLeft: Radius.circular(40)),
      //         //height: 55,
      //         child: Padding(
      //           padding: EdgeInsets.all(20.0),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             children: [
      //               Icon(
      //                 FontAwesomeIcons.comment,
      //                 color: Colors.grey,
      //               ),
      //               Icon(
      //                 FontAwesomeIcons.user,
      //                 color: Colors.grey,
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        height: 50,
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Icon(
                                FontAwesomeIcons.magnifyingGlass,
                                color: Color(0xFFD4D4D4),
                              ),
                            ),
                            Flexible(
                              child: TextField(
                                //textAlign: TextAlign.center,
                                onChanged: (value) {
                                  //Do something with the user input.
                                  //email = value;
                                },
                                style: TextStyle(
                                  color: Color(0xFFD4D4D4),
                                ),
                                decoration: kTextFieldDecoration.copyWith(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(32.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(32.0)),
                                    ),
                                    hintStyle: TextStyle(
                                      color: Color(0xFFB8B8B8),
                                    ),
                                    hintText: 'Search chat...'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Icon(
                                FontAwesomeIcons.magnifyingGlass,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        height: 50,
                        child: Icon(
                          FontAwesomeIcons.message,
                          color: Color(0xFFD4D4D4),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              ChatsStream(),
              Container(
                //width: 100,
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xFFD4D4D4),
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40))),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        FontAwesomeIcons.gripLines,
                        color: Color(0xFFD4D4D4),
                      ),
                      Icon(
                        FontAwesomeIcons.inbox,
                        color: Color(0xFFD4D4D4),
                      ),
                      // MaterialButton(
                      //   onPressed: null,
                      //   height: 300,
                      //   color: Colors.red,
                      //   child: Text('e'),
                      // ),
                      Icon(
                        FontAwesomeIcons.phone,
                        color: Color(0xFFD4D4D4),
                      ),
                      Icon(
                        FontAwesomeIcons.gears,
                        color: Color(0xFFD4D4D4),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
        crossAxisAlignment: CrossAxisAlignment.end,
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
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                color: Color(0xFFF7F7F7),
              )),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                elevation: 0,
                color: Colors
                    .white, //isCurrentUser! ? Colors.green : Colors.green,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Center(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Expanded(
                            flex: 0,
                            child: CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  AssetImage('images/EmptyProfile.png'),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              chatName!,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: GestureDetector(
                            onTap: () {
                              _firestore
                                  .collection('Chats')
                                  .doc(chatID)
                                  .delete();
                            },
                            child: Icon(
                              FontAwesomeIcons.solidTrashCan,
                              color: Color(0xFFD4D4D4),
                            ),
                          ),
                        ),
                      ],
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
