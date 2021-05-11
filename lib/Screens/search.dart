import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:true_net/Services/database.dart';
import 'package:true_net/Widgets/Widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethod databaseMethod = new DatabaseMethod();

  TextEditingController searchTextEditingController =
      new TextEditingController();

  QuerySnapshot searchSnapshot;

  initiateSearch() {
    databaseMethod
        .getUserByUsername(searchTextEditingController.text)
        .then((val) {
      searchSnapshot = val;
    });
  }

  Widget searchList() {
    return ListView.builder(
      // itemCount: searchSnapshot.documents.length,
      itemBuilder: (context, index) {
        return SearchTile(
          userName: "",
          userEmail: "",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              "Assets/Images/TrueLogo.jpeg",
              height: 70,
            ),
            SizedBox(
              width: 30,
            ),
            Text(
              "T.R.U.E",
              style: GoogleFonts.pacifico(
                  color: Colors.yellow, letterSpacing: 4.0, fontSize: 30),
            )
          ],
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            height: 50,
            color: Color(0x33FFFFFF),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: TextField(
                  controller: searchTextEditingController,
                  style: TextStyle(color: Colors.yellow),
                  decoration: InputDecoration(
                      hintText: "Search Username ",
                      hintStyle: TextStyle(color: Colors.yellow[200])),
                )),
                GestureDetector(
                  onTap: () {
                    initiateSearch();
                  },
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Icon(
                      Icons.search,
                      color: Colors.yellow,
                      size: 38,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  final String userName;
  final String userEmail;
  SearchTile({this.userName, this.userEmail});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Text(
                userName,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                userEmail,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
                color: Colors.yellow, borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Text(
              "Message",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
