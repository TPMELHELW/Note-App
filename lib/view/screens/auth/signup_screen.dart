import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/auth/signup_controller.dart';
import 'package:note_app/core/constant/enum.dart';
import 'package:note_app/core/functions/valid_input.dart';
import 'package:note_app/view/widgets/button_auth.dart';
import 'package:note_app/view/widgets/text_field_auth.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
        init: SignupController(),
        builder: (controller) {
          return controller.statusRequest == StatusRequest.loading
              ? const Center(
                  child: CircularProgressIndicator(),
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
                                return validInput(value!, 5, 10, "username");
                              },
                            ),
                            TextFieldAuth(
                              validator: (value) {
                                return validInput(value!, 5, 10, "username");
                              },
                              hint: "Last Name",
                              controller: controller.lastName,
                            ),
                            TextFieldAuth(
                              validator: (value) {
                                return validInput(value!, 5, 30, "email");
                              },
                              hint: "Email",
                              controller: controller.email,
                            ),
                            TextFieldAuth(
                              validator: (value) {
                                return validInput(value!, 5, 50, "password");
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
                      ButtonAuth(
                        text: "Sign Up",
                        onpress: () => controller.signUp(context),
                      )
                    ],
                  ),
                );
        });
  }
}
