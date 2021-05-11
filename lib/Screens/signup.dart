import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:true_net/Screens/chatRoomScreen.dart';
import 'package:true_net/Screens/signin.dart';
import 'package:true_net/Services/auth.dart';
import 'package:true_net/Widgets/Widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:true_net/Services/database.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUp extends StatefulWidget {
  // final Function toggleView;

  // SignUp(this.toggleView);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool showSpinner = false;

  final formKey = GlobalKey<FormState>();

  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  bool isLoading = false;
  String kUserName = "";

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethod databaseMethod = new DatabaseMethod();

  // For showing some loading options
  sighMeUp() {
    if (formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "name": userNameTextEditingController.text,
        "email": emailTextEditingController.text,
      };

      setState(() {
        isLoading = true;
      });

      authMethods
          .sighUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then(
            (value) => print(value.uid),
          );

      databaseMethod.uploadUserInfo(userInfoMap);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ChatRoom()));
    }
    showSpinner = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: Colors.yellow,
        child: isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.yellow),
                    // backgroundColor: Colors.black,
                  ),
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height - 100,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Logo
                      Image.asset(
                        "Assets/Images/TrueNetSlightBlack.jpeg",
                        height: 170,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            // userName
                            TextFormField(
                              style: simpleTextStyle(),
                              controller: userNameTextEditingController,
                              validator: (val) {
                                //TODO
                                Constants.myName = val;
                                return val.isEmpty || val.length < 3
                                    ? "Enter Username 3+ characters"
                                    : null;
                              },
                              decoration: textFieldInputDecoration("Username"),
                            ),
                            //Email
                            TextFormField(
                              style: simpleTextStyle(),
                              controller: emailTextEditingController,
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val)
                                    ? null
                                    : "Enter correct email";
                              },
                              decoration: textFieldInputDecoration("Email"),
                            ),
                            //password
                            TextFormField(
                              obscureText: true,
                              style: simpleTextStyle(),
                              decoration: textFieldInputDecoration("Password"),
                              controller: passwordTextEditingController,
                              validator: (val) {
                                return val.length < 6
                                    ? "Enter Password 6+ characters"
                                    : null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //Sigh up
                      GestureDetector(
                        onTap: () {
                          //TODO

                          setState(() {
                            showSpinner = true;
                          });
                          sighMeUp();
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
                            "Sign Up",
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
                      // Google sign up
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
                          "Sign Up with Google",
                          style: GoogleFonts.cagliostro(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account ?",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text("Sign In Now",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      decoration: TextDecoration.underline)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class Constants {
  static String myName = "";
}
