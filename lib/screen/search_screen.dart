import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skill_inventor_community/responsive/responsive.dart';
import 'package:skill_inventor_community/screen/profile_screen.dart';
import 'package:skill_inventor_community/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              setState(() {
                isShowUsers = false;
              });
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        elevation: 0,
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: _searchController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Search for a user",
          ),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowUsers = true;
            });
            //print(_searchController.text);
          },
        ),
      ),
      body: isShowUsers
          ? StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .where("username",
                      isGreaterThanOrEqualTo: _searchController.text)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          PageTransition(
                              child: ProfileScreen(
                                  uid: snapshot.data!.docs[index]["uid"]),
                              type: PageTransitionType.fade)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              snapshot.data!.docs[index]["photoUrl"]),
                        ),
                        title: Text(snapshot.data!.docs[index]["username"]),
                      ),
                    );
                  },
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection("posts").get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator(color: primaryColor));
                }

                return StaggeredGridView.countBuilder(
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 3,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              snapshot.data!.docs[index]["postUrl"],
                            ))),
                    // child: Image.network(
                    //   snapshot.data!.docs[index]["postUrl"],
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  staggeredTileBuilder: (index) => Responsive.isMobile(context)
                      ? StaggeredTile.count(
                          (index % 7 == 0) ? 2 : 1,
                          (index % 7 == 0) ? 2 : 1,
                        )
                      : Responsive.isTablet(context)
                          ? StaggeredTile.count(
                              (index % 7 == 0) ? 1 : 1,
                              (index % 7 == 0) ? 1 : 1,
                            )
                          : StaggeredTile.count(
                              (index % 5 == 0) ? 1 : 1,
                              (index % 5 == 0) ? 1 : 1,
                            ),
                  mainAxisSpacing: Responsive.isMobile(context) ? 8 : 18,
                  crossAxisSpacing: Responsive.isMobile(context) ? 8 : 18,
                );
              },
            ),
    );
  }
}
