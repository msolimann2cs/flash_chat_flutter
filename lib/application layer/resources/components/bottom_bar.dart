import 'package:flash_chat_flutter/bloc/data_provider/bottom_bar_provider.dart';
import 'package:flash_chat_flutter/bloc/model/bottom_bar_state.dart';
import 'package:flash_chat_flutter/presentation%20layer/screens/friends_screen.dart';
import 'package:flash_chat_flutter/presentation%20layer/screens/main_screen.dart';
import 'package:flash_chat_flutter/presentation%20layer/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flash_chat_flutter/application layer/resources/constants.dart';

class BottomBar extends StatelessWidget {
  BottomBar();
  //var pageID;
  //var nextPageID;
  // Color callsColor = Color(0xFF595959);
  // Color chatsColor = Color(0xDD9DCAEB);
  // Color friendsColor = Color(0xFF595959);
  // Color profileColor = Color(0xFF595959);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarProvider, BottomBarState>(
        builder: (context, state) {
      return Container(
        height: 55,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Color(0xFFD4D4D4),
            ),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Column(
            //   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(top: 4.0),
            //       child: Icon(
            //         Ionicons.call_outline,
            //         size: 33,
            //         //color: Color(0xFFD4D4D4),
            //         color: state.callsColor,
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(left: 5, top: 1),
            //       child: Text(
            //         'Calls',
            //         style: TextStyle(fontSize: 11, color: state.callsColor),
            //       ),
            //     )
            //   ],
            // ),
            GestureDetector(
              onTap: () {
                // friendsColor = Color(0xFF595959);
                // callsColor = Color(0xFF595959);
                // chatsColor = Color(0xDD9DCAEB);
                // profileColor = Color(0xFF595959);
                BlocProvider.of<BottomBarProvider>(context).changeColors(
                    Color(0xFF595959),
                    Color(0xDD9DCAEB),
                    Color(0xFF595959),
                    Color(0xFF595959));
                //Navigator.pushNamed(context, MainScreen.id);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<BottomBarProvider>(context),
                          child: MainScreen(),
                        )));
              },
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Icon(
                      Ionicons.chatbubbles_outline,
                      size: 32,
                      color: state.chatsColor,
                      //color: Color(0xFF595959),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2, top: 2),
                    child: Text(
                      'Chats',
                      style: TextStyle(
                        fontSize: 11,
                        color: state.chatsColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                BlocProvider.of<BottomBarProvider>(context).changeColors(
                    Color(0xFF595959),
                    Color(0xFF595959),
                    Color(0xDD9DCAEB),
                    Color(0xFF595959));
                //Navigator.pushNamed(context, FriendsScreen.id);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<BottomBarProvider>(context),
                          child: FriendsScreen(),
                        )));
                // friendsColor = Color(0xDD9DCAEB);
                // callsColor = Color(0xFF595959);
                // chatsColor = Color(0xFF595959);
                // profileColor = Color(0xFF595959);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Icon(
                      Ionicons.people_outline,
                      size: 38,
                      color: state.friendsColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.5),
                    child: Text(
                      'Friends',
                      style: TextStyle(fontSize: 11, color: state.friendsColor),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // friendsColor = Color(0xFF595959);
                // callsColor = Color(0xFF595959);
                // chatsColor = Color(0xFF595959);
                // profileColor = Color(0xDD9DCAEB);
                BlocProvider.of<BottomBarProvider>(context).changeColors(
                    Color(0xFF595959),
                    Color(0xFF595959),
                    Color(0xFF595959),
                    Color(0xDD9DCAEB));
                //Navigator.pushNamed(context, ProfilePage.id); //ProfilePage.id
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<BottomBarProvider>(context),
                          child: ProfilePage(),
                        )));
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
                      color: state.profileColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      'Profile',
                      style: TextStyle(fontSize: 11, color: state.profileColor),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
