
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';



Future<DocumentSnapshot<Object?>?> postComment(String postID, String parentCommentID, String commentContent) async {
  try {
    debugPrint("Posting Comment to: ");
    debugPrint(postID.toString());

    String commentID = const Uuid().v4().toString();
    String userID = FirebaseAuth.instance.currentUser!.uid.toString();

    await FirebaseFirestore.instance.collection("posts").doc(postID).collection("comments").doc(commentID).set(
      {
        "commenterID": userID,
        "commentID": commentID,
        "parentCommentID": parentCommentID,
        "commentContent": commentContent,
        "commentTime": DateTime.now(),
      }
    );

    ///Fetching the new comment document from local cache and returning it
    DocumentSnapshot newComment = await FirebaseFirestore.instance
        .collection("posts")
        .doc(postID)
        .collection("comments")
        .doc(commentID)
        .get(const GetOptions(source: Source.cache));

    return newComment;
    ///

  } catch (error) {
    debugPrint(error.toString());
  }
}

Future<String> fetchPostCommentCount(String postID) async {
  try {
    debugPrint("Fetching Comments Count");

    final snapshot =
    await FirebaseFirestore.instance.collection("posts").doc(postID).collection("comments").count().get();

    return snapshot.count.toString();
  } catch (error) {
    debugPrint(error.toString());
    return "0";
  }
}

Future<String> fetchCommentReplyCount(String postID, String commentParentID) async {
  try {
    debugPrint("Fetching Comments Count");

    final snapshot =
    await FirebaseFirestore.instance.collection("posts").doc(postID).collection("comments").where("commentParentID", isEqualTo: commentParentID).count().get();

    return snapshot.count.toString();
  } catch (error) {
    debugPrint(error.toString());
    return "0";
  }
}