// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:note_app/middleware/services.dart';

// class SettingFieldWidget extends StatelessWidget {
//   const SettingFieldWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     MyServices myServices = Get.find();
//     return Expanded(
//         child: TextFormField(
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: myServices.sharedpref.getBool("dark") == true
//             ? Colors.grey[800]
//             : Colors.grey[400],
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none),
//       ),
//     ));
//   }
// }
