import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    XFile? file;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                file = await imagePicker.pickImage(source: ImageSource.gallery);
                // file = responce;
              },
              child: Text("Choose Image")),
          ElevatedButton(
              onPressed: () {
                Reference refroot = FirebaseStorage.instance.ref();
                Reference refdir = refroot.child('images/${file!.name}');
                refdir.putFile(File(file!.path));
              },
              child: Text("Upload Image")),
        ],
      ),
    );
  }
}
