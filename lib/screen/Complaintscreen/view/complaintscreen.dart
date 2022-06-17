import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solidwaste/screen/Homescreen/view/homescreen.dart';
import 'package:solidwaste/screen/ReviewScreen/view/reviewscreen.dart';

import '../../../component/imageget.dart';
import '../controller/complaintcontroller.dart';

class ComplaintScreen extends StatelessWidget {
  ComplaintScreen({Key? key, required this.title}) : super(key: key);
  String url = "images/any.jpg";
  bool isVisible = true;
  final String title;

  final _complaintcontroller = Get.put(complaintcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Complaint",
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
      body: GetBuilder<complaintcontroller>(builder: (logic) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Complaint Now",
                  style: GoogleFonts.montserrat(color: Colors.black),
                ),
              ),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    height: 250,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: logic.image != null
                        ? Container(
                            padding: const EdgeInsets.all(10),
                            child: Image.file(
                              logic.image!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset("images/download.png")),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  keyboardType: TextInputType.name,
                  controller: _complaintcontroller.title,
                  decoration: InputDecoration(
                    hintText: "Enter Complaint Title",
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  controller: _complaintcontroller.description,
                  decoration: InputDecoration(
                    hintText: "Description of Complaint",
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  keyboardType: TextInputType.streetAddress,
                  controller: _complaintcontroller.location,
                  decoration: InputDecoration(
                    hintText: "Enter Complaint Location",
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: _complaintcontroller.phone,
                  decoration: InputDecoration(
                    hintText: "Enter Complaint Phone",
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              title == ""
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _complaintcontroller.type,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText:
                              "Enter your Type of Complaint , hint : Solid-waste",
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        readOnly: true,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "$title",
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  print("Camera Click");
                  _complaintcontroller.getImage();
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text("Take Camera"),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  child: logic.progress != null
                      ? Text(
                          'Uploading ${(logic.progress! * 100).toStringAsFixed(2)} %')
                      : null),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  print("server Click");
                  if (logic.downloadedimage != null) {
                    _complaintcontroller.AddAllData();
                    Future.delayed(Duration(seconds: 1), () {
                      if (logic.datafound != null) {
                        Get.to(() => HomeScreen());
                      }
                    });
                  } else {
                    Fluttertoast.showToast(
                        msg: "Wait for Image it is downloading from server");
                  }
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text("Upload Server"),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
