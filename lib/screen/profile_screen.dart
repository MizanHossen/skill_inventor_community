import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skill_inventor_community/resources/auth_methods.dart';
import 'package:skill_inventor_community/resources/firestore_methods.dart';
import 'package:skill_inventor_community/screen/login_screen.dart';
import 'package:skill_inventor_community/utils/colors.dart';
import 'package:skill_inventor_community/utils/global_variables.dart';
import 'package:skill_inventor_community/utils/utils.dart';
import 'package:skill_inventor_community/widgets/follow_button.dart';

import '../responsive/responsive.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;

  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .get();

      //get post length
      var postSnap = await FirebaseFirestore.instance
          .collection("posts")
          .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLen = postSnap.docs.length;

      userData = userSnap.data()!;
      followers = userSnap.data()!["followers"].length;
      following = userSnap.data()!["following"].length;
      isFollowing = userSnap
          .data()!["followers"]
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!.uid;
    final width = MediaQuery.of(context).size.width;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(color: primaryColor),
          )
        : Scaffold(
            appBar: width > webScreenSize
                ? null
                : AppBar(
                    backgroundColor: mobileBackgroundColor,
                    title: Text(userData["username"]),
                    centerTitle: false,
                    actions: [
                      user == widget.uid
                          ? TextButton(
                              onPressed: () async {
                                await AuthMethods().signOut();
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ));
                              },
                              child: const Text(
                                "LogOut",
                                style: TextStyle(color: primaryColor),
                              ))
                          : Container(),
                    ],
                  ),
            body: ListView(
              children: [
                Padding(
                  padding: Responsive.isMobile(context)
                      ? const EdgeInsets.all(16.0)
                      : const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: primaryColor,
                            radius: Responsive.isMobile(context)
                                ? 40
                                : Responsive.isTablet(context)
                                    ? 65
                                    : 100,
                            backgroundImage: NetworkImage(userData["photoUrl"]),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    BuildColumn(
                                      number: postLen,
                                      label: "Posts",
                                    ),
                                    BuildColumn(
                                      number: followers,
                                      label: "Followers",
                                    ),
                                    BuildColumn(
                                      number: following,
                                      label: "Following",
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(),
                                    user == widget.uid
                                        ? FollowButton(
                                            function: () {},
                                            backgroundColor:
                                                mobileBackgroundColor,
                                            borderColor: primaryColor,
                                            text: "Edit Profile",
                                            textColor: primaryColor,
                                          )
                                        : isFollowing
                                            ? FollowButton(
                                                function: () async {
                                                  await FirestoreMethods()
                                                      .followUser(user,
                                                          userData["uid"]);
                                                  setState(() {
                                                    isFollowing = false;
                                                    followers--;
                                                  });
                                                },
                                                backgroundColor:
                                                    mobileBackgroundColor,
                                                borderColor: primaryColor,
                                                text: "Unfollow",
                                                textColor: primaryColor,
                                              )
                                            : FollowButton(
                                                function: () async {
                                                  await FirestoreMethods()
                                                      .followUser(user,
                                                          userData["uid"]);
                                                  setState(() {
                                                    isFollowing = true;
                                                    followers++;
                                                  });
                                                },
                                                backgroundColor: primaryColor,
                                                borderColor: primaryColor,
                                                text: "Follow",
                                                textColor: Colors.white,
                                              ),
                                    Responsive.isDesktop(context) &&
                                            Responsive.isTablet(context) &&
                                            user == widget.uid
                                        ? Expanded(
                                            child: Container(
                                              height: 35,
                                              margin: EdgeInsets.only(top: 30),
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: primaryColor,
                                                    width: 1),
                                              ),
                                              child: const Center(
                                                  child: Text(
                                                "LogeOut",
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                          )
                                        : Container()
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          userData["username"].toString(),
                          style: TextStyle(
                            fontSize: Responsive.isMobile(context)
                                ? 18
                                : Responsive.isTablet(context)
                                    ? 25
                                    : 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          userData["bio"].toString(),
                          style: TextStyle(
                            fontSize: Responsive.isMobile(context)
                                ? 18
                                : Responsive.isTablet(context)
                                    ? 20
                                    : 25,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("posts")
                      .where("uid", isEqualTo: widget.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap = snapshot.data!.docs[index];

                        return Container(
                            child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            snap["postUrl"],
                          ),
                        ));
                      },
                    );
                  },
                )
              ],
            ),
          );
  }
}

class BuildColumn extends StatelessWidget {
  int number;
  String label;
  BuildColumn({
    super.key,
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          number.toString(),
          style: TextStyle(
              fontSize: Responsive.isMobile(context)
                  ? 20
                  : Responsive.isTablet(context)
                      ? 25
                      : 35,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
              fontSize: Responsive.isMobile(context)
                  ? 15
                  : Responsive.isMobile(context)
                      ? 20
                      : 25,
              fontWeight: FontWeight.w400,
              color: primaryColor),
        )
      ],
    );
  }
}
