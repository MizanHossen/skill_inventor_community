import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skill_inventor_community/models/user.dart';
import 'package:skill_inventor_community/providers/user_provider.dart';
import 'package:skill_inventor_community/utils/colors.dart';

import '../resources/firestore_methods.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({super.key, this.snap});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;

    return Container(
      //alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 18,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.snap["profilePic"]),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: widget.snap["name"],
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "  ${widget.snap["text"]}",
                            style: TextStyle(fontWeight: FontWeight.w300)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMd().format(
                        widget.snap["datePublished"].toDate(),
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              await FirestoreMethods().likeComment(
                widget.snap['postId'],
                widget.snap['commentId'],
                user!.uid,
                widget.snap['likes'],
              );
            },
            icon: widget.snap['likes'].contains(user?.uid)
                ? const Icon(
                    Icons.favorite,
                    color: primaryColor,
                  )
                : const Icon(
                    Icons.favorite_border,
                    color: primaryColor,
                  ),
          ),
        ],
      ),
    );
  }
}
