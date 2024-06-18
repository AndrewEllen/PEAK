import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:peak/providers/home/home_feed_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../widgets/post_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  final User user = FirebaseAuth.instance.currentUser!;

  Future<void> signOutUser() async {
    if (await GoogleSignIn().isSignedIn()) {
      await GoogleSignIn().disconnect();
    }

    await FirebaseAuth.instance.signOut();
  }

  List<String> fakePostTags() {
    List<String> tags = [
      "#gym",
      "#meme",
      "#gymnastics",
      "#powerlifting",
      "#bodybuilding",
      "#pr",
      "#deadlift",
      "#squat",
      "#benchpress",
      "#competition",
      "#progress",
      "#motivation",
    ];

    int listEnd = Random().nextInt(6);

    tags = tags..shuffle();

    return tags.getRange(0, listEnd == 0 ? listEnd + 1 : listEnd).toList();
  }

  void fakePost() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      for (int i = 0; i < 200; i++) {
        String postID = const Uuid().v4();
        FieldValue timePosted = FieldValue.serverTimestamp();

        await FirebaseFirestore.instance.collection('posts').doc(postID).set({
          "posterID": firebaseAuth.currentUser!.uid.toString(),
          "postID": postID,
          'postTime': timePosted,
          "description": "Generated Post ${i + 1}",
          "imageUrl": "https://dummyimage.com/800x800/000000/0011ff&text=${i + 1}",
          "likes": 0,
          "tags": {for (String tag in fakePostTags()) tag: true},
        });

        await FirebaseFirestore.instance
            .collection('users')
            .doc("${firebaseAuth.currentUser?.uid.toString()}")
            .collection("postIDs")
            .doc(postID)
            .set({
          "posterID": firebaseAuth.currentUser?.uid.toString(),
          "postID": postID,
          'postTime': timePosted,
          "postURL": "https://dummyimage.com/800x800/000000/0011ff&text=${i + 1}",
        });
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  /// Post Document Fetching Below

  void fetchPaginatedPosts(BuildContext context) async {
    QuerySnapshot query;
    if (context.read<HomeFeedProvider>().postDocuments.isEmpty) {
      query = await FirebaseFirestore.instance
          .collection("posts")
          .where("posterID", isNotEqualTo: user.uid.toString())
          //.where("tags.#gym", isEqualTo: true)
          //.where("tags.#meme", isEqualTo: true)
          .limit(4)
          .get();
    } else {
      query = await FirebaseFirestore.instance
          .collection("posts")
          //.where("tags.#gym", isEqualTo: true)
          //.where("tags.#meme", isEqualTo: true)
          .startAfterDocument(context.read<HomeFeedProvider>().postDocuments.last)
          .limit(4)
          .get();
    }

    if (query.docs.isNotEmpty) {
      if (context.mounted) {
        context.read<HomeFeedProvider>().updatePostDocuments(query);
      }
    }
  }

  late ScrollController scrollController;

  void scrollControllerListener() {
    if (scrollController.position.maxScrollExtent == scrollController.position.pixels && scrollController.hasClients) {
      fetchPaginatedPosts(context);
    }
  }

  @override
  void initState() {
    super.initState();

    fetchPaginatedPosts(context);

    scrollController = ScrollController();
    scrollController.addListener(scrollControllerListener);
  }

  @override
  void dispose() {
    super.dispose();

    scrollController.dispose();
  }

  /// Post Document Fetching Above

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SizedBox(
          height: 700.h,
          child: Column(
            children: [
              ///ElevatedButton(
              ///    onPressed: () => fakePost(),
              ///    child: const Text("Generate Posts"),
              ///),
              const Text("Home"),
              ElevatedButton(
                onPressed: () => signOutUser(),
                child: const Text("Logout"),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: context.watch<HomeFeedProvider>().postDocuments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return context.read<HomeFeedProvider>().postDocuments[index]["posterID"] == user.uid
                        ? const SizedBox.shrink() : PostWidget(
                      doc: context.read<HomeFeedProvider>().postDocuments[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
