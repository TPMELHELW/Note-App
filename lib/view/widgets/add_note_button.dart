import 'package:flutter/material.dart';

class AddNoteButton extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  const AddNoteButton(
      {super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B3B3B),
            minimumSize: const Size(10, 60),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        child: child);
  }
}
