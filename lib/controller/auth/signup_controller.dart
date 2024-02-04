// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/core/constant/enum.dart';
import 'package:note_app/core/functions/check_internet.dart';
import 'package:note_app/view/widgets/awesome_widget.dart';

class SignupController extends GetxController {
  late TextEditingController email, password, repassword, firstName, lastName;
  XFile? file;
  File? disFile;
  GlobalKey<FormState> formState = GlobalKey();
  late StatusRequest statusRequest;

  Future<void> signUp(BuildContext context) async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      formData.save();
      statusRequest = StatusRequest.loading;
      update();
      try {
        if (await checkInternet()) {
          if (file != null) {
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email.text,
              password: password.text,
            );

            await FirebaseAuth.instance.currentUser!.sendEmailVerification();

            Reference refroot = FirebaseStorage.instance.ref();
            Reference refdir = refroot.child('images/${file!.name}');
            await refdir.putFile(disFile!);

            CollectionReference<Map<String, dynamic>> userref =
                FirebaseFirestore.instance.collection("users");
            await userref.add({
              "firstName": firstName.text,
              "lastName": lastName.text,
              "imagePath": await refdir.getDownloadURL(),
              "imageURL": refdir.fullPath,
              'userId': FirebaseAuth.instance.currentUser!.uid
            });
            statusRequest = StatusRequest.success;
            awesome(context, "Please confirm Your Email before LogIn",
                DialogType.success);
            update();
          }
          Get.snackbar("Profile Image", "Please add the Profile Image");
          statusRequest = StatusRequest.none;
          update();
        } else {
          statusRequest = StatusRequest.offline;
          update();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          awesome(context, "Weak Password", DialogType.info);
        } else if (e.code == 'email-already-in-use') {
          statusRequest = StatusRequest.failed;
          update();

          awesome(context, "Email Already in use", DialogType.error);
        }
      } catch (e) {
        statusRequest = StatusRequest.failed;
        update();
      }
    }
    update();
  }

  uploadImage() async {
    ImagePicker imagePicker = ImagePicker();
    file = await imagePicker.pickImage(source: ImageSource.gallery);
    disFile = File(file!.path);
    CroppedFile? cropperImage = await ImageCropper()
        .cropImage(sourcePath: disFile!.path, cropStyle: CropStyle.circle);
    disFile = File(cropperImage!.path);
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

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    repassword.dispose();
    firstName.dispose();
    lastName.dispose();

    super.dispose();
  }
}
