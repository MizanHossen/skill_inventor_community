import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skill_inventor_community/screen/add_post_screen.dart';
import 'package:skill_inventor_community/screen/feed_screen.dart';
import 'package:skill_inventor_community/screen/profile_screen.dart';
import 'package:skill_inventor_community/screen/search_screen.dart';

const webScreenSize = 500;

final homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Center(child: Text("Under construction")),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
