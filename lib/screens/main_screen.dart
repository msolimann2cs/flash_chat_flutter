import 'package:flash_chat_flutter/components/rounded_button.dart';
import 'package:flash_chat_flutter/screens/chat_screen.dart';
import 'package:flash_chat_flutter/screens/create_chat.dart';
import 'package:flash_chat_flutter/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/services/firebase_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

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
  bool privateChat = true;
  Color activeChatTabColor = Color(0xFF8CB9DA);
  Color inactiveChatTabColor = Color(0xFF595959);
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
      //backgroundColor: Color(0xFFF7F7F7),
      backgroundColor: Colors.white,
      body: SafeArea(
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
                              //color: Color(0xFFD4D4D4),
                              color: Color(0xFF595959),
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
                                  //color: Color(0xFFD4D4D4),
                                  color: Color(0xFF595959)),
                              decoration: kTextFieldDecoration.copyWith(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32.0)),
                                  ),
                                  hintStyle: TextStyle(
                                      //color: Color(0xFFB8B8B8),
                                      color: Color(0xFF595959)),
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
                      child: GestureDetector(
                        onTap: () {
                          //Navigator.pushNamed(context, CreateChat.id);
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => CreateChat());
                        },
                        child: Icon(FontAwesomeIcons.penToSquare,
                            //color: Color(0xFFD4D4D4),
                            color: Color(0xFF595959)),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      privateChat = true;
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        'Chats',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: privateChat
                              ? activeChatTabColor
                              : inactiveChatTabColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: SizedBox(
                          height: 1,
                          width: 150,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: privateChat
                                  ? activeChatTabColor
                                  : inactiveChatTabColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      privateChat = false;
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        'Groups',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: privateChat
                              ? inactiveChatTabColor
                              : activeChatTabColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: SizedBox(
                          height: 1,
                          width: 150,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: privateChat
                                  ? inactiveChatTabColor
                                  : activeChatTabColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            privateChat ? PrivateChatStream() : GroupChatStream(),
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
                padding: EdgeInsets.all(0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Icon(
                            Ionicons.call_outline,
                            size: 33,
                            //color: Color(0xFFD4D4D4),
                            color: Color(0xFF595959),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 1),
                          child: Text(
                            'Calls',
                            style: TextStyle(fontSize: 11),
                          ),
                        )
                      ],
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Icon(
                            Ionicons.chatbubbles_outline,
                            size: 32,
                            color: Color(0xDD9DCAEB),
                            //color: Color(0xFF595959),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2, top: 2),
                          child: Text(
                            'Chats',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF8CB9DA),
                            ),
                          ),
                        )
                      ],
                    ),
                    // MaterialButton(
                    //   onPressed: null,
                    //   height: 300,
                    //   color: Colors.red,
                    //   child: Text('e'),
                    // ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Icon(
                            Ionicons.people_outline,
                            size: 38,
                            //color: Color(0xFFD4D4D4),
                            color: Color(0xFF595959),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.5),
                          child: Text(
                            'Friends',
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ProfilePage.id);
                      },
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Icon(
                              Ionicons.person_outline,
                              //color: Color(0xFFD4D4D4),
                              size: 32,
                              color: Color(0xFF595959),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrivateChatStream extends StatelessWidget {
  const PrivateChatStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Chats')
          .orderBy('id')
          .snapshots(), //orderBy('timestamp').snapshots() //  .doc('Group Chats').collection('Chats')
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
          for (var userEmail in chatUsers) {
            if (loggedInUser!.email == userEmail && chatUsers.length == 2) {
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

class GroupChatStream extends StatelessWidget {
  const GroupChatStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Future<String> lastTextFunc() async {
    //   String test = await getChatTexts();
    //   return test;
    // }

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Chats')
          .orderBy('id')
          .snapshots(), //orderBy('timestamp').snapshots() //  .doc('Group Chats').collection('Chats')
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
          final chatID = chat.id; //chat['id'];
          //String? lastText = await lastTextFunc();
          // FutureBuilder<String>(
          //   future: getChatTexts(),
          //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          //     return Text(snapshot.data![0]);
          //   },
          // );
          //getChatTexts().then((value) => lastText);
          //final timeStamp = message['timestamp'];
          bool userPresent = false;

          final chatHolder = ChatHolderNew(
            chatName: chatName,
            //text: chatID,
            chatID: chatID,
            isCurrentUser: userPresent,
            //lastText: lastText,
          );
          for (var userEmail in chatUsers) {
            if (loggedInUser!.email == userEmail && chatUsers.length > 2) {
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

class ChatHolderNew extends StatefulWidget {
  ChatHolderNew({this.chatName, this.chatID, this.isCurrentUser});
  final String? chatName;
  final String? chatID;
  //final String? lastText;
  final bool? isCurrentUser;

  @override
  State<ChatHolderNew> createState() => _ChatHolderNewState();
}

class _ChatHolderNewState extends State<ChatHolderNew> {
  // void getLastText(BuildContext context) {
  //   Provider.of<LastText>(context, listen: false).getChatTexts();
  // }

  bool loaded = false;
  Future getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 2));
  }

  var textTest;

  void getChatTexts() async {
    var getChatID = _firestore.collection('Chats').orderBy('id').limit(1);
    final chats = await getChatID.get();
    var chatIDnew;
    for (var chat in chats.docs) {
      //final chatID = chat['text'];
      chatIDnew = chat.id;
    } //chat['id'];
    var chatTexts = _firestore
        .collection('Chats')
        .doc(widget.chatID)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1);
    var chatTextsRef = await chatTexts.get();
    //print('???');
    for (var snapshot in chatTextsRef.docs) {
      print('???');
      setState(() {
        textTest = snapshot.get('text');
        loaded = true;
      });
    }
    //lastText = 'donkey';
    //print(lastText);
    //return lastText;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //var test = '';
    //getLastText(context);
    //textTest = Provider.of<LastText>(context).lastText;

    setState(() {
      getChatTexts();
      print(textTest);
      //loaded = true;
      // if (textTest == null) {
      //   loaded = false;
      // }
      // getThingsOnStartup().then((value) {
      //   print('Async done');
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    //String? lastText = Provider.of<LastText>(context).lastText;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, ChatScreen.id,
              //     arguments: widget.chatID);
              //print(widget.chatID);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChatScreen(
                      chatID: widget.chatID,
                    );
                  },
                ),
              );

              //print(lastText);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                color: Color(0xFFF7F7F7),
              )),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                elevation: 0.6,
                color: Colors
                    .white, //isCurrentUser! ? Colors.green : Colors.green,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Center(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  widget.chatName!,
                                  style: TextStyle(
                                    //color: Colors.black54,
                                    color: Color(0xFF595959),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text(
                                  loaded ? textTest : '',
                                  style: TextStyle(
                                    //color: Colors.black54,
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: GestureDetector(
                            onTap: () {
                              _firestore
                                  .collection('Chats')
                                  .doc(widget.chatID)
                                  .delete();
                            },
                            child: Icon(
                              FontAwesomeIcons.solidTrashCan,
                              //color: Color(0xFFD4D4D4),
                              color: Color(0xFF595959),
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

// class ChatHolder extends StatelessWidget {
//   void getLastText(BuildContext context) {
//     Provider.of<LastText>(context, listen: false).getChatTexts();
//   }
//
//   ChatHolder({this.chatName, this.chatID, this.isCurrentUser});
//   final String? chatName;
//   final String? chatID;
//   //final String? lastText;
//   final bool? isCurrentUser;
//
//   @override
//   Widget build(BuildContext context) {
//     String? lastText = Provider.of<LastText>(context).lastText;
//     bool loaded = false;
//     //getLastText(context);
//     // Future getThingsOnStartup() async {
//     //   await Future.delayed(Duration(seconds: 2));
//     // }
//
//     return StatefulWrapper(
//       onInit: () {
//         getLastText(context);
//         loaded = true;
//         // getThingsOnStartup().then((value) {
//         //   print('Async done');
//         // });
//       },
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: 5),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             // Text(
//             //   chatName!,
//             //   style: TextStyle(
//             //     fontSize: 12,
//             //     color: Colors.black,
//             //   ),
//             // ),
//
//             GestureDetector(
//               onTap: () {
//                 //Navigator.pushNamed(context, ChatScreen.id, arguments: chatID);
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(
//                 //     builder: (context) {
//                 //       return ChatScreen(
//                 //         chatID: chatID,
//                 //       );
//                 //     },
//                 //   ),
//                 // );
//
//                 print(lastText);
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                   color: Color(0xFFF7F7F7),
//                 )),
//                 child: Material(
//                   borderRadius: BorderRadius.all(Radius.circular(15)),
//                   elevation: 0,
//                   color: Colors
//                       .white, //isCurrentUser! ? Colors.green : Colors.green,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                     child: Center(
//                       child: Row(
//                         //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(right: 10),
//                             child: CircleAvatar(
//                               radius: 26,
//                               backgroundColor: Colors.white,
//                               backgroundImage:
//                                   AssetImage('images/EmptyProfile.png'),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 1,
//                             child: Padding(
//                               padding: const EdgeInsets.only(bottom: 6),
//                               child: Text(
//                                 loaded ? lastText! : 'test',
//                                 style: TextStyle(
//                                   //color: Colors.black54,
//                                   color: Color(0xFF595959),
//                                   fontSize: 30,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 0,
//                             child: GestureDetector(
//                               onTap: () {
//                                 _firestore
//                                     .collection('Chats')
//                                     .doc(chatID)
//                                     .delete();
//                               },
//                               child: Icon(
//                                 FontAwesomeIcons.solidTrashCan,
//                                 //color: Color(0xFFD4D4D4),
//                                 color: Color(0xFF595959),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LastText extends ChangeNotifier {
//   var lastText;
//   void getChatTexts() async {
//     var getChatID = _firestore.collection('Chats').orderBy('id').limit(1);
//     final chats = await getChatID.get();
//     var chatIDnew;
//     for (var chat in chats.docs) {
//       //final chatID = chat['text'];
//       chatIDnew = chat.id;
//     } //chat['id'];
//     var chatTexts = _firestore
//         .collection('Chats')
//         .doc(chatIDnew)
//         .collection('messages')
//         .orderBy('timestamp')
//         .limit(1);
//     var chatTextsRef = await chatTexts.get();
//     //print('???');
//     for (var snapshot in chatTextsRef.docs) {
//       //print('???');
//       lastText = snapshot.get('text');
//     }
//     //lastText = 'donkey';
//     //print(lastText);
//     notifyListeners();
//     //return lastText;
//   }
//
//   String getLastText() {
//     return lastText;
//   }
// }
