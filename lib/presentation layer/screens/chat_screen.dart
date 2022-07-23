import 'package:flash_chat_flutter/application%20layer/resources/components/friend_card.dart';
import 'package:flash_chat_flutter/presentation%20layer/screens/main_screen.dart';
import 'package:flash_chat_flutter/bloc/repository/firebase_manager.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/application%20layer/resources/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'video_call_screen.dart';
import 'voice_call_screen.dart';

FirebaseManager firebaseManager = FirebaseManager();

final _firestore = FirebaseFirestore.instance;
//final scrollController = ScrollController();
//User? loggedInUser;
var loggedInUser;
var chatID_main;

class ChatScreen extends StatefulWidget {
  ChatScreen({this.chatID, this.chatName});
  static String id = 'chat_screen';
  final chatID;
  final chatName;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  var username;
  var name;
  var nickname;
  var email;
  var friendName;
  var friend;
  String? messageText;

  ClientRole _role = ClientRole.Broadcaster;

  void getCurrentUser() async {
    loggedInUser = await firebaseManager.getCurrentUser();
    //var userDataInit = _firestore.collection('users').doc();
    //var userDataRef = await userDataInit.get();
    // for(var user in userDataRef.){
    //
    // }
    //print(loggedInUser!.email);
    print('object');
    print(loggedInUser!.email);

    var mainChat = _firestore.collection('Chats').doc(chatID_main).snapshots();
    await for (var snapshot in mainChat) {
      //print('eee');
      friend = snapshot.data()!['users'];
      friend = friend[1];
      print(friend);
      break;
    }
    // await for (var snapshot in _firestore.collection('Chats').snapshots()) {
    //   for (var chat in snapshot.docs) {
    //     if (chat.data()['users'].length == 2 && chat.data()['users'][1] == ) {}
    //   }
    // }
    //print('xsxs');
    // await for (var snapshot in _firestore.collection('users').snapshots()) {
    //   for (var user in snapshot.docs) {
    //     print('annoying hi');
    //     String test = user.data()['email'];
    //     String test2 = '';
    //     try {
    //       test2 = test.substring(0, friend.toString().indexOf('@'));
    //       print(test);
    //       print(test2);
    //     } catch (e) {
    //       print(e);
    //     }
    //     //print(test2);
    //     // print(user
    //     //     .data()['email']
    //     //     .toString()
    //     //     .substring(0, user.data()['email'].toString().indexOf(friend, 0)));
    //   }
    // }
    //var test2 = otherUser.doc(documentPath)
    await for (var snapshot in _firestore.collection('users').snapshots()) {
      for (var user in snapshot.docs) {
        //print('hi2');
        if (user.data()['email'] == loggedInUser!.email) {
          setState(() {
            username = user.data()['username'];
            user.data()['name'] == null
                ? name = 'null'
                : name = user.data()['name'];
            nickname = user.data()['nickname'];
            email = user.data()['email'];
          });
//          print('hi');

          //print('object2');
          //print(user.data()['name']);
        }
        if (user
                .data()['email']
                .toString()
                .substring(0, user.data()['email'].toString().indexOf('@')) ==
            friend.toString().substring(0, friend.toString().indexOf('@'))) {
          // print(
          //     friend.toString().substring(0, friend.toString().indexOf('@')));

          // print(friend.toString().substring(0, friend.toString().indexOf('@')));
          //print(user.data()['email']);
          setState(() {
            user.data()['name'] == null
                ? friendName = 'null'
                : friendName = user.data()['name'];
            //print(friendName);
            //friendName = user.data()['name'];
          });
        }
      }
    }
  }

  void messageStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        //print(message.data());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    chatID_main = widget.chatID;
    print(widget.chatID);
    //print('test');
    getCurrentUser();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(35),
                          bottomLeft: Radius.circular(35)),
                    ),
                    height: 95,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: GestureDetector(
                            onTap: () {
                              //_auth.signOut();
                              //Navigator.pop(context);
                              Navigator.pushNamed(context, MainScreen.id);
                            },
                            //messageStream();,
                            child: Icon(
                              FontAwesomeIcons.arrowLeft,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage('images/EmptyProfile.png'),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 34, 0, 0),
                              child: Text(
                                friendName,
                                style: TextStyle(color: Colors.black87),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                'Online',
                                style: TextStyle(color: Colors.green),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(150, 10, 0, 0),
                          child: GestureDetector(
                            onTap: () {
                              print(name);
                            },
                            child: GestureDetector(
                              onTap: () async {
                                setState(() {
                                  // _channelController.text.isEmpty
                                  //     ? _validateError = true
                                  //     : _validateError = false;
                                });
                                await _handleCameraAndMic(Permission.camera);
                                await _handleCameraAndMic(
                                    Permission.microphone);
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoCallPage(
                                      channelName: widget.chatID,
                                      role: _role,
                                      chatName: widget.chatName,
                                    ),
                                  ),
                                );
                              },
                              child: Icon(
                                FontAwesomeIcons.video,
                                color: Color(0xFFD4D4D4),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40, top: 10),
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                // _channelController.text.isEmpty
                                //     ? _validateError = true
                                //     : _validateError = false;
                              });
                              //await _handleCameraAndMic(Permission.camera);
                              await _handleCameraAndMic(Permission.microphone);
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VoiceCallPage(
                                    channelName: 'test',
                                    role: _role,
                                    chatName: widget.chatName,
                                  ),
                                ),
                              );
                            },
                            child: Icon(
                              FontAwesomeIcons.phone,
                              color: Color(0xFFD4D4D4),
                            ),
                          ),
                        )
                      ],
                    ),
                    //width: double.infinity,
                  ),
                ),
              ],
            ),
            MessagesStream(),
            Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xFFD4D4D4),
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          //Do something with the user input.
                          messageText = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            filled: true,
                            fillColor: Color(0xFFF6F6F6),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            hintStyle: TextStyle(
                              color: Color(0xFFB8B8B8),
                            ),
                            hintText: 'Type here...'),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print('c');
                      //Implement send functionality.
                      //messageTextController.clear();
                      // if (scrollController.hasClients) {
                      //   final position =
                      //       scrollController.position.minScrollExtent;
                      //   scrollController.jumpTo(position);
                      // }
                      _firestore
                          .collection('Chats')
                          .doc(chatID_main)
                          .collection('messages')
                          .add({
                        'text': messageText,
                        'sender': loggedInUser!.email,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Chats')
          .doc(chatID_main)
          .collection('messages')
          .orderBy('timestamp')
          .snapshots(), //.orderBy('timestamp').snapshots(), //.where('id',whereIn: ['1'])
      builder: (context, snapshot) {
        List<MessageBubble> messageBubbles = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;

        for (var message in messages) {
          final messageText = message['text'];
          final messageSender = message['sender'];
          //final timeStamp = message['timestamp'];
          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isCurrentUser: loggedInUser!.email == messageSender,
          );
          messageBubbles.add(messageBubble);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            //controller: scrollController,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isCurrentUser});
  final String? sender;
  final String? text;
  final bool? isCurrentUser;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isCurrentUser! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender!,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isCurrentUser!
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30)),
            elevation: 5,
            color: isCurrentUser! ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                text!,
                style: TextStyle(
                  color: isCurrentUser! ? Colors.white : Colors.black54,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _handleCameraAndMic(Permission permission) async {
  final status = await permission.request();
  print(status);
}
