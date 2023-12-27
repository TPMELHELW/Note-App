import 'package:flutter/material.dart';

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
          fillColor: Colors.grey[400],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
