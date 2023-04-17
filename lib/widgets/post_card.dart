import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:skill_inventor_community/providers/user_provider.dart';
import 'package:skill_inventor_community/resources/firestore_methods.dart';
import 'package:skill_inventor_community/screen/comments_screen.dart';
import 'package:skill_inventor_community/utils/colors.dart';
import 'package:skill_inventor_community/utils/utils.dart';
import 'package:skill_inventor_community/widgets/drop_container.dart';
import 'package:skill_inventor_community/widgets/like_animation.dart';

class PostCard extends StatefulWidget {
  final snap;

  const PostCard({
    required this.snap,
    Key? key,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLen = 0;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  void getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("posts")
          .doc(widget.snap["postId"])
          .collection("comments")
          .get();

      // Stream<QuerySnapshot> stream = FirebaseFirestore.instance
      //     .collection("users")
      //     .doc(widget.snap["postId"])
      //     .collection("comments")
      //     .snapshots();

      commentLen = snap.docs.length;

      setState(() {
        commentLen == commentLen;
      });
    } catch (e) {
      //showSnackBar(e.toString(), context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: DropContainer(
        child: Container(
          //color: Colors.red,

          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              // *************Header Section***************
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 15,
                ).copyWith(right: 0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(widget.snap['profImage']),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.snap["username"],
                              style: kHeadingTextStyle.copyWith(
                                  color: boldTextColor),
                            )
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: ListView(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shrinkWrap: true,
                              children: ["Delete"]
                                  .map(
                                    (e) => InkWell(
                                      onTap: () async {
                                        if (FirebaseAuth
                                                .instance.currentUser!.uid ==
                                            widget.snap["uid"]) {
                                          FirestoreMethods().deletePost(
                                              widget.snap["postId"]);
                                          Fluttertoast.showToast(
                                              msg: "Delted successfully",
                                              backgroundColor: hintTextColor,
                                              textColor: Colors.black);
                                          // showSnackBar(
                                          //     "Deleted successfully", context);
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Can't Delete another user's post",
                                              backgroundColor: hintTextColor,
                                              textColor: Colors.black);
                                          // showSnackBar(
                                          //     "Can't Delete another user's post",
                                          //     context);
                                        }

                                        // FirebaseAuth.instance.currentUser!.uid ==
                                        //         widget.snap["uid"]
                                        //     ? FirestoreMethods()
                                        //         .deletePost(widget.snap["postId"])
                                        //     : showSnackBar(
                                        //         "Can't Delete another user post",
                                        //         context);
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 10,
                                        ),
                                        child: Text(e),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        color: hintTextColor,
                      ),
                    )
                  ],
                ),
              ),

              // *************Image Section***************

              GestureDetector(
                onDoubleTap: () async {
                  await FirestoreMethods().likePost(
                    widget.snap['postId'],
                    user!.uid,
                    widget.snap['likes'],
                  );
                  setState(() {
                    isLikeAnimating = true;
                  });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      child: Image.network(
                        widget.snap['postUrl'],
                        fit: BoxFit.fill,
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isLikeAnimating ? 1 : 0,
                      child: LikeAnimation(
                        isAnimating: isLikeAnimating,
                        duration: const Duration(
                          microseconds: 400,
                        ),
                        onEnd: () {
                          setState(() {
                            isLikeAnimating = false;
                          });
                        },
                        child: const Icon(
                          Icons.favorite,
                          color: hintTextColor,
                          size: 120,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // *************Like $ comment Section***************

              Row(
                children: [
                  LikeAnimation(
                    isAnimating: widget.snap['likes'].contains(user?.uid),
                    smallLike: true,
                    child: IconButton(
                        onPressed: () async {
                          await FirestoreMethods().likePost(
                            widget.snap['postId'],
                            user!.uid,
                            widget.snap['likes'],
                          );
                        },
                        icon: widget.snap['likes'].contains(user?.uid)
                            ? const Icon(
                                Icons.favorite,
                                color: hintTextColor,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                color: hintTextColor,
                              )),
                  ),
                  IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      PageTransition(
                        child: CommentsScreen(
                          snap: widget.snap,
                        ),
                        type: PageTransitionType.bottomToTop,
                      ),
                    ),
                    icon: const Icon(
                      Icons.comment_outlined,
                      color: hintTextColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const ImageIcon(
                      AssetImage("assets/images/message.png"),
                      color: secondaryColor,
                      size: 50,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.bookmark_border,
                          color: hintTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // *************Description $ comment Section***************

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.snap['likes'].length} like's",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.bold, color: hintTextColor),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      width: double.infinity,
                      child: RichText(
                        text: TextSpan(
                          ///style: const TextStyle(color: primaryColor),
                          children: [
                            TextSpan(
                              text: widget.snap["username"],
                              style: kSubTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text: "   ${widget.snap['description']} ",
                                style: TextStyle(color: boldTextColor))
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: CommentsScreen(
                                  snap: widget.snap,
                                ),
                                type: PageTransitionType.bottomToTop));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "View all $commentLen  comments",
                          style: kSubTextStyle.copyWith(color: hintTextColor),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        DateFormat.yMMMd().format(
                          widget.snap['datePublished'].toDate(),
                        ),
                        style: kSubTextStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: hintTextColor),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
