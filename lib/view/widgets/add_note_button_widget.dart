import 'package:flutter/material.dart';

class AddNoteButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  const AddNoteButton(
      {super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(20, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: child);
  }
}
