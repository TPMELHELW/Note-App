import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

Widget? awesome(BuildContext context, String text, DialogType type) {
  AwesomeDialog(
      context: context,
      dialogType: type,
      body: Text(
        text,
        style: const TextStyle(
          fontFamily: "tajawal",
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      )).show();
  return null;
}
