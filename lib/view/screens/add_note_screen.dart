import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/add_note_controller.dart';
import 'package:note_app/view/widgets/add_note_button.dart';
import 'package:note_app/view/widgets/add_note_field.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AddNoteController controller = Get.put(AddNoteController());
    return Scaffold(
      backgroundColor: const Color(0xFF252525),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AddNoteButton(
                    child: const Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                    ),
                    onPressed: () => Get.back(),
                  ),
                  AddNoteButton(
                      onPressed: () => controller.addNote(context),
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ),
            Form(
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
                    hintStyle:
                        const TextStyle(fontSize: 30, color: Colors.grey),
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
                    hintStyle:
                        const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
