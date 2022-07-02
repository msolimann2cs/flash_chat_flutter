import 'package:flash_chat_flutter/bloc/model/bottom_bar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class BottomBarProvider extends Cubit<BottomBarState> {
  BottomBarProvider()
      : super(BottomBarState(
            callsColor: Color(0xFF595959),
            chatsColor: Color(0xDD9DCAEB),
            friendsColor: Color(0xFF595959),
            profileColor: Color(0xFF595959)));
  void changeColors(Color calls, Color chats, Color friends, Color profile) {
    emit(BottomBarState(
        callsColor: calls,
        chatsColor: chats,
        friendsColor: friends,
        profileColor: profile));
  }
}
