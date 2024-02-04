import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/middleware/services.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text("About App")),
      body: Column(
        children: [
          Image.asset(
            "assets/images/1.png",
            color: myServices.sharedpref.getBool("dark") == true
                ? Colors.white
                : Colors.black,
          ),
          const Text(
            "Version",
            style: TextStyle(fontSize: 50, fontFamily: "tajawal"),
          ),
          const Text(
            "1.0.0",
            style: TextStyle(fontSize: 50, fontFamily: "tajawal"),
          ),
        ],
      ),
    );
  }
}
