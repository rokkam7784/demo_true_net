import 'package:firebase_auth/firebase_auth.dart';
import 'package:true_net/Modal/user.dart';

class AuthMethods {
  // creating an instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // defining the datatype of the argument what we will be recieving
  appUser _userFromFireBaseUser(User user) {
    return user != null ? appUser(userId: user.uid) : null;
  }

  Future sighInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFireBaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future sighUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFireBaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
