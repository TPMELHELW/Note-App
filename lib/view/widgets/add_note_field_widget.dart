import 'package:flutter/material.dart';

class AddNoteField extends StatelessWidget {
  final String hintText;
  final TextStyle hintStyle;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  // fin?al int maxLines;
  const AddNoteField({
    super.key,
    required this.hintText,
    required this.hintStyle,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: null,
      // style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
