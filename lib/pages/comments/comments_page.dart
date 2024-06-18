import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../helpers/firebase/comments_handler.dart';
import '../../helpers/firebase/profile_handlers.dart';
import '../../providers/home/home_feed_provider.dart';
import '../../widgets/comment_widget.dart';

class CommentsPage extends StatefulWidget {
  CommentsPage({Key? key, required this.postID, required this.posterName}) : super(key: key);
  String postID;
  String posterName;

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  ///When this is equal to TopLevelComment its a top level comment
  String parentCommentID = "TopLevelComment";

  TextEditingController commentController = TextEditingController();

  GlobalKey<FormState> commentKey = GlobalKey<FormState>();

  bool commenting = false;
  bool replyToComment = false;
  String replyingToUsername = "User";

  FocusNode replyFocusNode = FocusNode();


  /// Comments Document Fetching Below

  List<DocumentSnapshot> commentDocuments = [];

  ///TODO need to add model that handles replies

  void fetchPaginatedComments() async {
    QuerySnapshot query;

    if (commentDocuments.isEmpty) {
      query = await FirebaseFirestore.instance
          .collection("posts")
          .doc(widget.postID)
          .collection("comments")
          .where("parentCommentID", isEqualTo: "TopLevelComment")
          .limit(20)
          .get();
    } else {
      query = await FirebaseFirestore.instance
          .collection("posts")
          .doc(widget.postID)
          .collection("comments")
          .where("parentCommentID", isEqualTo: "TopLevelComment")
          .startAfterDocument(commentDocuments.last)
          .limit(20)
          .get();
    }

    if (query.docs.isNotEmpty) {
      commentDocuments.addAll(query.docs);
      setState(() {});
    }
  }

  late ScrollController scrollController = ScrollController();

  void scrollControllerListener() {
    if (scrollController.position.maxScrollExtent == scrollController.position.pixels && scrollController.hasClients) {
      fetchPaginatedComments();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPaginatedComments();
    scrollController.addListener(scrollControllerListener);
    replyFocusNode.addListener(focusNodeListener);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    replyFocusNode.dispose();
  }

  void focusNodeListener() {
    if (!replyFocusNode.hasFocus && commentController.text.isEmpty) {
      setState(() {
        replyToComment = false;
        parentCommentID = "TopLevelComment";
      });
    }
    setState(() {
      commenting = !commenting;
    });
  }

  void replyToCommentFunction(int index, BuildContext context) async {
    DocumentSnapshot? replyingToUsersData = await fetchUserdata(commentDocuments[index]["commenterID"]);
    setState(() {
      replyToComment = true;
      parentCommentID = commentDocuments[index]["commentID"];
      if (replyingToUsersData != null) {
        replyingToUsername = replyingToUsersData["userName"];
      }
    });
    if (context.mounted) {
      FocusScope.of(context).requestFocus(replyFocusNode);
    }
  }

  /// Post Document Fetching Above

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            ///Todo pagination will not work if comments are shorter than the length of screen. Also applies to home page
            ///May need fixed but if enough comments are loaded to begin with then it is not an issue.
            ///Unless one day a phone has an absolutely massive screen that's like a meter tall.
            child: Stack(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  controller: scrollController,
                  itemCount: commentDocuments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () => replyToCommentFunction(index, context),
                          child: CommentWidget(
                            comment: commentDocuments[index],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: commentDocuments.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () => replyToCommentFunction(index, context),
                                child: CommentWidget(
                                  comment: commentDocuments[index],
                                  reply: true,
                                ),
                              );
                            },
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 88.w, bottom: 10.h),
                            child: GestureDetector(
                              child: Row(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      height: 1,
                                      width: 20,
                                      color: Colors.black,
                                    ),
                                  ),

                                  const Text(
                                    "View More Replies",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    );
                  },
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: commenting ? Container(
                    color: const Color.fromRGBO(0, 0, 0, 0.2),
                  ) : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          /// Comment Form
          Padding(
            padding: const EdgeInsets.only(left:24,right:24),
            child: Form(
              key: commentKey,
              child: TextFormField(
                focusNode: replyFocusNode,
                controller: commentController,
                keyboardType: TextInputType.text,
                maxLength: 160,
                decoration: InputDecoration(
                  label: Text(
                      "${replyToComment ? "Replying to" : "Commenting on"} ${replyToComment ? replyingToUsername : widget.posterName}'s ${replyToComment ? "comment" : "post"}"),
                  hintText: "Write a ${replyToComment ? "Reply" : "Comment"}...",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Comment can't be empty";
                  }
                  return null;
                },

                onTapOutside: (_) {
                  replyFocusNode.unfocus();
                },

                onFieldSubmitted: (value) async {

                  if (commentKey.currentState!.validate()) {

                    DocumentSnapshot<Object?>? newComment = await postComment(
                      widget.postID,
                      parentCommentID,
                      commentController.text,
                    );

                    if (newComment != null && newComment["parentCommentID"] == "TopLevelComment") {
                      commentDocuments.insert(0, newComment);
                    }
                    ///Todo add notification if comment fails

                    setState(() {
                      parentCommentID = "TopLevelComment";
                      commentController.text = "";
                      replyToComment = false;
                      commenting = false;
                    });

                  }

                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
