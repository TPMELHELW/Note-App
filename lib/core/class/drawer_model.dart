import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/home_screen_controller.dart';
import 'package:note_app/view/screens/info_screen.dart';
import 'package:note_app/view/screens/settings_screen.dart';
import 'package:note_app/view/screens/welcome_screen.dart';

class DrawerData {
  final String title;
  final void Function()? onpress;
  final Widget? trailing;
  DrawerData(
    this.trailing,
    this.onpress, {
    required this.title,
  });
}

HomeScreenController controller = Get.put(HomeScreenController());
// bool value = true;
List<DrawerData> data = [
  DrawerData(
    null,
    () {
      Get.to(() => SettingsScreen(
            controller: controller,
          ));
    },
    title: "Settings",
  ),
  DrawerData(
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
  DrawerData(null, () {
    Get.to(() => const InfoScreen());
  }, title: "Info"),
  DrawerData(null, () async {
    await FirebaseAuth.instance.signOut();
    Get.delete<HomeScreenController>();
    Get.offAll(() => const WelcomeScreen());
  }, title: "Sign Out"),
];
