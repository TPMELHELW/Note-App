import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/core/constant/enum.dart';
import 'package:note_app/view/screens/home_screen.dart';
import 'package:note_app/view/widgets/awesome_widget.dart';

class LogInController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;
  GlobalKey<FormState> formState = GlobalKey();
  FirebaseAuth auth = FirebaseAuth.instance;

  late StatusRequest statusRequest;
  logIn(BuildContext context) async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      formData.save();
      update();
      try {
        statusRequest = StatusRequest.loading;
        update();
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        if (userCredential.user!.emailVerified) {
          statusRequest = StatusRequest.success;
          Get.offAll(() => HomeScreen());
          update();
        } else {
          // ignore: use_build_context_synchronously
          awesome(context, "Please Verify Your email", DialogType.success);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          awesome(context, 'No user found for that email.', DialogType.error);
        } else if (e.code == 'wrong-password') {
          awesome(context, 'Wrong password provided for that user.',
              DialogType.error);
        } else {
          print({e});
          print("mahmoud");
        }
      }
    }
    update();
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    statusRequest = StatusRequest.none;
    super.onInit();
  }
}
