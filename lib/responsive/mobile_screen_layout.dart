import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_inventor_community/providers/nav_bar_provider.dart';
import 'package:skill_inventor_community/providers/navbar_screen_provider.dart';
import 'package:skill_inventor_community/utils/colors.dart';
import 'package:skill_inventor_community/widgets/drop_container.dart';

// class MobileScreenLayout extends StatelessWidget {
//   const MobileScreenLayout({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // final navBarProvider = Provider.of<NavBarProvider>(context);

//     final navScreenProvider = Provider.of<NavBarScreenProvider>(context);

//     final PageStorageBucket bucket = PageStorageBucket();
//     Widget currentScreen = const Center(child: Text("Dashboard"));

//     return Scaffold(
//       body: IndexedStack(
//         index: navScreenProvider.currentTab,
//         children: navScreenProvider.screens,
//       ),
//       // body: PageStorage(
//       //   bucket: bucket,
//       //   child: navScreenProvider.currentScreen,
//       // ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () {},
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//         shape: CircularNotchedRectangle(),
//         notchMargin: 10,
//         child: SizedBox(
//           height: 60,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   MaterialButton(
//                     minWidth: 40,
//                     onPressed: () {
//                       navScreenProvider.setCurrentTab(0);
//                       print("alskdfj");
//                     },
//                     child: const Icon(Icons.dashboard),
//                   ),
//                   MaterialButton(
//                     minWidth: 40,
//                     onPressed: () {
//                       navScreenProvider.setCurrentTab(2);
//                     },
//                     child: const Icon(Icons.dashboard),
//                   ),
//                 ],
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   MaterialButton(
//                     minWidth: 40,
//                     onPressed: () {
//                       navScreenProvider.setCurrentTab(2);
//                     },
//                     child: const Icon(Icons.dashboard),
//                   ),
//                   MaterialButton(
//                     minWidth: 40,
//                     onPressed: () {
//                       navScreenProvider.setCurrentTab(3);
//                     },
//                     child: const Icon(Icons.dashboard),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );

//     // Scaffold(
//     //   body: navBarProvider.items[navBarProvider.selectedIndex].widget,
//     //   bottomNavigationBar: CupertinoTabBar(
//     //     backgroundColor: const Color(0xffECF0F3),
//     //     currentIndex: navBarProvider.selectedIndex,
//     //     activeColor: Colors.green,
//     //     inactiveColor: hintTextColor,
//     //     onTap: (value) {
//     //       navBarProvider.selectedIndex = value;
//     //     },
//     //     items: navBarProvider.items
//     //         .map((e) => BottomNavigationBarItem(
//     //               icon: Icon(e.iconData),
//     //               label: e.level,
//     //             ))
//     //         .toList(),
//     //   ),
//     // );
//   }
// }

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key});

  @override
  Widget build(BuildContext context) {
    final navScreenProvider = Provider.of<NavBarScreenProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: navScreenProvider.currentTab,
        children: navScreenProvider.screens,
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        backgroundColor:
            navScreenProvider.currentTab == 2 ? Colors.green : Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          navScreenProvider.setCurrentTab(2);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        surfaceTintColor: Colors.red,
        color: const Color(0xffECF0F3),
        // color: Colors.red,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MaterialButton(
                      minWidth: 70,
                      onPressed: () {
                        navScreenProvider.setCurrentTab(0);
                      },
                      child: Icon(
                        Icons.home,
                        color: navScreenProvider.currentTab == 0
                            ? Colors.green
                            : hintTextColor,
                      ),
                    ),
                    MaterialButton(
                      minWidth: 70,
                      onPressed: () {
                        navScreenProvider.setCurrentTab(1);
                      },
                      child: Icon(
                        Icons.manage_search,
                        color: navScreenProvider.currentTab == 1
                            ? Colors.green
                            : hintTextColor,
                      ),
                    ),
                    const SizedBox(width: 40)
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 40),
                    MaterialButton(
                      minWidth: 70,
                      onPressed: () {
                        navScreenProvider.setCurrentTab(3);
                      },
                      child: Icon(
                        Icons.local_mall,
                        color: navScreenProvider.currentTab == 3
                            ? Colors.green
                            : hintTextColor,
                      ),
                    ),
                    MaterialButton(
                      minWidth: 70,
                      onPressed: () {
                        navScreenProvider.setCurrentTab(4);
                      },
                      child: Icon(
                        Icons.person,
                        color: navScreenProvider.currentTab == 4
                            ? Colors.green
                            : hintTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
