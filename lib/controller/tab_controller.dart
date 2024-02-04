import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  List<Tab> tabs = [
    const Tab(text: "Login"),
    const Tab(text: "Register"),
  ];
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);
  }
}
