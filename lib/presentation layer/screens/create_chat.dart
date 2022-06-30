import 'package:flash_chat_flutter/presentation%20layer/screens/add_friend.dart';
import 'package:flash_chat_flutter/presentation%20layer/screens/create_group.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flash_chat_flutter/application layer/resources/components/rounded_button.dart';
import 'package:flash_chat_flutter/application%20layer/resources/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_flutter/bloc/repository/firebase_manager.dart';
import 'package:ionicons/ionicons.dart';
import 'chat_screen.dart';

final scrollController = ScrollController();
FirebaseManager firebaseManager = FirebaseManager();
final _firestore = FirebaseFirestore.instance;

var loggedInUser;

var userHolder;

class CreateChat extends StatefulWidget {
  static String id = 'create_chat_screen';

  @override
  State<CreateChat> createState() => _CreateChatState();
}

class _CreateChatState extends State<CreateChat> {
  //final _firestore = FirebaseFirestore.instance;
  List<String> users = [];
  //List<friend> myFriends = [];
  //List userFriends = [];
  var chatName;
  void getCurrentUser() async {
    loggedInUser = await firebaseManager.getCurrentUser();
  }

  // void createFriendCard() async {
  //   loggedInUser = await firebaseManager.getCurrentUser();
  //   users = [loggedInUser!.email];
  //   //print(users);
  //   bool close = false;
  //   var friends = _firestore.collection('users');
  //   var friendsRef = await friends.get();
  //   for (var snapshot in friendsRef.docs) {
  //     var userEmail = snapshot.get('email');
  //     if (userEmail == loggedInUser!.email) {
  //       List friends = snapshot.get('friends');
  //       //print(friends);
  //       for (int i = 0; i < friends.length; i++) {
  //         String? email = friends[i].toString();
  //         String? name = email?.substring(0, email.indexOf('@gmail.com', 0));
  //         print(name);
  //         var friendCard = friend(
  //           name: name,
  //           email: email,
  //         );
  //         myFriends.add(friendCard);
  //       }
  //     }
  //   }
  // await for (var snapshot in ) {
  //   print('object');
  //   for (var user in snapshot.docs) {
  //     if (user.data()['email'] == loggedInUser!.email) {
  //       userFriends = user.data()['friends'];
  //       close = true;
  //       //return;
  //       //print(userFriends);
  //     }
  //   }
  //   if (close == true) {
  //     //return;
  //   }
  // }
  //
  //}

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    // var test = friend(
    //   name: 'Haru',
    //   email: 'haruyukari2@gmail.com',
    // );
    // for (int i = 0; i < 20; i++) {
    //   myFriends.add(test);
    // }
    //createFriendCard();
    // for (int i = 0; i < userFriends.length; i++) {
    //   String? email = userFriends[i].toString();
    //
    //   String? name = email?.substring(0, email.indexOf('@gmail.com', 0));
    //   print(name);
    //   var friendCard = friend(
    //     name: name,
    //     email: email,
    //   );
    //
    //   myFriends.add(friendCard);
    //   print('test');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(35),
                    bottomLeft: Radius.circular(35)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 159.0),
                          child: Text(
                            'New Chat',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 21,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 110.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              FontAwesomeIcons.xmark,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
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
                                      color: Colors.grey, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                                hintStyle: TextStyle(
                                    //color: Color(0xFFB8B8B8),
                                    color: Color(0xFF595959)),
                                hintText: 'Search friends...'),
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
                  )
                ],
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      left: 5,
                      right: 5,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(60),
                                    ),
                                  ),
                                  builder: (context) => SingleChildScrollView(
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: CreateGroup())));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Ionicons.people, size: 38,
                                    //color: Color(0xFFD4D4D4),
                                    color: Color(0xBB595959),
                                  ),
                                  Text('New Group'),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(60),
                                    ),
                                  ),
                                  builder: (context) => SingleChildScrollView(
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: AddFriend())));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Ionicons.person_add, size: 38,
                                    //color: Color(0xFFD4D4D4),
                                    color: Color(0xBB595959),
                                  ),
                                  Text('New Friend'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // FRIENDS SHOULD SHOW UP HERE
                  // Expanded(
                  //   child: ListView(
                  //     controller: scrollController,
                  //     padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  //     children: myFriends,
                  //   ),
                  // ),
                  friendsStream(),
                ],
              ),
            )
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(top: 20),
            //       child: TextField(
            //         textAlign: TextAlign.center,
            //         onChanged: (value) {
            //           userHolder = value;
            //         },
            //         decoration: kTextFieldDecoration.copyWith(
            //             filled: true,
            //             fillColor: Color(0xFFF6F6F6),
            //             enabledBorder: OutlineInputBorder(
            //               borderSide:
            //                   BorderSide(color: Color(0xFF9DCAEB), width: 1.0),
            //               borderRadius: BorderRadius.all(Radius.circular(32.0)),
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //               borderSide:
            //                   BorderSide(color: Color(0xFF9DCAEB), width: 2.0),
            //               borderRadius: BorderRadius.all(Radius.circular(32.0)),
            //             ),
            //             hintStyle: TextStyle(
            //               color: Color(0xFFB8B8B8),
            //             ),
            //             hintText: 'Add users...'),
            //         style: TextStyle(
            //           color: Colors.black,
            //         ),
            //       ),
            //     ),
            //     RoundedButton(
            //         text: 'Add',
            //         color: Color(0xFF9DCAEB),
            //         onPress: () {
            //           users.add(userHolder);
            //         }),
            //     TextField(
            //       textAlign: TextAlign.center,
            //       onChanged: (value) {
            //         chatName = value;
            //       },
            //       decoration: kTextFieldDecoration.copyWith(
            //           filled: true,
            //           fillColor: Color(0xFFF6F6F6),
            //           enabledBorder: OutlineInputBorder(
            //             borderSide:
            //                 BorderSide(color: Color(0xFF9DCAEB), width: 1.0),
            //             borderRadius: BorderRadius.all(Radius.circular(32.0)),
            //           ),
            //           focusedBorder: OutlineInputBorder(
            //             borderSide:
            //                 BorderSide(color: Color(0xFF9DCAEB), width: 2.0),
            //             borderRadius: BorderRadius.all(Radius.circular(32.0)),
            //           ),
            //           hintStyle: TextStyle(
            //             color: Color(0xFFB8B8B8),
            //           ),
            //           hintText: 'Enter chat name...'),
            //       style: TextStyle(
            //         color: Colors.black,
            //       ),
            //     ),
            //     RoundedButton(
            //         text: 'Create Chat',
            //         color: Color(0xFF9DCAEB),
            //         onPress: () async {
            //           var chat = _firestore
            //               .collection('Chats')
            //               .orderBy('id', descending: true)
            //               .limit(1);
            //           var chatRef = await chat.get();
            //           var chatID;
            //           for (var snapshot in chatRef.docs) {
            //             chatID = snapshot.get('id');
            //           }
            //           chatID++;
            //           if (users.length == 2) {
            //             _firestore.collection('Chats').add({
            //               'id': chatID,
            //               'name': chatName,
            //               'type': 'pc',
            //               'users': users,
            //             });
            //           } else {
            //             _firestore.collection('Chats').add({
            //               'id': chatID,
            //               'name': chatName,
            //               'type': 'gc',
            //               'users': users,
            //             });
            //           }
            //         }),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

