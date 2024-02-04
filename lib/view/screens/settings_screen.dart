import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/controller/home_screen_controller.dart';
import 'package:note_app/core/constant/enum.dart';
import 'package:note_app/view/widgets/button_auth_widget.dart';
import 'package:note_app/view/widgets/form_settings_widget.dart';

class SettingsScreen extends StatelessWidget {
  final HomeScreenController controller;
  const SettingsScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // MyServices myServices = Get.find();
    return Scaffold(
      body: GetBuilder<HomeScreenController>(builder: (context) {
        return SafeArea(
          child: controller.statusRequest == StatusRequest.loading
              ? Center(
                  child: Lottie.asset("assets/lottie/loading.json"),
                )
              : controller.statusRequest == StatusRequest.offline
                  ? Center(
                      child: Lottie.asset("assets/lottie/offline.json"),
                    )
                  : ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ButtonAuth(
                            text: "Edit Image",
                            onpress: () async {
                              await controller.editImage();
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        FormSettingsWidget(controller: controller),
                        const SizedBox(
                          height: 20,
                        ),
                        ButtonAuth(
                          text: "Change Password",
                          onpress: () => controller.resetPassword(),
                        )
                      ],
                    ),
        );
      }),
    );
  }
}
