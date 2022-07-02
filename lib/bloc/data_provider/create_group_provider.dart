import 'package:flash_chat_flutter/bloc/model/create_group_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_flutter/bloc/repository/firebase_manager.dart';
import 'package:flash_chat_flutter/presentation layer/screens/chat_screen.dart';

class CreateGroupProvider extends Cubit<CreateGroupState> {
  CreateGroupProvider()
      : super(CreateGroupState(
            friends: [],
            choosenFriendsHeight: 0.0,
            activeNext: false,
            friendEmails: []));

  FirebaseManager firebaseManager = FirebaseManager();

  // TODO: implement props
  void addChoosenFriend(List<Widget> list, List<String> friendmails) {
    // List<Widget> addedFriends = state.friends!;
    // addedFriends.add(widget);
    if (state.choosenFriendsHeight == 0) {
      emit(CreateGroupState(
          friends: list,
          choosenFriendsHeight: 64.0,
          activeNext: true,
          friendEmails: friendmails));
    } else if (state.choosenFriendsHeight == 64) {
      emit(CreateGroupState(
          friends: list,
          choosenFriendsHeight: 63.0,
          activeNext: true,
          friendEmails: friendmails));
    } else if (state.choosenFriendsHeight == 63) {
      emit(CreateGroupState(
          friends: list,
          choosenFriendsHeight: 64.0,
          activeNext: true,
          friendEmails: friendmails));
    }
    //emit(CreateGroupState(friends: list, choosenFriendsHeight: 63.0));
    //emit(CreateGroupState(friends: list, choosenFriendsHeight: 64.0));
  }

  void removeChoosenFriend(List<Widget> list, List<String> friendmails) {
    //List<Widget> addedFriends = state.friends!;
    //print('hi');
    // if (addedFriends.contains(widget)) {
    //   print('hi');
    // }

    // for (int i = 0; i < addedFriends.length; i++) {
    //   addedFriends.elementAt(i).
    // }
    // addedFriends.elementAt(1).key == widget.key;
    // if (addedFriends.contains(widget)) {
    //   print('hi');
    // }
    // Widget remove = addedFriends
    //     .firstWhere((element) => element.runtimeType == widget.runtimeType);

    // Widget remove =
    //     addedFriends.firstWhere((element) => element.key == widget.key);
    //addedFriends.contains('admin');
    //addedFriends.removeAt(index - 1);
    //addedFriends.remove(remove);
    if (state.choosenFriendsHeight == 0) {
      emit(CreateGroupState(
          friends: list,
          choosenFriendsHeight: 64.0,
          activeNext: true,
          friendEmails: friendmails));
    } else if (state.choosenFriendsHeight == 64) {
      emit(CreateGroupState(
          friends: list,
          choosenFriendsHeight: 63.0,
          activeNext: true,
          friendEmails: friendmails));
    } else if (state.choosenFriendsHeight == 63) {
      emit(CreateGroupState(
          friends: list,
          choosenFriendsHeight: 64.0,
          activeNext: true,
          friendEmails: friendmails));
    }
    //emit(CreateGroupState(friends: list, choosenFriendsHeight: 0.0));
    //emit(CreateGroupState(friends: list, choosenFriendsHeight: 64.0));

    // if (state.choosenFriendsHeight == 64) {
    //   emit(CreateGroupState(friends: addedFriends, choosenFriendsHeight: 63.0));
    // } else if (state.choosenFriendsHeight == 63) {
    //   emit(CreateGroupState(friends: addedFriends, choosenFriendsHeight: 64.0));
    // }
    //emit(CreateGroupState(friends: addedFriends, choosenFriendsHeight: 63.0));
    //CreateGroupState(friends: addedFriends, choosenFriendsHeight: 64.0)
  }

  void closeTab() {
    emit(CreateGroupState(
        friends: [],
        choosenFriendsHeight: 0.0,
        activeNext: false,
        friendEmails: []));
  }

  void rebuildTest() {
    emit(CreateGroupState(friends: state.friends, choosenFriendsHeight: 64.0));
  }

  void createGroupChat(String grpName, BuildContext context) async {
    var user = await firebaseManager.getCurrentUser();
    final _firestore = FirebaseFirestore.instance;
    // should emit state lol
    var chat =
        _firestore.collection('Chats').orderBy('id', descending: true).limit(1);
    var chatRef = await chat.get();
    var chatID;
    for (var snapshot in chatRef.docs) {
      chatID = snapshot.get('id');
    }
    chatID++;
    List<Widget> currentFriends = state.friends;
    List<String>? currentFriendEmails = state.friendEmails;
    // emit(CreateGroupState(
    //     friends: currentFriends,
    //     choosenFriendsHeight: 64.0,
    //     activeNext: true,
    //     friendEmails: currentFriendEmails));
    //
    currentFriendEmails?.add(user!.email);
    _firestore.collection('Chats').add({
      'id': chatID,
      'name': grpName,
      'type': 'gc',
      'users': currentFriendEmails,
    });
    //createChat = false;
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
}
