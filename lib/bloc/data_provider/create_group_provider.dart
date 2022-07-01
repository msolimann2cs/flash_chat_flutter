import 'package:flash_chat_flutter/bloc/model/create_group_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGroupProvider extends Cubit<CreateGroupState> {
  CreateGroupProvider()
      : super(CreateGroupState(friends: [], choosenFriendsHeight: 0.0));

  // TODO: implement props
  void addChoosenFriend(List<Widget> list) {
    // List<Widget> addedFriends = state.friends!;
    // addedFriends.add(widget);
    if (state.choosenFriendsHeight == 0) {
      emit(CreateGroupState(friends: list, choosenFriendsHeight: 64.0));
    } else if (state.choosenFriendsHeight == 64) {
      emit(CreateGroupState(friends: list, choosenFriendsHeight: 63.0));
    } else if (state.choosenFriendsHeight == 63) {
      emit(CreateGroupState(friends: list, choosenFriendsHeight: 64.0));
    }
    //emit(CreateGroupState(friends: list, choosenFriendsHeight: 63.0));
    //emit(CreateGroupState(friends: list, choosenFriendsHeight: 64.0));
  }

  void removeChoosenFriend(List<Widget> list) {
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
      emit(CreateGroupState(friends: list, choosenFriendsHeight: 64.0));
    } else if (state.choosenFriendsHeight == 64) {
      emit(CreateGroupState(friends: list, choosenFriendsHeight: 63.0));
    } else if (state.choosenFriendsHeight == 63) {
      emit(CreateGroupState(friends: list, choosenFriendsHeight: 64.0));
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
    emit(CreateGroupState(friends: [], choosenFriendsHeight: 0.0));
  }

  void rebuildTest() {
    emit(CreateGroupState(friends: state.friends, choosenFriendsHeight: 64.0));
  }
}
