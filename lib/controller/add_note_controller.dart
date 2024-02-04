import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_app/core/constant/enum.dart';
import 'package:note_app/view/screens/home_screen.dart';

class AddNoteController extends GetxController {
  late TextEditingController title, body;
  GlobalKey<FormState> formState = GlobalKey();
  late StatusRequest statusRequest;
  // bool isEdit = false;

  CollectionReference<Map<String, dynamic>> noteref =
      FirebaseFirestore.instance.collection('notes');
  addNote(BuildContext context) async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      try {
        DateTime now = DateTime.now();
        await noteref.add({
          "title": title.text,
          "body": body.text,
          "userId": FirebaseAuth.instance.currentUser!.uid,
          "time": DateFormat('yyy-MM-dd HH:mm:ss').format(now)
        });
        statusRequest = StatusRequest.success;
        Get.offAll(() => HomeScreen());
      } catch (e) {
        statusRequest = StatusRequest.success;

        print(e);
      }
    }
    update();
  }

  editNote(BuildContext context, String noteId) async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      try {
        DateTime now = DateTime.now();
        await noteref.doc(noteId).update({
          "title": title.text,
          "body": body.text,
          // "userId": FirebaseAuth.instance.currentUser!.uid,
          "time": DateFormat('yyy-MM-dd HH:mm:ss').format(now)
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
