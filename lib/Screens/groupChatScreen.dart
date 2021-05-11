import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:true_net/Screens/chatRoomScreen.dart';
import 'signup.dart';

class GroupChatScreen extends StatefulWidget {
  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  String messageText;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          // IconButton(
          //     icon: Icon(
          //       Icons.close,
          //       color: Colors.black,
          //       size: 30,
          //     ),
          //     onPressed: () {
          //       //Implement logout functionality
          //       Navigator.pop(context);
          //     }),
        ],
        title: Text(
          "  T.R.U.E  SERVER",
          style: GoogleFonts.libreBaskerville(
              color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.yellow[400],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.limeAccent, fontSize: 20),
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //Implgit initement send functionality.
                      _firestore.collection('groupMsg').add(
                          {'text': messageText, 'sender': loggedInUser.email});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const kSendButtonTextStyle = TextStyle(
  color: Colors.amber,
  fontWeight: FontWeight.bold,
  fontSize: 25.0,
);

const kMessageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: 'Type your message here...',
    border: InputBorder.none,
    hintStyle: TextStyle(color: Colors.limeAccent, fontSize: 20));

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);
