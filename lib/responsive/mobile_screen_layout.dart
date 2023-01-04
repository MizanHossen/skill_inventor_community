import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_inventor_community/models/user.dart' as model;
import 'package:skill_inventor_community/providers/nav_bar_provider.dart';
import 'package:skill_inventor_community/providers/user_provider.dart';
import 'package:skill_inventor_community/screen/login_screen.dart';
import 'package:skill_inventor_community/utils/colors.dart';
import 'package:skill_inventor_community/utils/global_variables.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

//   @override
//   State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
// }

// class _MobileScreenLayoutState extends State<MobileScreenLayout> {
//   // int _page = 0;
//   // late PageController pageController;

  // @override
  // void initState() {
  //   super.initState();
  //   pageController = PageController();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   pageController.dispose();
  // }

  // void navigationTapped(int page) {
  //   pageController.jumpToPage(page);
  // }

  // void onPageChanged(int page) {
  //   setState(() {
  //     _page = page;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //model.User user = Provider.of<UserProvider>(context).getUser;

    final navBarProvider = Provider.of<NavBarProvider>(context);

    return Scaffold(
      body: navBarProvider.items[navBarProvider.selectedIndex].widget,

      // PageView(
      //   physics: const NeverScrollableScrollPhysics(),
      //   controller: pageController,
      //   onPageChanged: onPageChanged,
      //   children: homeScreenItems,
      // ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        currentIndex: navBarProvider.selectedIndex,
        //_page,
        activeColor: primaryColor,
        inactiveColor: secondaryColor,
        onTap: (value) {
          navBarProvider.selectedIndex = value;
        },
        items: navBarProvider.items
            .map((e) => BottomNavigationBarItem(
                  icon: Icon(e.iconData),
                  label: e.level,
                ))
            .toList(),

        // [
        //   BottomNavigationBarItem(
        //     icon: Icon(
        //       Icons.home,
        //       //color: _page == 0 ? primaryColor : secondaryColor,
        //     ),
        //     label: "",
        //     backgroundColor: primaryColor,
        //   ),
        //   BottomNavigationBarItem(
        //     icon: Icon(
        //       Icons.search,
        //     ),
        //     label: "",
        //     backgroundColor: primaryColor,
        //   ),
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.add_circle),
        //     label: "",
        //     backgroundColor: primaryColor,
        //   ),
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.favorite),
        //     label: "",
        //     backgroundColor: primaryColor,
        //   ),
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.person),
        //     label: "",
        //     backgroundColor: primaryColor,
        //   ),
        // ],
      ),
    );
  }
}
