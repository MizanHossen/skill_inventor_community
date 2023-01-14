import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:skill_inventor_community/resources/auth_methods.dart';
import 'package:skill_inventor_community/responsive/responsive.dart';
import 'package:skill_inventor_community/screen/signup_screen.dart';
import 'package:skill_inventor_community/utils/colors.dart';
import 'package:skill_inventor_community/utils/utils.dart';
import 'package:skill_inventor_community/widgets/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String animationType = 'idle';
  bool isObsecre = true;
  final passwordFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    if (animationType == "hands_up") {
      setState(() {
        animationType = "hands_down";
      });
    }

    setState(() {
      _isLoading = true;
      animationType = 'hands_down';
    });

    String res = await AuthMethods().loginUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (res == "Success") {
      //
      setState(() {
        animationType = "success";
      });
      Timer(const Duration(seconds: 2), () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ));
      });
    } else {
      setState(() {
        animationType = "fail";
      });

      // ignore: use_build_context_synchronously
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  //teddy animation
  @override
  void initState() {
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        setState(() {
          animationType = 'hands_up';
        });
      } else {
        setState(() {
          animationType = 'hands_down';
        });
      }
    });

    usernameFocusNode.addListener(() {
      if (animationType == "hands_up") {
        setState(() {
          animationType = "hands_down";
        });
      }
      if (usernameFocusNode.hasFocus) {
        setState(() {
          animationType = 'test';
        });
      } else {
        setState(() {
          animationType = 'idle';
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final InputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(5));

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Image.asset(
                    "assets/images/sk_logo.png",
                  ),

                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: FlareActor(
                      "assets/images/Teddy.flr",
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.contain,
                      animation: animationType,
                      callback: (animation) {
                        setState(() {
                          animationType = 'idle';
                        });
                      },
                    ),
                  ),

                  //text field for email
                  SizedBox(
                    width: Responsive.isMobile(context)
                        ? double.infinity
                        : Responsive.isTablet(context)
                            ? MediaQuery.of(context).size.width * 0.6
                            : MediaQuery.of(context).size.width * 0.4,
                    child: TextFieldInput(
                      textEditingController: _emailController,
                      hintText: "Enter Your email",
                      textInputType: TextInputType.emailAddress,
                      focusNode: usernameFocusNode,
                    ),
                  ),

                  const SizedBox(height: 20),
                  //text field for pass

                  SizedBox(
                    width: Responsive.isMobile(context)
                        ? double.infinity
                        : Responsive.isTablet(context)
                            ? MediaQuery.of(context).size.width * 0.6
                            : MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      controller: _passwordController,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: passwordFocusNode,
                      obscureText: isObsecre,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 20),
                        hintText: "Enter Your Password",
                        border: InputBorder,
                        focusedBorder: InputBorder,
                        enabledBorder: InputBorder,
                        filled: true,
                        suffixIcon: IconButton(
                            color: primaryColor,
                            icon: Icon(isObsecre
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                isObsecre = !isObsecre;
                              });
                            }),

                        //contentPadding: const EdgeInsets.all(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  //login button

                  InkWell(
                    onTap: loginUser,
                    child: Container(
                      width: Responsive.isMobile(context)
                          ? double.infinity
                          : Responsive.isTablet(context)
                              ? MediaQuery.of(context).size.width * 0.6
                              : MediaQuery.of(context).size.width * 0.4,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        color: primaryColor,
                      ),
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            )
                          : const Text("Log In"),
                    ),
                  ),
                  const SizedBox(height: 20),

                  //transitioning to signing up

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: const Text("Don't have an account"),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
