import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/controller/auth/signup_controller.dart';
import 'package:note_app/core/constant/enum.dart';
import 'package:note_app/core/functions/valid_input.dart';
import 'package:note_app/view/widgets/button_auth_widget.dart';
import 'package:note_app/view/widgets/text_field_auth_widget.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
    return GetBuilder<SignupController>(builder: (controller) {
      return controller.statusRequest == StatusRequest.loading
          ? Center(child: Lottie.asset("assets/lottie/loading.json"))
          : controller.statusRequest == StatusRequest.offline
              ? Center(
                  child: Lottie.asset("assets/lottie/offline.json"),
                )
              : controller.statusRequest == StatusRequest.failed
                  ? Center(
                      child: Lottie.asset("assets/lottie/server.json"),
                    )
                  : Center(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        children: [
                          Form(
                            key: controller.formState,
                            child: Column(
                              children: [
                                TextFieldAuth(
                                  hint: "First Name",
                                  controller: controller.firstName,
                                  validator: (value) {
                                    return validInput(
                                        value!, 5, 10, "username");
                                  },
                                ),
                                TextFieldAuth(
                                  validator: (value) {
                                    return validInput(
                                        value!, 5, 10, "username");
                                  },
                                  hint: "Last Name",
                                  controller: controller.lastName,
                                ),
                                TextFieldAuth(
                                  validator: (value) {
                                    return validInput(value!, 5, 60, "email");
                                  },
                                  hint: "Email",
                                  controller: controller.email,
                                ),
                                TextFieldAuth(
                                  validator: (value) {
                                    return validInput(
                                        value!, 5, 50, "password");
                                  },
                                  hint: "Password",
                                  controller: controller.password,
                                ),
                                TextFieldAuth(
                                  validator: (value) {
                                    if (value != controller.password.text) {
                                      return "Not Correct";
                                    }
                                    return null;
                                  },
                                  hint: "Confirm Password",
                                  controller: controller.repassword,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CircleAvatar(
                            backgroundImage: controller.disFile != null
                                ? FileImage(controller.disFile!)
                                : null,
                            radius: 100,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ButtonAuth(
                              text: "Profile Image",
                              onpress: () {
                                controller.uploadImage();
                                // controller.cropperImage();
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          ButtonAuth(
                            text: "Sign Up",
                            onpress: () async =>
                                await controller.signUp(context),
                          )
                        ],
                      ),
                    );
    });
  }
}
