import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_inventor_community/providers/nav_bar_provider.dart';
import 'package:skill_inventor_community/utils/colors.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final navBarProvider = Provider.of<NavBarProvider>(context);

    return Scaffold(
      body: navBarProvider.items[navBarProvider.selectedIndex].widget,
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        currentIndex: navBarProvider.selectedIndex,
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
      ),
    );
  }
}
