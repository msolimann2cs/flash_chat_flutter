import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class CreateGroupState extends Equatable {
  CreateGroupState({required this.friends, this.choosenFriendsHeight});
  List<Widget> friends;
  var choosenFriendsHeight;

  @override
  // TODO: implement props
  List<Object?> get props => [friends, choosenFriendsHeight];

  // @override
  // // TODO: implement props
  // List<Object?> get props => throw UnimplementedError();
  // //bool friendCardChoosen
}
