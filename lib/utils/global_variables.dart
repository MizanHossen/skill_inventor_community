import 'package:flutter/material.dart';
import 'package:skill_inventor_community/screen/add_post_screen.dart';
import 'package:skill_inventor_community/screen/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  Center(child: Text("search")),
  AddPostScreen(),
  Center(child: Text("favorite")),
  Center(child: Text("profile")),
];
