import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/core/constant/enum.dart';
import 'package:note_app/core/functions/check_internet.dart';
import 'package:note_app/middleware/services.dart';
import 'package:note_app/view/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenController extends GetxController {
  List inf = [];
  ThemeData customDarkTheme = ThemeData.dark();
  ThemeData customLightTheme = ThemeData.light();
  XFile? file;
  File? uploadFile;
  MyServices myServices = Get.find();
  late SharedPreferences share;
  late bool value;
  late TextEditingController firstName, lastName;
  CollectionReference<Map<String, dynamic>> userref =
      FirebaseFirestore.instance.collection("users");
  late StatusRequest statusRequest;

  getData() async {
    Query<Map<String, dynamic>> userinf = userref.where("userId",
        isEqualTo: FirebaseAuth.instance.currentUser!.uid);

    await userinf.get().then((value) => value.docs.forEach((element) {
          inf.clear();
          inf.add(element.data());
        }));
  }

  onpress(bool val) {
    if (Get.isDarkMode) {
      Get.changeTheme(customLightTheme);
      share.setBool("dark", false);
    } else {
      Get.changeTheme(customDarkTheme);
      share.setBool("dark", true);
    }
    value = val;
    update();
  }

  editImage() async {
    try {
      if (await checkInternet()) {
        ImagePicker imagePicker = ImagePicker();
        file = await imagePicker.pickImage(source: ImageSource.gallery);
        if (file != null) {
          CroppedFile? croppedFile = await ImageCropper()
              .cropImage(sourcePath: file!.path, cropStyle: CropStyle.circle);
          uploadFile = File(croppedFile!.path);
          Reference image = FirebaseStorage.instance.ref(inf[0]['imageURL']);
          await image.putFile(uploadFile!);
          await getData();
          Get.offAll(() => const HomeScreen());
        } else {
          Get.snackbar("No Image", "Please Select Image");
        }
      } else {
        statusRequest = StatusRequest.offline;
        update();
      }
    } catch (e) {
      statusRequest = StatusRequest.failed;
      update();
    }
    update();
  }

  editName() async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      if (await checkInternet()) {
        String docid = '';

        await userref
            .where("userId", isEqualTo: inf[0]['userId'])
            .get()
            .then((value) {
          for (var doc in value.docs) {
            docid = doc.id;
          }
        });
        await userref.doc(docid).update({
          "firstName": firstName.text,
          "lastName": lastName.text,
        });
        statusRequest = StatusRequest.success;
        update();
      } else {
        statusRequest = StatusRequest.offline;
        update();
      }
    } catch (e) {
      statusRequest = StatusRequest.failed;
      update();
    }
  }

  resetPassword() async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      if (await checkInternet()) {
        String email = FirebaseAuth.instance.currentUser!.email.toString();
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        statusRequest = StatusRequest.success;
        update();
        Get.snackbar("Success", "Please Check Your Email");
      } else {
        statusRequest = StatusRequest.offline;
        update();
      }
    } catch (e) {
      statusRequest = StatusRequest.failed;
      update();
    }
  }

  @override
  void onInit() async {
    await getData();
    firstName = TextEditingController();
    lastName = TextEditingController();
    firstName.text = inf[0]['firstName'];
    lastName.text = inf[0]['lastName'];
    share = myServices.sharedpref;
    value = share.getBool("dark") ?? false;
    statusRequest = StatusRequest.none;
    super.onInit();
  }

  @override
  void onClose() {
    firstName.dispose();
    lastName.dispose();
    super.onClose();
  }
}
