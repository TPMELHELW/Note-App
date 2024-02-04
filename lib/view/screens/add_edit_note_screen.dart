// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/add_note_controller.dart';
import 'package:note_app/view/widgets/add_note_button_widget.dart';
import 'package:note_app/view/widgets/form_note_widget.dart';

class AddNoteScreen extends StatelessWidget {
  bool isEdit = false;
  final QueryDocumentSnapshot<Map<String, dynamic>>? note;

  AddNoteScreen({
    super.key,
    this.note,
    required this.isEdit,
  });

  @override
  Widget build(BuildContext context) {
    AddNoteController controller = Get.put(AddNoteController());
    if (isEdit) {
      controller.title.text = note!['title'];
      controller.body.text = note!['body'];
    }
    handlePress() async {
      isEdit
          ? await controller.editNote(context, note!.id)
          : await controller.addNote(context);
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AddNoteButton(
                    child: const Icon(
                      Icons.keyboard_arrow_left,
                    ),
                    onPressed: () => Get.back(),
                  ),
                  AddNoteButton(
                    onPressed: handlePress,
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FormWidget(controller: controller)
          ],
        ),
      ),
    );
  }
}
