import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/core/constant/colors.dart';
import 'package:note_app/view/screens/note_view_screen.dart';

class NoteShape extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> notes;
  final int index;

  const NoteShape({super.key, required this.notes, required this.index});

  @override
  Widget build(BuildContext context) {
    var noteref = FirebaseFirestore.instance.collection("notes");
    return Dismissible(
      onDismissed: (val) async {
        await noteref.doc(notes.id).delete();
        print('success');
      },
      key: Key(notes.id),
      child: GestureDetector(
        onTap: () => Get.to(() => NoteView(
              notes: notes,
            )),
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: tileColors[index % 7],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                "${notes['title']}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25, fontFamily: 'tajawal'),
              ),
              Text(
                "${notes['time']}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