class friendsStream extends StatelessWidget {
  const friendsStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('users')
          .snapshots(), //orderBy('timestamp').snapshots() //  .doc('Group Chats').collection('Chats')
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

        for (var user in users) {
          final userEmail = user['email'];
          if (userEmail == loggedInUser!.email) {
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
          //final chatID = chat['text'];

          // final chatName = chat['name'];
          // final List chatUsers = chat['users'];
          // //print(chatUsers);
          // final chatID = chat.id; //chat['id'];
          //final timeStamp = message['timestamp'];
          //bool userPresent = false;
          //String? name = chatUsers[1];
          //name = name?.substring(0, name.indexOf('@gmail.com', 0));

          // final chatHolder = ChatHolderNew(
          //   chatName: name,
          //   //text: chatID,
          //   chatID: chatID,
          //   isCurrentUser: userPresent,
          // );
          // for (var userEmail in chatUsers) {
          //   if (loggedInUser!.email == userEmail && chatUsers.length == 2) {
          //     userPresent = true;
          //     allChats.add(chatHolder);
          //   } else {
          //     userPresent = false;
          //   }
          // }
          // if (userPresent) {
          //   allChats.add(chatHolder);
          // }
        }

        return Expanded(
          child: ListView(
            //reverse: true,
            controller: scrollController,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            children: myFriends,
          ),
        );
      },
    );
  }
}

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
  void initState() {
    super.initState();
    print(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool createChat = false;
        print(widget.email);
        var chat1 =
            _firestore.collection('Chats').orderBy('id', descending: true);
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
            'users': [loggedInUser!.email, widget.email],
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

        //end
        // var chat = _firestore
        //     .collection('Chats')
        //     .orderBy('id', descending: true)
        //     .limit(1);
        // var chatRef = await chat.get();
        // var chatID;
        // for (var snapshot in chatRef.docs) {
        //   chatID = snapshot.get('id');
        // }
        // chatID++;
        // if (users.length == 2) {
        //   _firestore.collection('Chats').add({
        //     'id': chatID,
        //     'name': chatName,
        //     'type': 'pc',
        //     'users': users,
        //   });
        // } else {
        //   _firestore.collection('Chats').add({
        //     'id': chatID,
        //     'name': chatName,
        //     'type': 'gc',
        //     'users': users,
        //   });
        // }
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
  }
}
