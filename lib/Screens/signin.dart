import 'package:flutter/material.dart';
import 'package:true_net/Screens/chatRoomScreen.dart';
import 'package:true_net/Screens/signup.dart';
import 'package:true_net/Widgets/Widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:true_net/helper/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignIn extends StatefulWidget {
  // final Function toggleView;
  //
  // SignIn(this.toggleView);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "Assets/Images/TrueNetSlightBlack.jpeg",
                  height: 170,
                ),
                // Email-ID text input
                SizedBox(
                  height: 15,
                ),
                //Email
                TextFormField(
                  style: simpleTextStyle(),
                  // controller: emailTextEditingController,
                  validator: (val) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val)
                        ? null
                        : "Enter correct email";
                  },
                  decoration: textFieldInputDecoration("Email"),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                //password
                TextFormField(
                  obscureText: true,
                  style: simpleTextStyle(),
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: textFieldInputDecoration("Password"),
                  // controller: passwordTextEditingController,
                  validator: (val) {
                    return val.length < 6
                        ? "Enter Password 6+ characters"
                        : null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                // forget Password
                Container(
                  padding: EdgeInsets.only(left: 190, bottom: 15),
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(color: Colors.white54, fontSize: 15),
                  ),
                ),
                //Sigh in
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);

                      if (user != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatRoom()));
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFFFD600),
                            const Color(0xFFFFD59D),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Sign In",
                      style: GoogleFonts.cagliostro(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // Google sigh in
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF9E9E9E),
                          const Color(0xFFFAFAFA),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Sign In with Google",
                    style: GoogleFonts.cagliostro(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            " Register Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
