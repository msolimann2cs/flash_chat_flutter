import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:flash_chat_flutter/components/rounded_button.dart';

class AddFriend extends StatefulWidget {
  const AddFriend({Key? key}) : super(key: key);

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF7F7F7),
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(35),
                  bottomLeft: Radius.circular(35),
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 154.0),
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
                            //email = value;
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
                              hintText: 'Search people...'),
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
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: RoundedButton(
                      text: 'add friend',
                      color: Colors.lightBlueAccent,
                      onPress: null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
