import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/middleware/services.dart';

class TextFieldAuth extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String hint;
  const TextFieldAuth(
      {super.key,
      required this.hint,
      required this.controller,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: "tajawal",
            fontWeight: FontWeight.bold,
          ),
          filled: true,
          fillColor: myServices.sharedpref.getBool("dark") == true
              ? Colors.grey[800]
              : Colors.grey[400],
          // fillColor: ,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
