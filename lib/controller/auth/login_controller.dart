// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/auth/signup_controller.dart';
import 'package:note_app/core/constant/enum.dart';
import 'package:note_app/core/functions/check_internet.dart';
import 'package:note_app/view/screens/home_screen.dart';
import 'package:note_app/view/widgets/awesome_widget.dart';

class LogInController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;
  GlobalKey<FormState> formState = GlobalKey();
  FirebaseAuth auth = FirebaseAuth.instance;

  late StatusRequest statusRequest;
  Future<void> logIn(BuildContext context) async {
    var formData = formState.currentState;
    try {
      if (await checkInternet()) {
        if (formData!.validate()) {
          formData.save();
          update();

          statusRequest = StatusRequest.loading;
          update();
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text,
            password: password.text,
          );
          if (userCredential.user!.emailVerified) {
            statusRequest = StatusRequest.success;
            Get.delete<LogInController>();
            Get.delete<SignupController>();
            Get.offAll(() => const HomeScreen());
            update();
          } else {
            awesome(context, "Please Verify Your email", DialogType.success);
          }
        }
      } else {
        statusRequest = StatusRequest.offline;
        update();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        awesome(context, 'No user found for that email.', DialogType.error);
        statusRequest = StatusRequest.failed;
        update();
      } else if (e.code == 'wrong-password') {
        awesome(context, 'Wrong password provided for that user.',
            DialogType.error);
        statusRequest = StatusRequest.failed;
        update();
      } else {
        Get.snackbar("Error", "$e");
        statusRequest = StatusRequest.failed;
        update();
      }
    }
    update();
  }

  @override
  void onInit() async {
    email = TextEditingController();
    password = TextEditingController();
    statusRequest = StatusRequest.none;
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
