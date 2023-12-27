import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_app/core/constant/enum.dart';
import 'package:note_app/view/screens/home_screen.dart';
import 'package:note_app/view/widgets/awesome_widget.dart';

class AddNoteController extends GetxController {
  late TextEditingController title, body;
  GlobalKey<FormState> formState = GlobalKey();
  late StatusRequest statusRequest;

  CollectionReference<Map<String, dynamic>> noteref =
      FirebaseFirestore.instance.collection('notes');
  addNote(BuildContext context) async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      // Timestamp current = Timestamp.now();
      statusRequest = StatusRequest.loading;
      update();
      try {
        await noteref.add({
          "title": title.text,
          "body": body.text,
          "userId": FirebaseAuth.instance.currentUser!.uid,
          "time": DateFormat.yMMMd().format(DateTime.now())
        });
        statusRequest = StatusRequest.success;
        Get.off(() => HomeScreen());
      } catch (e) {
        statusRequest = StatusRequest.success;

        print(e);
      }
    }
    update();
  }

  @override
  void onInit() {
    title = TextEditingController();
    body = TextEditingController();
    statusRequest = StatusRequest.none;
    super.onInit();
  }
}
