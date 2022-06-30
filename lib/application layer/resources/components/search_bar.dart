import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flash_chat_flutter/application layer/resources/constants.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Icon(
            FontAwesomeIcons.magnifyingGlass,
            //color: Color(0xFFD4D4D4),
            color: Color(0xFF595959),
          ),
        ),
        Flexible(
          child: TextField(
            //textAlign: TextAlign.center,
            onChanged: (value) {
              //Do something with the user input.
              //email = value;
            },
            style: TextStyle(
                //color: Color(0xFFD4D4D4),
                color: Color(0xFF595959)),
            decoration: kTextFieldDecoration.copyWith(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                hintStyle: TextStyle(
                    //color: Color(0xFFB8B8B8),
                    color: Color(0xFF595959)),
                hintText: 'Search chat...'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
