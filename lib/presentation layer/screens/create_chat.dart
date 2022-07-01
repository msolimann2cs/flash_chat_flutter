import 'package:flash_chat_flutter/bloc/data_provider/new_chat_provider.dart';
import 'package:flash_chat_flutter/bloc/model/new_chat_state.dart';
import 'package:flash_chat_flutter/presentation%20layer/screens/add_friend.dart';
import 'package:flash_chat_flutter/presentation%20layer/screens/create_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flash_chat_flutter/application%20layer/resources/constants.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flash_chat_flutter/application layer/resources/components/friends_stream.dart';

//var loggedInUser;

//var userHolder;

class CreateChat extends StatefulWidget {
  static String id = 'create_chat_screen';

  @override
  State<CreateChat> createState() => _CreateChatState();
}

class _CreateChatState extends State<CreateChat> {
  List<String> users = [];
  var chatName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewChatProvider>(
      create: (context) => NewChatProvider(),
      child: Scaffold(
        body: BlocBuilder<NewChatProvider, NewChatState>(
            builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state.showSpinner!,
            child: SafeArea(
              child: Column(
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
                                  onChanged: (value) {},
                                  style: TextStyle(color: Color(0xFF595959)),
                                  decoration: kTextFieldDecoration.copyWith(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(32.0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(32.0)),
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
                                        builder: (context) =>
                                            SingleChildScrollView(
                                                child: Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
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
                                        builder: (context) =>
                                            SingleChildScrollView(
                                                child: Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
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
                        friendsStream(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
