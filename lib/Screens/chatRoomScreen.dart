import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:true_net/Screens/groupChatScreen.dart';
import 'package:true_net/Screens/search.dart';
import 'package:true_net/Screens/signin.dart';
import 'package:true_net/Services/auth.dart';
import 'package:true_net/Widgets/Widget.dart';
import 'package:true_net/helper/authenticate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();

  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  final _firestore = FirebaseFirestore.instance;
  String messageText;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "Assets/Images/TrueLogo.jpeg",
              height: 70,
            ),
            // SizedBox(
            //   width: 50,
            // ),
            Text(
              "T.R.U.E",
              style: GoogleFonts.pacifico(
                  color: Colors.yellow, letterSpacing: 4.0, fontSize: 30),
            )
          ],
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => SignIn()));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.exit_to_app,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Wrap(
        children: [
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GroupChatScreen()));
            },
            child: Expanded(
              child: Container(
                margin: EdgeInsets.all(7),
                color: Colors.yellow[400],
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Icon(
                          Icons.group_rounded,
                          color: Colors.yellow,
                          size: 40,
                        ),
                        radius: 30,
                        backgroundColor: Colors.black,
                      ),
                      Text(
                        "  T.R.U.E  SERVER",
                        style: GoogleFonts.libreBaskerville(
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        child: Icon(
          Icons.person_search,
          color: Colors.black,
          size: 35,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
      ),
    );
  }
}
