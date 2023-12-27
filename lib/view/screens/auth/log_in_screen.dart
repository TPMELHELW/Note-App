import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/auth/login_controller.dart';
import 'package:note_app/core/functions/valid_input.dart';
import 'package:note_app/view/widgets/button_auth.dart';
import 'package:note_app/view/widgets/text_field_auth.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    LogInController controller = Get.put(LogInController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Form(
            key: controller.formState,
            child: Column(
              children: [
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
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ButtonAuth(
            text: "LogIn",
            onpress: () => controller.logIn(context),
          )
        ],
      ),
    );
  }
}
