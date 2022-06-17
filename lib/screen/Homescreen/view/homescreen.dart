import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:solidwaste/screen/Complaintscreen/view/complaintscreen.dart';
import 'package:solidwaste/screen/ReviewScreen/view/reviewscreen.dart';

import '../../LastComplaint/view/lastcomplaint.dart';
import '../../LoginScreen/view/loginscreen.dart';
import '../controller/homecontroller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final homecontroller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    String url = "images/any.jpg";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Home",
          style: GoogleFonts.montserrat(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Get.to(() => LoginScreen());
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
        // leading: IconButton(
        //   onPressed: () {
        //
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back,
        //     color: Colors.black,
        //   ),
        // ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 300,
              width: Get.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: url != null
                  ? Material(
                      elevation: 5,
                      child: Image.asset(
                        "images/any.jpg",
                        filterQuality: FilterQuality.low,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const CircularProgressIndicator.adaptive(),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (homecontroller.title != null) {
                      Get.to(() => LastCpmplaint());
                    } else {
                      Get.to(
                          () => ComplaintScreen(
                                title: 'Solid-Waste',
                              ),
                          arguments: ["title", "Solid-Waste"],
                          transition: Transition.leftToRightWithFade,
                          duration: Duration(seconds: 1));
                    }
                  },
                  child: Column(
                    children: [
                      Material(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 150,
                          height: 150,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage("images/solid.png"),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      Material(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "Solid Waste",
                            style: GoogleFonts.actor(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (homecontroller.title != null) {
                      Get.to(() => LastCpmplaint());
                    } else {
                      Get.to(
                          () => ComplaintScreen(
                                title: 'Drainage',
                              ),
                          arguments: ["title", "Drainage"],
                          transition: Transition.circularReveal,
                          duration: Duration(seconds: 1));
                    }
                  },
                  child: Column(
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          width: 150,
                          height: 150,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage("images/drainage.png"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Drainage",
                          style: GoogleFonts.actor(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (homecontroller.title != null) {
                      Get.to(() => LastCpmplaint());
                    } else {
                      Get.to(
                          () => ComplaintScreen(
                                title: 'Dist-bin',
                              ),
                          arguments: ["title", "Dist-bin"],
                          transition: Transition.zoom,
                          duration: Duration(seconds: 1));
                    }
                  },
                  child: Column(
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 150,
                          height: 150,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage("images/dis.png"),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Dist-bin",
                          style: GoogleFonts.actor(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (homecontroller.title != null) {
                      Get.to(() => LastCpmplaint());
                    } else {
                      Get.to(
                          () => ComplaintScreen(
                                title: 'Other',
                              ),
                          arguments: ["title", "Other"],
                          transition: Transition.size,
                          duration: Duration(seconds: 1));
                    }
                  },
                  child: Column(
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 150,
                          height: 150,
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/other.png"))),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Other",
                          style: GoogleFonts.actor(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => ReviewScreen());
        },
        child: const Icon(
          Icons.reviews,
          color: Colors.white,
          size: 29,
        ),
        backgroundColor: Colors.black,
        tooltip: 'Review Complaint',
        elevation: 5,
        splashColor: Colors.grey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
