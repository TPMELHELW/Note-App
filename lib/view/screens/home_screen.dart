import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/tab_controller.dart';
import 'package:note_app/view/screens/auth/log_in_screen.dart';
import 'package:note_app/view/screens/auth/signup_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TabBarController controller = Get.put(TabBarController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TabBar(
                isScrollable: true,
                labelStyle: const TextStyle(
                    fontFamily: "tajawal", fontWeight: FontWeight.bold),
                tabAlignment: TabAlignment.center,
                controller: controller.tabController,
                tabs: controller.tabs,
              ),
              Expanded(
                child: TabBarView(
                    controller: controller.tabController,
                    children: const [LogIn(), SignUp()]),
              )
            ]),
      ),
    );
  }
}
