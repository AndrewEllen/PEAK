class UserSearchModel {
  Map<String, dynamic> toMap() {
    return {
      "userID": userID,
      "userName": userName,
      'profilePictureURL': profilePictureURL,
    };
  }

  UserSearchModel({
    required this.userID,
    required this.userName,
    required this.profilePictureURL,
  });

  String userID;
  String userName;
  String profilePictureURL;
}
