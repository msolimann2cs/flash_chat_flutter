import 'package:flash_chat_flutter/bloc/data_provider/create_group_provider.dart';
import 'package:flash_chat_flutter/bloc/model/create_group_state.dart';
import 'package:flash_chat_flutter/presentation%20layer/screens/finalize_group_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/application%20layer/resources/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_flutter/bloc/repository/firebase_manager.dart';
import 'package:provider/provider.dart';
//import 'package:flash_chat_flutter/application layer/resources/components/friends_stream.dart';

final scrollController = ScrollController();
FirebaseManager firebaseManager = FirebaseManager();
final _firestore = FirebaseFirestore.instance;
var loggedInUser;

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  //var choosenFriendsHeight = 0.0; // 0 = hidden 14 == shown
  List<Widget> addedFriends2 = [
    choosenFriendCard(
      name: 'haru',
    )
  ];
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
    return BlocProvider<CreateGroupProvider>(
      create: (context) => CreateGroupProvider(),
      lazy: false,
      child: BlocBuilder<CreateGroupProvider, CreateGroupState>(
          builder: (context, state) {
        return Column(
          children: [
            Container(
              height: 660,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    //bottomRight: Radius.circular(35),
                    //bottomLeft: Radius.circular(35),
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 29.5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              // setState(() {
                              //   choosenFriendsHeight == 0
                              //       ? choosenFriendsHeight = 64
                              //       : choosenFriendsHeight = 0;
                              // });
                            },
                            child: Icon(
                              FontAwesomeIcons.xmark,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 85.0, bottom: 10),
                          child: Text(
                            'Add Participants',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 19,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 74.0, top: 0.87),
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(60),
                                  ),
                                ),
                                builder: (cxt) => BlocProvider.value(
                                  value: BlocProvider.of<CreateGroupProvider>(
                                      context),
                                  child: SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: FinalizeGroup(),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 18,
                                color: state.activeNext!
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 33.0, top: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 14),
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
                              //userToAdd = value;
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
                                hintText: 'Search...'),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 0), //Text field size
                          child: Icon(
                            FontAwesomeIcons.magnifyingGlass,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<CreateGroupProvider>(context)
                            .rebuildTest();
                      },
                      child: BlocBuilder<CreateGroupProvider, CreateGroupState>(
                          builder: (context5, state5) {
                        return Container(
                          height: state.choosenFriendsHeight,
                          child: ListView.builder(
                            itemCount: state.friends.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext ctx, index) {
                              return state.friends[index];
                            },
                            //children: state.friends,
                          ),
                          // child: Row(
                          //   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //   ],
                          // ),
                        );
                      }),
                    ),
                  ),
                  //Prolly a stream of friends here
                  groupFriendStream(),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class choosenFriendCard extends StatelessWidget {
  choosenFriendCard({this.name, Key? key}) : super(key: key);
  final name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: 50,
        child: Column(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('images/EmptyProfile.png'),
            ),
            Text(
              name != null ? name : '',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

//<------------------------------------------FRIEND STREAM----------------------------------------->
class groupFriendStream extends StatelessWidget {
  const groupFriendStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateGroupProvider, CreateGroupState>(
      builder: (context, state) {
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
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    print(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateGroupProvider, CreateGroupState>(
        builder: (context, state) {
      return GestureDetector(
        onTap: () {
          List<Widget>? test = state.friends;
          List<String>? friendmails = state.friendEmails;
          Widget test2 = choosenFriendCard(
            key: ValueKey(widget.name),
            name: widget.name,
          );

          if (!isChecked) {
            test.add(test2);
            friendmails!.add(widget.email);
            BlocProvider.of<CreateGroupProvider>(context)
                .addChoosenFriend(test!, friendmails);
            //cardIndex++;
            print(test);
          } else {
            Widget remove =
                test.firstWhere((element) => element.key == test2.key);
            test.remove(remove);
            friendmails!.remove(widget.email);
            BlocProvider.of<CreateGroupProvider>(context)
                .removeChoosenFriend(test, friendmails);

            //cardIndex--;
            print(test);
            if (state.friends.length == 0) {
              BlocProvider.of<CreateGroupProvider>(context).closeTab();
            }
          }
          setState(() {
            isChecked = !isChecked;
            // addedFriends.add(choosenFriendCard(
            //   name: widget.name,
            // ));
          });
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
                          Checkbox(
                            //fillColor: Colors.red,
                            checkColor: Color(0xFF8CB9DA),
                            value: isChecked,
                            onChanged: null,
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
    });
  }
}
