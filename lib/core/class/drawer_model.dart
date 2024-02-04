import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/home_screen_controller.dart';
import 'package:note_app/view/screens/info_screen.dart';
import 'package:note_app/view/screens/settings_screen.dart';
import 'package:note_app/view/screens/welcome_screen.dart';

class DrawerData {
  final String title, subtitle;
  final void Function()? onpress;
  final Widget? trailing;
  DrawerData(
    this.subtitle,
    this.trailing,
    this.onpress, {
    required this.title,
  });
}

HomeScreenController controller = Get.put(HomeScreenController());
// bool value = true;
List<DrawerData> data = [
  DrawerData(
    "Settings",
    null,
    () {
      Get.to(() => SettingsScreen(
            controller: controller,
          ));
    },
    title: "Settings",
  ),
  DrawerData(
    "Dark Mode",
    GetBuilder<HomeScreenController>(
        // init: DrawController(),
        builder: (controller) {
      return Switch(
          value: controller.value,
          onChanged: (val) {
            controller.onpress(val);
            controller.update();
          });
    }),
    () {},
    title: "Dark Mode",
  ),
  DrawerData("Info", null, () {
    Get.to(() => const InfoScreen());
  }, title: "Info"),
  DrawerData("Sign Out", null, () async {
    await FirebaseAuth.instance.signOut();
    Get.delete<HomeScreenController>();
    Get.offAll(() => const WelcomeScreen());
  }, title: "Sign Out"),
];
