import 'dart:math';

import 'package:flash_chat_flutter/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_flutter/services/firebase_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:flash_chat_flutter/components/rounded_button.dart';

final _firestore = FirebaseFirestore.instance;
FirebaseManager firebaseManager = FirebaseManager();

class ProfilePage extends StatefulWidget {
  static String id = 'profile_page_screen';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var username;
  var name;
  var nickname;
  var email;
  var loggedInUser;

  void getUserData() async {
    loggedInUser = await firebaseManager.getCurrentUser();
    var userDataInit = _firestore.collection('users').doc();
    var userDataRef = await userDataInit.get();
    // for(var user in userDataRef.){
    //
    // }
    await for (var snapshot in _firestore.collection('users').snapshots()) {
      for (var user in snapshot.docs) {
        if (user.data()['email'] == loggedInUser!.email) {
          setState(() {
            username = user.data()['username'];
            name = user.data()['name'];
            nickname = user.data()['nickname'];
            email = user.data()['email'];
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              //color: Colors.yellow,
              //width: 200,
              height: 95,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(35),
                    bottomLeft: Radius.circular(35)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: CircleAvatar(
                      radius: 26,
                      backgroundImage: AssetImage('images/EmptyProfile.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      '$name',
                      style: TextStyle(
                        fontSize: 31,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                    child: TextField(
                      textAlign: TextAlign.center,
                      //controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        name = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          filled: true,
                          fillColor: Color(0xFFF6F6F6),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF9DCAEB), width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF9DCAEB), width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          hintStyle: TextStyle(
                            color: Color(0xFFB8B8B8),
                          ),
                          hintText: 'Change name...'),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  RoundedButton(
                    text: 'Change Name',
                    color: Color(0xFF9DCAEB),
                    onPress: () async {
                      //var userObj = _firestore.collection('users').where('email', whereIn: [loggedInUser!.email]);
                      await for (var snapshot
                          in _firestore.collection('users').snapshots()) {
                        for (var user in snapshot.docs) {
                          if (user.data()['email'] == loggedInUser!.email) {
                            // username = user.data()['username'];
                            // name = user.data()['name'];
                            // nickname = user.data()['nickname'];
                            // email = user.data()['email'];
                            //user.data().update('name', (value) => name);
                            //user.data()['name'] = 'lol';
                            var batch = _firestore.batch();
                            batch.update(user.reference, {'name': name});
                            batch.commit();
                            setState(() {
                              name = name;
                            });
                          }
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
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
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.phone,
                          color: Color(0xFFD4D4D4),
                        ),
                        Text(
                          'Calls',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, MainScreen.id);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.solidComments,
                            color: Color(0xFFD4D4D4),
                          ),
                          Text(
                            'Chats',
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    // MaterialButton(
                    //   onPressed: null,
                    //   height: 300,
                    //   color: Colors.red,
                    //   child: Text('e'),
                    // ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.userGroup,
                          color: Color(0xFFD4D4D4),
                        ),
                        Text(
                          'Friends',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.solidUser,
                          color: Color(0xFF9DCAEB),
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
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
