import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_flutter/presentation layer/screens/chat_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _firestore = FirebaseFirestore.instance;
final scrollController = ScrollController();

class ChatHolderNew extends StatefulWidget {
  ChatHolderNew({this.chatName, this.chatID, this.isCurrentUser});
  final String? chatName;
  final String? chatID;
  final bool? isCurrentUser;

  @override
  State<ChatHolderNew> createState() => _ChatHolderNewState();
}

class _ChatHolderNewState extends State<ChatHolderNew> {
  bool loaded = false;
  Future getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 2));
  }

  var textTest;

  void getChatTexts() async {
    var getChatID = _firestore.collection('Chats').orderBy('id').limit(1);
    final chats = await getChatID.get();
    var chatIDnew;
    for (var chat in chats.docs) {
      chatIDnew = chat.id;
    }
    var chatTexts = _firestore
        .collection('Chats')
        .doc(widget.chatID)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1);
    var chatTextsRef = await chatTexts.get();
    for (var snapshot in chatTextsRef.docs) {
      setState(() {
        textTest = snapshot.get('text');
        loaded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getChatTexts();
      print(textTest);
    });
  }

  @override
  Widget build(BuildContext context) {
    //String? lastText = Provider.of<LastText>(context).lastText;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, ChatScreen.id,
              //     arguments: widget.chatID);
              //print(widget.chatID);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChatScreen(
                      chatID: widget.chatID,
                    );
                  },
                ),
              );

              //print(lastText);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                color: Color(0xFFF7F7F7),
              )),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                elevation: 0.6,
                color: Colors
                    .white, //isCurrentUser! ? Colors.green : Colors.green,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Center(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: CircleAvatar(
                            radius: 23,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage('images/EmptyProfile.png'),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  widget.chatName!,
                                  style: TextStyle(
                                    //color: Colors.black54,
                                    color: Color(0xFF595959),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text(
                                  loaded ? textTest : '',
                                  style: TextStyle(
                                    //color: Colors.black54,
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: GestureDetector(
                            onTap: () {
                              _firestore
                                  .collection('Chats')
                                  .doc(widget.chatID)
                                  .delete();
                            },
                            child: Icon(
                              FontAwesomeIcons.solidTrashCan,
                              //color: Color(0xFFD4D4D4),
                              color: Color(0xFF595959),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
