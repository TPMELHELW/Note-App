// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:note_app/controller/tab_controller.dart';

// class Test extends StatelessWidget {
//   const Test({super.key});

//   @override
//   Widget build(BuildContext context) {
//     TabBarController controller = Get.put(TabBarController());
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.indigo),
//       body: Column(
//         children: [
//           Stack(
//             children: [
//               ClipPath(
//                 clipper: Clipper(),
//                 child: Container(
//                   padding: EdgeInsets.all(80),
//                   decoration: BoxDecoration(
//                     color: Colors.indigo,
//                   ),
//                   height: 200,
//                 ),
//               ),
//             ],
//           ),
//           TabBar(controller: controller.tabController, tabs: const [
//             Tab(
//               text: "mahmoud",
//             ),
//             Tab(
//               text: "tarek",
//             ),
//             Tab(
//               text: "elhelw",
//             ),
//           ]),
//           Expanded(
//             child: TabBarView(
//                 controller: controller.tabController,
//                 children: const [
//                   Text(
//                     "hello",
//                     textAlign: TextAlign.center,
//                   ),
//                   Text(
//                     "eng",
//                     textAlign: TextAlign.center,
//                   ),
//                   Text(
//                     "rofida",
//                     textAlign: TextAlign.center,
//                   ),
//                 ]),
//           )
//         ],
//       ),
//     );
//   }
// }

// class Clipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.moveTo(size.width, size.height * 0.488);
//     path.quadraticBezierTo(size.width * 0.89875, size.height * 0.9,
//         size.width * 0.499, size.height * 0.926);
//     path.quadraticBezierTo(size.width * 0.0995, size.height * 0.903,
//         size.width * -0.001, size.height * 0.49);
//     path.lineTo(size.width * -0.001, 0);
//     path.lineTo(size.width * 0.998, 0);

//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }
