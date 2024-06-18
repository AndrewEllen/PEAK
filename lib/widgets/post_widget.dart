import "package:cached_network_image/cached_network_image.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:material_design_icons_flutter/material_design_icons_flutter.dart";
import "package:peak/providers/home/home_feed_provider.dart";
import "package:provider/provider.dart";

import "../helpers/firebase/comments_handler.dart";
import "../helpers/firebase/profile_handlers.dart";
import "../pages/comments/comments_page.dart";
import "default_modal.dart";


class PostWidget extends StatefulWidget {
  PostWidget({Key? key, required this.doc}) : super(key: key);
  DocumentSnapshot doc;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {

  late Future<DocumentSnapshot<Object?>?> posterDocument;
  late Future<String> commentCount;

  @override
  void initState() {
    super.initState();
    posterDocument = context.read<HomeFeedProvider>().loadUserData(widget.doc["posterID"]);
    commentCount = fetchPostCommentCount(widget.doc.id);
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Center(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                bottom: 10,
              ),
              child: Row(
                children: [
                  CircleAvatar(),

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: FutureBuilder(
                        future: posterDocument,
                        initialData: "User",
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return Text(
                              snapshot.data["userName"] ?? "User",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return const Text(
                              'User',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Text(
                              'User',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }

                          return const Text(
                            'User',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).width,
              child: Image.network(
                widget.doc["imageUrl"],
              ),
            ),

            widget.doc["description"].length > 0 ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 14.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.doc["description"],
                    ),
                  ),
                ),

                const Divider(
                  height: 0,
                ),
              ],
            ) : const SizedBox.shrink(),

            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    MdiIcons.heartOutline,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    if (context.mounted) {
                      ModalBottomSheet.showModal(
                        context,
                        FutureBuilder(
                            future: posterDocument,
                            initialData: "User",
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                return CommentsPage(
                                  postID: widget.doc.id,
                                  posterName: snapshot.data["userName"] ?? "User",
                                );
                              }
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }

                              return const Text('Something went wrong');
                            }
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    MdiIcons.commentTextOutline,
                  ),
                ),

                const Spacer(),

                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    MdiIcons.bookmarkOutline,
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FutureBuilder(
                    future: commentCount,
                    initialData: "0",
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return const Text(
                          "0 Likes",
                        );
                      }
                      return const Text(
                        "0",
                      );
                    }),
              ),
            ),

            ///Todo change commentCount to use a cache so that it doesnt spam the database reads if you scroll up and down

            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FutureBuilder(
                    future: commentCount,
                    initialData: "0",
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Text(
                          "${snapshot.data ?? "0"} Comments",
                        );
                      }
                      return const Text(
                        "0",
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
