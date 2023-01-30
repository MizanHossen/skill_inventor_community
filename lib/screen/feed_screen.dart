import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_inventor_community/providers/refresh_provider.dart';
import 'package:skill_inventor_community/responsive/responsive.dart';
import 'package:skill_inventor_community/utils/colors.dart';
import 'package:skill_inventor_community/utils/global_variables.dart';
import 'package:skill_inventor_community/utils/utils.dart';
import '../widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final refreshNotifire = Provider.of<RefreshNotifier>(context);
    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: width > webScreenSize
                  ? webBackgroundColor
                  : mobileBackgroundColor,
              centerTitle: false,
              title: Image.asset(
                "assets/images/sk_logo.png",
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    showSnackBar("Under construction :-) ", context);
                  },
                  icon: const ImageIcon(
                    AssetImage("assets/images/message.png"),
                    color: primaryColor,
                    size: 50,
                  ),
                ),
              ],
            ),
      body: RefreshIndicator(
        color: primaryColor,
        onRefresh: refreshNotifire.refresh,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("posts")
              .orderBy("datePublished", descending: true)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(
                  horizontal: Responsive.isMobile(context)
                      ? 0
                      : Responsive.isTablet(context)
                          ? width * 0.15
                          : width * 0.3,
                  vertical: width > webScreenSize ? 15 : 0,
                ),
                child: PostCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
