import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  late TextEditingController email;

  GlobalKey<FormState> formState = GlobalKey();
  Future<void> setPassword() async {
    try {
      var formData = formState.currentState;
      if (formData!.validate()) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
        Get.back();
        Get.snackbar("Success", "Check Your Email");
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", "$e");
    }
  }

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    super.onClose();
  }
}
