import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// AppBar widget function
Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Row(
      children: [
        Image.asset(
          "Assets/Images/TrueLogo.jpeg",
          height: 70,
        ),
        SizedBox(
          width: 50,
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
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextStyle() {
  return GoogleFonts.cagliostro(color: Colors.yellow, fontSize: 25);
}
