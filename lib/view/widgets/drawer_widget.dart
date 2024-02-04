import 'package:flutter/material.dart';
import 'package:note_app/controller/home_screen_controller.dart';
import 'package:note_app/core/class/drawer_model.dart';

class DrawerWidget extends StatelessWidget {
  final HomeScreenController controller;
  const DrawerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.80,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              backgroundImage:
                  NetworkImage("${controller.inf[0]['imagePath']}"),
              radius: 60,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Hello ${controller.inf[0]['firstName']}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "tajawal",
                  fontSize: 20),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    onTap: data[i].onpress,
                    title: Text(data[i].title),
                    trailing: data[i].trailing,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
