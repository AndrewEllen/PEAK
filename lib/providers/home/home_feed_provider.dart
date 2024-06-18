
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../helpers/firebase/profile_handlers.dart';

class HomeFeedProvider with ChangeNotifier {

  ///Cache of all loaded user data from posts and comments during session
  final List<DocumentSnapshot> _userDataCache = [];
  List<DocumentSnapshot> get userDataCache => _userDataCache;

  ///Home Feed List
  final List<DocumentSnapshot> _postDocuments = [];
  List<DocumentSnapshot> get postDocuments => _postDocuments;


  Future<DocumentSnapshot<Object?>?> loadUserData(String userToLoadID) async {

    if (_userDataCache.any((element) => element.id == userToLoadID)) {
      //debugPrint("Fetching User From Cache");
      return _userDataCache[_userDataCache.indexWhere((element) => element.id == userToLoadID)];
    } else {
      //debugPrint("Fetching User From DB");
      DocumentSnapshot<Object>? user = await fetchUserdata(userToLoadID);
      if (user != null) {
        addUserToCache(user);
        return user;
      }
      return null;
    }

  }

  void addUserToCache(DocumentSnapshot user) {

    _userDataCache.add(user);

  }

  void updatePostDocuments(QuerySnapshot query) {

    _postDocuments.addAll(query.docs);

    notifyListeners();
  }

}