import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/middleware/services.dart';
import 'package:note_app/view/screens/home_screen.dart';
import 'package:note_app/view/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBTVFGj1vHO2xrix6Wk-QUV6vqphPPk7fU",
        appId: "1:506897275310:android:a1623c02c5e8326316103f",
        messagingSenderId: "506897275310",
        projectId: "noteapp-25679",
        storageBucket: "noteapp-25679.appspot.com"),
  );
  await initial();
  runApp(const MyApp());
}

User? auth = FirebaseAuth.instance.currentUser;
MyServices myServices = Get.find();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: myServices.sharedpref.getBool("dark") == true
          ? ThemeData.dark()
          : ThemeData.light(),
      home: auth == null ? const WelcomeScreen() : const HomeScreen(),
    );
  }
}
