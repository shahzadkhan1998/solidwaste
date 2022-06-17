import 'package:cached_network_image/cached_network_image.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:solidwaste/screen/Complaintscreen/view/complaintscreen.dart';
import 'package:solidwaste/screen/Homescreen/view/homescreen.dart';
import 'package:solidwaste/screen/LastComplaint/controller/lastcomplaint.dart';
import 'package:solidwaste/screen/ReviewScreen/view/reviewscreen.dart';

import '../../../component/imageget.dart';

class LastCpmplaint extends StatelessWidget {
  LastCpmplaint({Key? key}) : super(key: key);
  final _lastcomplaintcontroller = Get.put(lastcomplaint());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Last Complaint",
          style: GoogleFonts.montserrat(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: GetBuilder<lastcomplaint>(
        builder: (logic) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Last Complaint",
                  style: GoogleFonts.montserrat(),
                ),
                Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _lastcomplaintcontroller.image != null
                        ? CachedNetworkImage(
                            imageUrl: _lastcomplaintcontroller.image,
                            height: 300,
                            width: Get.height,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )
                        : Image.asset("images/any.jpg"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "${logic.email ?? "No Data"}",
                      style: GoogleFonts.montserrat(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "${logic.name ?? "No Data"}",
                      style: GoogleFonts.montserrat(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "${logic.phone ?? "No Data"}",
                      style: GoogleFonts.montserrat(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "${logic.date! ?? "No Data"}",
                      style: GoogleFonts.montserrat(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "${logic.time ?? "No Data"}",
                      style: GoogleFonts.montserrat(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "${logic.title ?? "No Data"}",
                      style: GoogleFonts.montserrat(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "${logic.description ?? "NO Data"}",
                      style: GoogleFonts.montserrat(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "${logic.status ?? "No Data"}",
                      style: GoogleFonts.montserrat(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "${logic.type ?? "No Data"}",
                      style: GoogleFonts.montserrat(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FabCircularMenu(
        children: <Widget>[
          Wrap(
            children: [
              Center(
                child: IconButton(
                    icon: const Icon(
                      Icons.home_work,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Get.to(() => HomeScreen());
                    }),
              ),
              Center(
                child: Text(
                  "Home",
                  style: GoogleFonts.montserrat(color: Colors.white),
                ),
              ),
            ],
          ),
          Wrap(
            children: [
              Center(
                child: IconButton(
                    icon: const Icon(
                      Icons.message_sharp,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Get.to(() => ComplaintScreen(
                            title: "",
                          ));
                    }),
              ),
              Center(
                child: Text(
                  "Complaint",
                  style: GoogleFonts.montserrat(color: Colors.white),
                ),
              ),
            ],
          ),
          Wrap(
            children: [
              Center(
                child: IconButton(
                    icon: const Icon(
                      Icons.reviews,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Get.to(() => ReviewScreen());
                    }),
              ),
              Center(
                child: Text(
                  "Feedback",
                  style: GoogleFonts.montserrat(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
