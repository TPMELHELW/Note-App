import 'package:flutter/material.dart';
import 'package:note_app/controller/home_screen_controller.dart';
import 'package:note_app/core/functions/valid_input.dart';
import 'package:note_app/view/widgets/button_auth_widget.dart';
import 'package:note_app/view/widgets/text_field_auth_widget.dart';

class FormSettingsWidget extends StatelessWidget {
  final HomeScreenController controller;
  const FormSettingsWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment: ,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFieldAuth(
                  hint: "First Name",
                  controller: controller.firstName,
                  validator: (val) => validInput(val!, 1, 20, "username"),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextFieldAuth(
                  hint: "Last Name",
                  controller: controller.lastName,
                  validator: (val) => validInput(val!, 1, 20, "username"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ButtonAuth(
            text: "Edit Name",
            onpress: () async => controller.editName(),
          )
        ],
      ),
    );
  }
}
