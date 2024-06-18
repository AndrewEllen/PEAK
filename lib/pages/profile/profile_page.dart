import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../helpers/firebase/fetch_post.dart';
import '../../helpers/firebase/profile_handlers.dart';
import '../../models/posts/post_model.dart';
import '../../widgets/default_modal.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, this.userID = "", this.userName = "", this.profilePictureURL = ""}) : super(key: key);

  final String userID, userName, profilePictureURL;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late String userID, userName, profilePictureURL;
  TextEditingController userNameController = TextEditingController();
  GlobalKey<FormState> userNameKey = GlobalKey<FormState>();
  bool userNameUnique = false;

  /// Setting the future variable, the future value should be fetched in initState to avoid it being called on every rebuild of the page.
  /// See flutters video on Future Builder below
  /// https://www.youtube.com/watch?v=zEdw_1B7JHY
  late Future<String> profilePostCount;

  String dateSuffix(int day) {
    switch (day % 10) {
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      default:
        return "th";
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.userID.isNotEmpty) {
      userID = widget.userID;
      userName = widget.userName;
    } else {
      userID = firebaseAuth.currentUser!.uid.toString();
      userName = firebaseAuth.currentUser!.displayName!;
    }

    profilePostCount = fetchUserPostCount(userID);

    userNameController.text = firebaseAuth.currentUser!.displayName!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text(
                userName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            ///Showing the total posts from a user by utilising Firebases Count aggregate query and a Future Builder
            FutureBuilder(
                future: profilePostCount,
                initialData: "0",
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      "Post count: ${snapshot.data ?? "0"}",
                    );
                  }
                  return const Text(
                    "Post count: 0",
                  );
                }),

            widget.userID.isEmpty
                ? SizedBox(
                    width: 250.w,
                    child: Form(
                      key: userNameKey,
                      child: TextFormField(
                        controller: userNameController,
                        keyboardType: TextInputType.text,
                        maxLength: 24,
                        decoration: const InputDecoration(
                          label: Text("Username"),
                          hintText: "Username...",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Username can't be empty";
                          }

                          if (!userNameUnique) {
                            return "Username already taken";
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) async {
                          final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

                          final snapshot = await FirebaseFirestore.instance
                              .collection("users")
                              .where("userName", isEqualTo: userNameController.text)
                              .get();

                          if (snapshot.docs.isEmpty) {
                            setState(() {
                              userNameUnique = true;
                            });
                          } else {
                            setState(() {
                              userNameUnique = false;
                            });
                          }

                          if (userNameKey.currentState!.validate()) {
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(firebaseAuth.currentUser!.uid.toString())
                                .set({
                              "userName": userNameController.text,
                            });

                            firebaseAuth.currentUser!.updateDisplayName(userNameController.text);
                          }
                        },
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            Expanded(
              child: Center(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(userID)
                        .collection("postIDs")
                        .where(FieldPath.documentId)
                        .orderBy("postTime", descending: true)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text(
                          'An error has occured',
                          style: TextStyle(color: Colors.black),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          "Loading",
                          style: TextStyle(color: Colors.black),
                        );
                      }

                      if (snapshot.data!.docs.isEmpty) {
                        return const Text(
                          'No Posts to Display',
                          style: TextStyle(color: Colors.black),
                        );
                      }

                      return GridView.count(
                        crossAxisCount: 3,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                              return GestureDetector(
                                onTap: () async {
                                  PostModel data = await fetchPostData(
                                    document.get("postID"),
                                  );

                                  if (context.mounted) {
                                    ModalBottomSheet.showModal(
                                      context,
                                      Column(
                                        children: [
                                          Image.network(
                                            data.imageUrl,
                                          ),
                                          Text(
                                            data.description,
                                          ),
                                          Text(
                                            data.postID,
                                          ),
                                          Text(
                                            DateFormat("MMMM EEEE d'${dateSuffix(data.postTime.toDate().day)}', yyyy")
                                                .format(data.postTime.toDate()),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                                child: Image.network(
                                  document.get("postURL"),
                                ),
                              );
                            })
                            .toList()
                            .cast(),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
