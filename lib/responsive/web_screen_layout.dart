import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/global_variables.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Image.asset(
          "assets/images/sk_logo.png",
          width: MediaQuery.of(context).size.width > webScreenSize
              ? MediaQuery.of(context).size.width * 0.15
              : MediaQuery.of(context).size.width * 0.4,
        ),
        actions: [
          IconButton(
            onPressed: () => navigationTapped(0),
            icon: const Icon(Icons.home),
            color: _page == 0 ? primaryColor : secondaryColor,
          ),
          IconButton(
            onPressed: () => navigationTapped(1),
            icon: const Icon(Icons.search),
            color: _page == 1 ? primaryColor : secondaryColor,
          ),
          IconButton(
            onPressed: () => navigationTapped(2),
            icon: const Icon(Icons.add_a_photo),
            color: _page == 2 ? primaryColor : secondaryColor,
          ),
          IconButton(
            onPressed: () => navigationTapped(3),
            icon: const Icon(Icons.favorite),
            color: _page == 3 ? primaryColor : secondaryColor,
          ),
          IconButton(
            onPressed: () => navigationTapped(4),
            icon: const Icon(Icons.person),
            color: _page == 4 ? primaryColor : secondaryColor,
          ),
          IconButton(
            onPressed: () {},
            icon: const ImageIcon(
              AssetImage("assets/images/message.png"),
              color: primaryColor,
              size: 50,
            ),
          ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: homeScreenItems,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
