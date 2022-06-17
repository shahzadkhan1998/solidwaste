import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Homescreen/view/homescreen.dart';

class LoginController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  var email;
  var password;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getToken();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getCloudData();
  }

  SignInWithEmail() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailcontroller.text, password: passcontroller.text);
      await checkData();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Fluttertoast.showToast(msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Fluttertoast.showToast(msg: "No user found for that email.");
      }
    }
  }

  ////////////////// data come from Cloud firebase Store ////////////////////

  getCloudData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .collection("users")
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        print(doc["email"]);

        email = doc["email"];
        password = doc["password"];
        print(email);
        print(password);
      }
    });
  }

  /////////////////  check data as its exist or not ///////////////
  checkData() {
    if (emailcontroller.text == email) {
      if (passcontroller.text == password) {
        Get.off(() => HomeScreen());
      }
    } else {
      Fluttertoast.showToast(msg: "Check Your Email and Password");
    }
  }

  checkvalidation() async {
    if (emailcontroller.text.isEmpty) {
      Get.snackbar("Alert", "Email is not empty");
    }
    if (!GetUtils.isEmail(emailcontroller.text)) {
      Get.snackbar("Alert", "Email is not Valid");
    }

    if (passcontroller.text.isEmpty) {
      Get.snackbar("Alert", "password should not empty");
    }
    if (passcontroller.text.length < 3) {
      Get.snackbar("Alert", "Password is not Valid",
          progressIndicatorBackgroundColor: Colors.grey);
    }
    if (passcontroller.text != null) {
      if (emailcontroller.text != null) {
        SignInWithEmail();
      }
    }
  }

  var token;
  getToken() async {
    token = await FirebaseAuth.instance.currentUser?.getIdToken();
    print(token);
    if (token != null) {
      Get.off(() => HomeScreen());
    } else {
      Fluttertoast.showToast(msg: "Welcome to Our App");
    }
  }
}
