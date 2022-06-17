import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class lastcomplaint extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;
  var image;
  var phone;
  var location;
  var status;
  var description;
  var title;
  var time;
  var email;
  var name;
  var type;
  DateTime? date;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getimage();
    GetuSerInfo();
  }

  getimage() {
    FirebaseFirestore.instance
        .collection('complaint')
        .doc(user!.email)
        .collection("complaint")
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        print(doc["image"]);
        image = doc["image"];
        phone = doc["phone"];
        time = (doc['time'] as Timestamp).toDate();
        title = doc["title"];
        description = doc["description"];
        location = doc["location"];
        status = doc["status"];
        date = (doc['date'] as Timestamp).toDate();
        type = doc["type"];
        print("$date");
        update();
      }
      update();
    });
    update();
  }

  GetuSerInfo() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .collection("users")
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        print(doc["email"]);
        email = doc["email"];
        name = doc["firstName"];
        update();
      }
      update();
    });
    update();
  }
}
