import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController repassword;
  late TextEditingController firstName;
  late TextEditingController lastName;
  GlobalKey<FormState> formState = GlobalKey();
  // late TextEditingController email;

  signUp() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      formData.save();
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    repassword = TextEditingController();
    firstName = TextEditingController();
    lastName = TextEditingController();
    // email = TextEditingController();
    super.onInit();
  }
}
