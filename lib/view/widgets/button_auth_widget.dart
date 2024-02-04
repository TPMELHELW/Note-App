import 'package:flutter/material.dart';

class ButtonAuth extends StatelessWidget {
  final String text;
  final void Function()? onpress;
  const ButtonAuth({super.key, required this.text, this.onpress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpress,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[500],
        minimumSize: const Size(20, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: "tajawal",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
