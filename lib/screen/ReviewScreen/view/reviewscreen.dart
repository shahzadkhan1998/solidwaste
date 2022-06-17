import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solidwaste/screen/Homescreen/view/homescreen.dart';

class ReviewScreen extends StatelessWidget {
  ReviewScreen({Key? key}) : super(key: key);
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "ReviewScreen",
          style: GoogleFonts.montserrat(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.to(() => HomeScreen());
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("complaint")
              .doc(user!.email)
              .collection("complaint")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var images = snapshot.data!.docs[index]["image"];
                var title = snapshot.data!.docs[index]["title"];
                var description = snapshot.data!.docs[index]["description"];
                var status = snapshot.data!.docs[index]["status"];
                return ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(5),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(images.toString()),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  title: Text(
                    title.toString(),
                    style: GoogleFonts.montserrat(),
                  ),
                  subtitle: Text(
                    description.toString(),
                    style: GoogleFonts.montserrat(),
                  ),
                  trailing: Text(
                    status.toString(),
                    style: GoogleFonts.montserrat(),
                  ),
                );
              },
            );
          }),
    );
  }
}
