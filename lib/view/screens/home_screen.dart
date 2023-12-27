import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/home_screen_controller.dart';
import 'package:note_app/view/screens/add_note_screen.dart';
import 'package:note_app/view/screens/welcome_screen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddNoteScreen());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Get.offAll(const WelcomeScreen());
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: GetBuilder<HomeScreenController>(
          init: HomeScreenController(),
          builder: (controller) {
            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final notes = snapshot.data!.docs;

                  // Use the notes data to build your UI
                  return MasonryGridView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: notes.length,
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Container(
                          // curve: Curves.easeInOut,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // duration: Duration(seconds: 5 + (index * 2)),
                          // transform: Matrix4.translationValues(
                          //     controller.startAnimation
                          //         ? 0
                          //         : MediaQuery.of(context).size.width,
                          //     0,
                          //     0),
                          child: Column(
                            children: [
                              Text(
                                "${notes[index]['title']}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25, fontFamily: 'tajawal'),
                              ),
                              Text(
                                "${notes[index]['time']}",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                return Shimmer.fromColors(
                    baseColor: Colors.grey[350]!,
                    highlightColor: const Color.fromARGB(183, 255, 255, 255),
                    child: GridView.builder(
                        itemCount: 20,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, i) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            height: 20,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                          );
                        }));
              },
              stream: FirebaseFirestore.instance
                  .collection("notes")
                  .where("userId",
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
            );
          }),
    );
  }
}
