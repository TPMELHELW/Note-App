import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  bool startAnimation = false;
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startAnimation = true;
      update();
    });
    super.onInit();
  }
}
