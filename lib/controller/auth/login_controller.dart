import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }
}
