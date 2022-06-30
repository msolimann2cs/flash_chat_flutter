import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flash_chat_flutter/application layer/resources/constants.dart';

class BottomBar extends StatelessWidget {
  BottomBar({this.nextPageID});

  var nextPageID;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Icon(
                Ionicons.call_outline,
                size: 33,
                //color: Color(0xFFD4D4D4),
                color: Color(0xFF595959),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 1),
              child: Text(
                'Calls',
                style: TextStyle(fontSize: 11),
              ),
            )
          ],
        ),
        Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Icon(
                Ionicons.chatbubbles_outline,
                size: 32,
                color: Color(0xDD9DCAEB),
                //color: Color(0xFF595959),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2, top: 2),
              child: Text(
                'Chats',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF8CB9DA),
                ),
              ),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Icon(
                Ionicons.people_outline,
                size: 38,
                color: Color(0xFF595959),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.5),
              child: Text(
                'Friends',
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, nextPageID); //ProfilePage.id
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Icon(
                  Ionicons.person_outline,
                  //color: Color(0xFFD4D4D4),
                  size: 32,
                  color: Color(0xFF595959),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
