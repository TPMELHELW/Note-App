import 'package:flutter/material.dart';
import 'package:note_app/controller/add_note_controller.dart';
import 'package:note_app/view/widgets/add_note_field_widget.dart';

class FormWidget extends StatelessWidget {
  final AddNoteController controller;
  const FormWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formState,
      child: Column(
        children: [
          AddNoteField(
            validator: (val) {
              if (val!.isEmpty) {
                return "Please Write a note";
              }
              return null;
            },
            controller: controller.title,
            hintText: 'Title',
            hintStyle: const TextStyle(fontSize: 30, color: Colors.grey),
          ),
          AddNoteField(
            validator: (val) {
              if (val!.isEmpty) {
                return "Please Write a note";
              }
              return null;
            },
            controller: controller.body,
            hintText: 'Type something...',
            hintStyle: const TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
