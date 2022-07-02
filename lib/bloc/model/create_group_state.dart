import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class CreateGroupState extends Equatable {
  CreateGroupState(
      {required this.friends,
      this.choosenFriendsHeight,
      this.activeNext,
      this.friendEmails});
  List<Widget> friends;
  List<String>? friendEmails;
  var choosenFriendsHeight;
  bool? activeNext;

  @override
  // TODO: implement props
  List<Object?> get props =>
      [friends, choosenFriendsHeight, activeNext, friendEmails];

  // @override
  // // TODO: implement props
  // List<Object?> get props => throw UnimplementedError();
  // //bool friendCardChoosen
}
