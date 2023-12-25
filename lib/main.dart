import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/view/screens/auth/log_in_screen.dart';
import 'package:note_app/view/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBTVFGj1vHO2xrix6Wk-QUV6vqphPPk7fU",
      appId: "1:506897275310:android:a1623c02c5e8326316103f",
      messagingSenderId: "506897275310",
      projectId: "noteapp-25679",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(home: HomeScreen());
  }
}
