// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as Path;

class complaintcontroller extends GetxController {
  XFile? images;
  File? selectedimage;
  String? downloadedimage;
  SharedPreferences? prefs;
  var cloudimage;

  dynamic argumentData = Get.arguments;
  var pretitle;

  User? user = FirebaseAuth.instance.currentUser;

  ////////   Editext ////////////////////////////////////////
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController type = TextEditingController();
/////////////////////////////////////////////////////////

  ///////////////////////////////////////////
////// get image from camera /////

  File? image;
  String? imagePath;
  final _picker = ImagePicker();
  double? progress;

  Future<void> getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      imagePath = pickedFile.path;
      print(imagePath);
    } else {
      print('No image selected.');
    }

    update();

    await uploadImageOfDescription();
  }

/////////////////// upload to firebaseStroge Description image  /////////////////////////////////
  uploadImageOfDescription() async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child("Images")
        .child(Path.basename(image!.path));
    UploadTask uploadTask = reference.putFile(image!);
    uploadTask.snapshotEvents.listen((event) {
      progress =
          event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
      print(progress.toString());

      if (event.state == TaskState.success) {
        progress = null;
        Fluttertoast.showToast(msg: 'File added to the library');
        update();
      }
      update();
    }).onError((error) {
      // do something to handle error
    });
    uploadTask.whenComplete(() async {
      try {
        print("Image Added Completed ");
        downloadedimage = await reference.getDownloadURL();
        // addUser();
      } catch (onError) {
        print("Error  $onError");
      }

      print(downloadedimage);
      update();
    });
    update();
  }

  ////////////////////// call current user //////////////////////////////////////////
  var name;
  var email;
  callingCurrentUser() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .collection("users")
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        print(doc["email"]);
        name = doc["firstName"];
        email = doc["email"];
        print(doc["firstName"]);
      }
    });
  }
  ///////////////////////////////////////// Add All Data from cloud firestore /////////////////

  CollectionReference users =
      FirebaseFirestore.instance.collection('complaint');

  Future<void> AddAllData() {
    // Call the user's CollectionReference to add a new user
    return users.doc(user!.email).collection("complaint").add({
      'title': title.text, // John Doe
      'description': description.text, // Stokes and Sons
      'location': location.text,
      'phone': phone.text,
      "date": DateTime.now(),
      'time': DateTime.now(),
      "status": "pending",
      "image": downloadedimage,
      "goolelocation": Address,
      "lat": lat,
      'long': lang,
      "email": email,
      'name': name,
      "type": pretitle ?? type.text,

      // 42
    }).then((value) {
      FirebaseFirestore.instance
          .collection("complaint")
          .doc(user!.email)
          .set({"email": user!.email});
      print("Complaint Added completed : $value");
      datafound = value as String;
    }).catchError((error) => print("Failed to add user: $error"));
  }
  //// data found then go to other screen //////////

  var datafound = '';

  ////////////////////////////////////
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    callingCurrentUser();
    if (Get.arguments != null) {
      pretitle = Get.arguments[1];
    } else {
      Fluttertoast.showToast(msg: "No Type");
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    callfunction();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
    description.dispose();
    location.dispose();
    phone.dispose();
    type.dispose();
  }

  ////////
  var lat;
  var lang;
  callfunction() async {
    Position position = await _getGeoLocationPosition();
    GetAddressFromLatLong(position);
    if (place != null) {
      var local = place!.locality;
      print(local);
    }
  }

  //////////////////////////////////////// Google map  ///////////////////////

  ////////////////////// variable use for location ///////////////////////
  String Address = 'search';
  String locations = 'Null, Press Button';

/////////////////////// get permission /////////////////////////////////////////////
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Placemark? place;
//////////////////////////***************** function which is required for get current User **************//////////////////////
  Future<void> GetAddressFromLatLong(Position position) async {
    print("Iam clicked");
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    place = placemarks[0];
    Address =
        '${place!.street}, ${place!.subLocality}, ${place!.locality}, ${place!.postalCode}, ${place!.country}';
    print("Adress is .......... :$Address");
    lat = position.latitude;
    print("$lat");

    lang = position.longitude;
    print("$lang");
    update();
  }

  //////////////////

}
