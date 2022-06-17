import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hw_introduction_screen/hw_introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:solidwaste/screen/LoginScreen/view/loginscreen.dart';
class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: HwIntroductionScreen(
          onFinish: (){
           Get.to(()=> LoginScreen());
          },
          items:
          [// this param is required

            HwIntroductionItem(
                title: 'Clean Your Environment', // String
                caption: 'Every one Have Responsibility to Clean Environment ', // String
                image:  Lottie.asset('images/into3.json',fit: BoxFit.cover) // Widget
            ),
            HwIntroductionItem(
                title: 'Protect From Diseases', // String
                caption: 'Clean Environment Protect From Disease ', // String
                image: Lottie.asset('images/intro2.json',fit: BoxFit.cover,alignment: Alignment.center),  // Widget
            ),
            HwIntroductionItem(
              title: 'Complaint away By One Click', // String
              caption: 'You can Complaint From Any Where', // String
              image: Lottie.asset('images/intro4.json',fit: BoxFit.cover,alignment: Alignment.center),  // Widget
            ),
          ],
        // finishButton: ElevatedButton(onPressed: () {  }, child: const Text("Finish"),),
      ),
    );
  }
}
