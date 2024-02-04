import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/controller/auth/login_controller.dart';
import 'package:note_app/core/constant/enum.dart';
import 'package:note_app/core/functions/valid_input.dart';
import 'package:note_app/view/screens/auth/forget_password_screen.dart';
import 'package:note_app/view/widgets/button_auth_widget.dart';
import 'package:note_app/view/widgets/text_field_auth_widget.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LogInController());
    return GetBuilder<LogInController>(
      builder: (controller) => controller.statusRequest == StatusRequest.loading
          ? Center(
              child: Lottie.asset("assets/lottie/loading.json"),
            )
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
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Form(
                                key: controller.formState,
                                child: Column(
                                  children: [
                                    TextFieldAuth(
                                      validator: (value) {
                                        return validInput(
                                            value!, 5, 60, "email");
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
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(() => const ForgetPasswordScreen());
                                },
                                child: const Text(
                                  "Forget Password ?",
                                  // textAlign: TextAlign.right,
                                ),
                              ),
                              ButtonAuth(
                                text: "LogIn",
                                onpress: () => controller.logIn(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
    );
  }
}
