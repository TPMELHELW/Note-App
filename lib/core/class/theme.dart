import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/middleware/services.dart';
// import 'package:note_app/view/screens/home_screen.dart';

MyServices myServices = Get.find();

class ThemeClass {
  onpress() {
    if (Get.isDarkMode) {
      Get.changeTheme(customLightTheme);
      myServices.sharedpref.setBool("dark", false);
    } else {
      Get.changeTheme(customDarkTheme);
      myServices.sharedpref.setBool("dark", true);
    }
  }

  ThemeData customDarkTheme = ThemeData.dark();
  ThemeData customLightTheme = ThemeData.light();
}
