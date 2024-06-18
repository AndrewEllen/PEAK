import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

Future<String> fetchUserPostCount(String userID) async {
  try {
    debugPrint("Fetching Post Count");

    final snapshot =
        await FirebaseFirestore.instance.collection("users").doc(userID).collection("postIDs").count().get();

    return snapshot.count.toString();
  } catch (error) {
    debugPrint(error.toString());
    return "0";
  }
}

Future<DocumentSnapshot<Object>?> fetchUserdata(String userID) async {
  try {

    final snapshot =
      await FirebaseFirestore.instance.collection("users").doc(userID).get();

    return snapshot;
  } catch (error) {
    debugPrint(error.toString());
    return null;
  }
}