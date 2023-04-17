import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_inventor_community/resources/firestore_methods.dart';
import 'package:skill_inventor_community/utils/colors.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../widgets/comment_card.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({super.key, required this.snap});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: hintTextColor,
          ), // set your custom back icon here
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Comments",
          style: kHeadingTextStyle.copyWith(color: boldTextColor),
        ),
        centerTitle: false,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("posts")
              .doc(widget.snap["postId"])
              .collection("comments")
              .orderBy("datePublished", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: hintTextColor));
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => CommentCard(
                      snap: snapshot.data!.docs[index].data(),
                    ));
          },
        ),
      ),

      //Bottom Comment field
      bottomNavigationBar: SafeArea(
        child: Container(
          //color: Colors.red,
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding:
              const EdgeInsets.symmetric(horizontal: 15).copyWith(right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photoUrl),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: "Comment as ${user.username}",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    _isLoading == true;
                  });
                  await FirestoreMethods().postComment(
                    widget.snap["postId"],
                    _commentController.text,
                    user.uid,
                    user.username,
                    user.photoUrl,
                  );

                  _commentController.clear();
                  setState(() {
                    _isLoading == false;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: primaryColor)
                      : const Text(
                          "Post",
                          style: TextStyle(
                            color: hintTextColor,
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
