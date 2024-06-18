import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  Map<String, dynamic> toMap() {
    return {
      "posterID": posterID,
      "postID": postID,
      'postTime': postTime,
      "description": description,
      "imageUrl": imageUrl,
    };
  }

  PostModel({
    required this.posterID,
    required this.postID,
    required this.postTime,
    required this.description,
    required this.imageUrl,
  });

  String posterID;
  String postID;
  Timestamp postTime;
  String description;
  String imageUrl;
}
