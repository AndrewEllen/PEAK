import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peak/pages/profile/profile_page.dart';
import 'package:peak/providers/navigation/navigation_provider.dart';
import 'package:provider/provider.dart';

import '../../models/users/user_search_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController userNameSearchController = TextEditingController();
  GlobalKey<FormState> userNameSearchKey = GlobalKey<FormState>();

  List<UserSearchModel> searchContent = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: 250.w,
              child: Form(
                key: userNameSearchKey,
                child: TextFormField(
                  controller: userNameSearchController,
                  keyboardType: TextInputType.text,
                  maxLength: 24,
                  decoration: const InputDecoration(
                    label: Text("Search Username"),
                    hintText: "Search Username...",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username can't be empty";
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) async {
                    if (userNameSearchKey.currentState!.validate()) {
                      final snapshot = await FirebaseFirestore.instance
                          .collection("users")
                          .where("userName", isGreaterThanOrEqualTo: value)
                          .where("userName", isLessThanOrEqualTo: "$value\uf8ff")
                          .limit(20)
                          .get();

                      setState(() {
                        searchContent = [
                          for (QueryDocumentSnapshot document in snapshot.docs)
                            UserSearchModel(
                              userID: document.id,
                              userName: document["userName"],
                              profilePictureURL: "",
                            ),
                        ];
                      });
                    }
                  },
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: searchContent.length,
              itemBuilder: (BuildContext context, int index) {
                return ElevatedButton(
                  onPressed: () => context.read<NavigationProvider>().changePageCache(
                        newPage: ProfilePage(
                          key: UniqueKey(),
                          userID: searchContent[index].userID,
                          userName: searchContent[index].userName,
                          profilePictureURL: searchContent[index].profilePictureURL,
                        ),
                      ),
                  child: Text(
                    searchContent[index].userName,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
