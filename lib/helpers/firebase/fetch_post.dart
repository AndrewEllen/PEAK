import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:peak/models/posts/post_model.dart';

fetchPostData(String postID) async {
  try {
    debugPrint("Data");

    final snapshot = await FirebaseFirestore.instance.collection("posts").doc(postID).get();

    return PostModel(
      posterID: snapshot["posterID"],
      postID: snapshot["postID"],
      postTime: snapshot["postTime"],
      description: snapshot["description"],
      imageUrl: snapshot["imageUrl"],
    );
  } catch (error) {
    debugPrint(error.toString());
  }
}
