import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/core/constant/enum.dart';
import 'package:note_app/view/widgets/awesome_widget.dart';

class SignupController extends GetxController {
  late TextEditingController email, password, repassword, firstName, lastName;

  GlobalKey<FormState> formState = GlobalKey();

  late StatusRequest statusRequest;
  signUp(BuildContext context) async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      formData.save();
      statusRequest = StatusRequest.loading;
      update();
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        // print()
        statusRequest = StatusRequest.success;
        // ignore: use_build_context_synchronously
        awesome(context, "Please confirm Your Email before LogIn",
            DialogType.success);
        update();
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          // ignore: use_build_context_synchronously
          awesome(context, "Weak Password", DialogType.info);
        } else if (e.code == 'email-already-in-use') {
          statusRequest = StatusRequest.failed;
          update();
          // ignore: use_build_context_synchronously
          awesome(context, "Email Already in use", DialogType.error);
        }
      } catch (e) {
        //TODO:MAKE STATUSREQUEST
        print(e);
      }
    }
    update();
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    repassword = TextEditingController();
    firstName = TextEditingController();
    lastName = TextEditingController();
    statusRequest = StatusRequest.none;

    super.onInit();
  }
}
