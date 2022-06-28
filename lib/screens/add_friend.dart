import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:flash_chat_flutter/components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_flutter/services/firebase_manager.dart';

FirebaseManager firebaseManager = FirebaseManager();
final _firestore = FirebaseFirestore.instance;
var loggedInUser;

class AddFriend extends StatefulWidget {
  const AddFriend({Key? key}) : super(key: key);

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  var userToAdd;
  void getCurrentUser() async {
    loggedInUser = await firebaseManager.getCurrentUser();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                //bottomRight: Radius.circular(35),
                //bottomLeft: Radius.circular(35),
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 29.5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 153.0),
                      child: Text(
                        'New Friend',
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
                          userToAdd = value;
                        },
                        style: TextStyle(
                            //color: Color(0xFFD4D4D4),
                            color: Color(0xFF595959)),
                        decoration: kTextFieldDecoration.copyWith(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            hintStyle: TextStyle(
                                //color: Color(0xFFB8B8B8),
                                color: Color(0xFF595959)),
                            hintText: 'Search Users...'),
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
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 70, left: 97),
                  child: RoundedButton(
                    text: 'Add Friend',
                    color: Colors.lightBlueAccent,
                    onPress: () async {
                      var userData = _firestore.collection('users');
                      var userRef = await userData.get();
                      for (var snapshot in userRef.docs) {
                        if (loggedInUser!.email == snapshot.get('email')) {
                          await snapshot.reference.update({
                            'friends': FieldValue.arrayUnion([userToAdd])
                          }); //var user = await
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
