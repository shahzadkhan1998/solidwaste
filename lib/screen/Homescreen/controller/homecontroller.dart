import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;
  var title;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    checkData();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkData();
  }

  ////////// check data as exist or not if not then ......
  checkData() {
    FirebaseFirestore.instance
        .collection('complaint')
        .doc(user!.email)
        .collection("complaint")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["title"]);

        title = doc["title"];
      });
    });
  }
}
