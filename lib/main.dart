import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_inventor_community/providers/nav_bar_provider.dart';
import 'package:skill_inventor_community/providers/navbar_screen_provider.dart';
import 'package:skill_inventor_community/providers/refresh_provider.dart';
import 'package:skill_inventor_community/providers/user_provider.dart';
import 'package:skill_inventor_community/responsive/mobile_screen_layout.dart';
import 'package:skill_inventor_community/responsive/responsive_layout_screen.dart';
import 'package:skill_inventor_community/responsive/web_screen_layout.dart';
import 'package:skill_inventor_community/screen/login_screen.dart';
import 'package:skill_inventor_community/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyD1eA_CkXhLBYgygo-ye9kclSX_JJbpl78",
        appId: "1:637282670082:web:7f8be6a3d335abb628391b",
        messagingSenderId: "637282670082",
        projectId: "skill-inventor-community",
        storageBucket: "skill-inventor-community.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

screenTimer(BuildContext context) {
  Timer(const Duration(seconds: 2), () async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<NavBarScreenProvider>(
            create: (_) => NavBarScreenProvider()),
        ChangeNotifierProvider<NavBarProvider>(create: (_) => NavBarProvider()),
        ChangeNotifierProvider<RefreshNotifier>(
            create: (_) => RefreshNotifier()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Skil Inventor Community",
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        // home: const LoginScreen(),
        //home: DemoDesign()

        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            Timer(const Duration(seconds: 0), () async {
              //already logged-in

              if (FirebaseAuth.instance.currentUser != null) {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResponsiveLayout(
                      mobileScreenLayout: MobileScreenLayout(),
                      webScreenLayout: WebScreenLayout(),
                    ),
                  ),
                );
              } else // not already logged-in
              {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              }
            });

            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                );
              }
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}

class DemoDesign extends StatelessWidget {
  const DemoDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffECF0F3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 300,
            decoration: BoxDecoration(
                color: const Color(0xffECF0F3),
                borderRadius: BorderRadius.circular(120),
                boxShadow: const [
                  //bottom right shadow is darker shadow
                  BoxShadow(
                      color: Color(0xffDCE2EA),
                      offset: const Offset(3, 3),
                      blurRadius: 10,
                      spreadRadius: 1),

                  //top left shaow lighter
                  const BoxShadow(
                    color: Color(0xffF5F7F9),
                    offset: Offset(-5, -5),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ]),
            // child: const CircleAvatar(
            //   backgroundColor: Color(0xffF4F4F4),
            //   radius: 120,
            //   child: CircleAvatar(
            //     backgroundColor: Color(0xffF4F4F4),
            //     radius: 100,
            //   ),
            // ),
          ),
          SizedBox(height: 50),
          Container(
            height: 100,
            width: 300,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(0xffECF0F3),
                borderRadius: BorderRadius.circular(120),
                boxShadow: [
                  //bottom right shadow is darker shadow
                  BoxShadow(
                    blurStyle: BlurStyle.inner,
                    color: Color(0xffF4F6F8),
                    offset: const Offset(5, 5),
                    blurRadius: 10,
                    //spreadRadius: 1,
                  ),

                  //top left shaow lighter
                  const BoxShadow(
                    blurStyle: BlurStyle.inner,
                    //color: Color(0xFFbebebe),
                    color: Color(0xFFE4E8ED),
                    offset: Offset(-5, -5),
                    blurRadius: 5,
                    // spreadRadius: 1,
                  ),
                ]),
            // child: const CircleAvatar(
            //   backgroundColor: Color(0xffF4F4F4),
            //   radius: 120,
            //   child: CircleAvatar(
            //     backgroundColor: Color(0xffF4F4F4),
            //     radius: 100,
            //   ),
            // ),
          ),
          SizedBox(height: 50),
          Container(
            height: 100,
            width: 300,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(120),
                boxShadow: [
                  //bottom right shadow is darker shadow
                  BoxShadow(
                    color: Color(0xffffffff),
                    offset: const Offset(-5, -5),
                    blurRadius: 5,
                    //spreadRadius: 1,
                  ),

                  //top left shaow lighter
                  const BoxShadow(
                    color: Color(0xFFbebebe),
                    offset: Offset(5, 5),
                    blurRadius: 5,
                    // spreadRadius: 1,
                  ),
                ]),
            // child: const CircleAvatar(
            //   backgroundColor: Color(0xffF4F4F4),
            //   radius: 120,
            //   child: CircleAvatar(
            //     backgroundColor: Color(0xffF4F4F4),
            //     radius: 100,
            //   ),
            // ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
