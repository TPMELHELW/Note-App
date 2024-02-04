import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/controller/home_screen_controller.dart';
import 'package:note_app/view/screens/add_edit_note_screen.dart';
import 'package:note_app/view/widgets/drawer_widget.dart';
import 'package:note_app/view/widgets/loading_widget.dart';
import 'package:note_app/view/widgets/note_shape_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeScreenController controller = Get.put(HomeScreenController());
    return Scaffold(
      drawer: DrawerWidget(controller: controller),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => AddNoteScreen(
              isEdit: false,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: _appBar(),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.data!.docs.isEmpty) {
            return Center(child: Lottie.asset("assets/lottie/empty.json"));
          }
          return MasonryGridView.builder(
            itemCount: snapshot.connectionState == ConnectionState.waiting
                ? 30
                : snapshot.data?.docs.length,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              if (!snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.waiting) {
                // print('mahoud');
                return const LoadingWidget();
              } else if (snapshot.hasError) {
                return const Text("Error occurred");
              }
              final notes = snapshot.data!.docs;

              return NoteShape(
                notes: notes[index],
                index: index,
              );
            },
          );
        },
        stream: FirebaseFirestore.instance
            .collection("notes")
            .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .orderBy("time", descending: true)
            .snapshots(),
      ),
    );
  }
}

PreferredSizeWidget _appBar() {
  return AppBar(
    title: const Text("Home Screen"),
  );
}
