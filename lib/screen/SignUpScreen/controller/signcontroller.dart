import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:solidwaste/screen/Homescreen/view/homescreen.dart';

class SignUpController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  createAccount() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text,
        password: passcontroller.text,
      );
      await addToFireStore();

      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          Get.to(() => HomeScreen());
          print('User is signed in!');
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Fluttertoast.showToast(msg: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Fluttertoast.showToast(
            msg: "The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }

  addToFireStore() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users.doc(emailcontroller.text).collection("users").add({
      'firstName': namecontroller.text,
      'lastName': "user",
      "email": emailcontroller.text,
      "password": passcontroller.text,
      "type": "user",
      "date": DateTime.now(),
    }).whenComplete(() => {
          FirebaseFirestore.instance
              .collection('users')
              .doc(emailcontroller.text)
              .set({
            "email": emailcontroller.text,
          })
        });
  }
}
