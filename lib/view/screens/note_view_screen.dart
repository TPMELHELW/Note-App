import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/view/screens/add_edit_note_screen.dart';
import 'package:note_app/view/widgets/add_note_button_widget.dart';

class NoteView extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> notes;
  const NoteView({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AddNoteButton(
                    child: const Icon(Icons.keyboard_arrow_left),
                    onPressed: () {
                      Get.back();
                    }),
                AddNoteButton(
                    child: const Icon(Icons.edit_square),
                    onPressed: () {
                      Get.to(() => AddNoteScreen(
                            isEdit: true,
                            note: notes,
                          ));
                    }),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SelectableText(
              "${notes['title']}",
              style: const TextStyle(
                  fontSize: 30,
                  fontFamily: "tajawal",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "${notes['time']}",
              style: const TextStyle(
                fontFamily: "tajawal",
                color: Colors.grey,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SelectableText(
              "${notes['body']}",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
