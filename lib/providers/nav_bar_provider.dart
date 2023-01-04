import 'package:flutter/material.dart';
import 'package:skill_inventor_community/screen/add_post_screen.dart';
import 'package:skill_inventor_community/screen/feed_screen.dart';

class NavBarProvider with ChangeNotifier {
  List<NavBar> items = [
    NavBar(
      level: "",
      iconData: Icons.home,
      widget: FeedScreen(),
    ),
    NavBar(
      level: "",
      iconData: Icons.search,
      widget: Center(child: Text("search")),
    ),
    NavBar(
      level: "",
      iconData: Icons.add_circle,
      widget: AddPostScreen(),
    ),
    NavBar(
      level: "",
      iconData: Icons.favorite,
      widget: Center(child: Text("favorite")),
    ),
    NavBar(
      level: "",
      iconData: Icons.person,
      widget: Center(child: Text("profile")),
    ),
  ];

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }
}

class NavBar {
  Widget? widget;
  String? level;
  IconData? iconData;

  NavBar({
    this.widget,
    this.level,
    this.iconData,
  });
}