import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/auth/forget_password_controller.dart';
import 'package:note_app/core/functions/valid_input.dart';
import 'package:note_app/view/widgets/button_auth_widget.dart';
import 'package:note_app/view/widgets/text_field_auth_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ForgetPasswordController controller = Get.put(ForgetPasswordController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: controller.formState,
                child: TextFieldAuth(
                    hint: "Email",
                    controller: controller.email,
                    validator: (val) => validInput(val!, 1, 50, "email")),
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonAuth(
                text: "Check",
                onpress: () => controller.setPassword(),
              )
            ]),
      ),
    );
  }
}
