import 'package:flash_chat_flutter/bloc/data_provider/main_screen_provider.dart';
import 'package:flash_chat_flutter/bloc/model/MainScreenState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flash_chat_flutter/presentation%20layer/screens/create_chat.dart';
import 'package:flash_chat_flutter/presentation%20layer/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flash_chat_flutter/application layer/resources/components/search_bar.dart';
import 'package:flash_chat_flutter/application layer/resources/color_manager.dart';
import 'package:flash_chat_flutter/application layer/resources/components/bottom_bar.dart';
import 'package:flash_chat_flutter/application layer/resources/components/private_chat_stream.dart';
import 'package:flash_chat_flutter/application layer/resources/components/group_chat_stream.dart';

ColorManager colorManager = ColorManager();

class MainScreen extends StatefulWidget {
  static String id = 'main_screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Color activeChatTabColor = colorManager.primaryColor;
  Color inactiveChatTabColor = colorManager.secondaryColor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainScreenProvider>(
      create: (context) => MainScreenProvider(),
      child: Scaffold(
        //backgroundColor: Color(0xFFF7F7F7),
        backgroundColor: Colors.white,
        body: BlocBuilder<MainScreenProvider, MainScreenState>(
            builder: (context, state) {
          return SafeArea(
            child: ModalProgressHUD(
              inAsyncCall: state.showSpinner!,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            height: 50,
                            child: SearchBar(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            height: 50,
                            child: GestureDetector(
                              onTap: () {
                                //Navigator.pushNamed(context, CreateChat.id);
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) => CreateChat());
                              },
                              child: Icon(FontAwesomeIcons.penToSquare,
                                  //color: Color(0xFFD4D4D4),
                                  color: Color(0xFF595959)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<MainScreenProvider>(context)
                              .changeToPrivateChat();
                          //state.privateChat = true;
                          // setState(() {
                          //   privateChat = true;
                          // });
                        },
                        child: Column(
                          children: [
                            Text(
                              'Chats',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: state.privateChat!
                                    ? activeChatTabColor
                                    : inactiveChatTabColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: SizedBox(
                                height: 1,
                                width: 150,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: state.privateChat!
                                        ? activeChatTabColor
                                        : inactiveChatTabColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<MainScreenProvider>(context)
                              .changeToGroupChat();
                          //print(state.privateChat);
                          //state.privateChat = false;
                          // setState(() {
                          //   privateChat = false;
                          // });
                        },
                        child: Column(
                          children: [
                            Text(
                              'Groups',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: state.privateChat!
                                    ? inactiveChatTabColor
                                    : activeChatTabColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: SizedBox(
                                height: 1,
                                width: 150,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: state.privateChat!
                                        ? inactiveChatTabColor
                                        : activeChatTabColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  state.privateChat! ? PrivateChatStream() : GroupChatStream(),
                  Container(
                    //width: 100,
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
                    child: BottomBar(
                      nextPageID: ProfilePage.id,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
