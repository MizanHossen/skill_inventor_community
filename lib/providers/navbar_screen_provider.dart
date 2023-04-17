import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skill_inventor_community/screen/search_screen.dart';

import '../screen/add_post_screen.dart';
import '../screen/feed_screen.dart';
import '../screen/profile_screen.dart';

class NavBarScreenProvider extends ChangeNotifier {
  int currentTab = 0;
  final List<Widget> screens = [
    const FeedScreen(),
    const SearchScreen(),
    const AddPostScreen(),
    const Center(child: Text("Under construction")),
    ProfileScreen(
      uid: FirebaseAuth.instance.currentUser!.uid,
    ),
  ];

  Widget get currentScreen => screens[currentTab];

  void setCurrentTab(int newTab) {
    currentTab = newTab;
    notifyListeners();
  }
}
