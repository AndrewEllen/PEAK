import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/home/home_feed_provider.dart';

class CommentWidget extends StatefulWidget {
  CommentWidget({Key? key, required this.comment, this.reply = false}) : super(key: key);
  DocumentSnapshot comment;
  bool reply;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {

  late Future<DocumentSnapshot?> commentFuture;

  Future<DocumentSnapshot?> fetchCommentFromDatabase() async {
    return await context.read<HomeFeedProvider>()
        .loadUserData(widget.comment["commenterID"]);
  }

  @override
  void initState() {
    super.initState();
    commentFuture = fetchCommentFromDatabase();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 6,
        left: 12,
        right: 12,
        bottom: 6,
      ),
      child: Row(
        children: [
          const CircleAvatar(

          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: commentFuture,
                  initialData: "User",
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Text(
                        "${snapshot.data["userName"] ?? "Null"}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Text("User");
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("User");
                    }

                    return const Text("User");
                  }
              ),
              SizedBox(
                width: widget.reply ? 244.w : 251.w,
                child: Text(widget.comment["commentContent"].toString()),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              MdiIcons.heartOutline,
            ),
          ),
        ],
      ),
    );
  }
}
