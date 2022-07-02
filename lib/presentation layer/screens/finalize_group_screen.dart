import 'package:flash_chat_flutter/bloc/data_provider/create_group_provider.dart';
import 'package:flash_chat_flutter/bloc/model/create_group_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flash_chat_flutter/application layer/resources/components/rounded_button.dart';
import 'package:flash_chat_flutter/application layer/resources/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';

class FinalizeGroup extends StatefulWidget {
  const FinalizeGroup({Key? key}) : super(key: key);

  @override
  State<FinalizeGroup> createState() => _FinalizeGroupState();
}

class _FinalizeGroupState extends State<FinalizeGroup> {
  String? groupName;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateGroupProvider, CreateGroupState>(
      builder: (context, state) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
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
                      padding: const EdgeInsets.only(left: 120.0, bottom: 10),
                      child: Text(
                        'New group',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 85.0, top: 0.87),
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<CreateGroupProvider>(context)
                              .createGroupChat(groupName!, context);
                        },
                        child: Text(
                          'Create',
                          style: TextStyle(
                            fontSize: 18,
                            color:
                                state.activeNext! ? Colors.black : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 2.0, right: 13, left: 13),
                      child: Icon(
                        Ionicons.camera_outline,
                        color: Colors.black,
                        size: 48,
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3.0, right: 10),
                        child: TextField(
                          //textAlign: TextAlign.center,
                          onChanged: (value) {
                            groupName = value;
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
                              hintText: 'Group name'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // RoundedButton(
              //   text: 'create group',
              //   color: Colors.red,
              //   onPress: () {
              //     print(state.friendEmails);
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
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
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

// return BlocProvider<CreateGroupProvider>(
// create: (context) => CreateGroupProvider(),
// child: BlocBuilder<CreateGroupProvider, CreateGroupState>(
// builder: (context, state) {
// return Container(
// height: 660,
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(40), topRight: Radius.circular(40)),
// ),
// );
// },
// ),
// );

// return Container(
// height: 660,
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(40),
// topRight: Radius.circular(40),
// ),
// ),
// child: Text('hello'),
// );
