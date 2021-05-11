import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:true_net/Screens/chatRoomScreen.dart';
import 'package:true_net/Screens/signin.dart';
import 'package:true_net/Screens/signup.dart';
import 'package:true_net/helper/authenticate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF1D1C1D),
        primarySwatch: Colors.blue,
      ),
      home: ChatRoom(),
    );
  }
}
