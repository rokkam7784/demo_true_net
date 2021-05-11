import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  getUserByUsername(String username) async {
    // return await FirebaseFirestore.instance
    //     .collection("users")
    //     .where("name", isEqualTo: username)
    //     .get();

    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username);
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap).catchError((e) {
      print(e.toString());
    });
  }
}
