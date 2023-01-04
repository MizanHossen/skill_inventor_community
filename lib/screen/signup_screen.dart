import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skill_inventor_community/resources/auth_methods.dart';
import 'package:skill_inventor_community/screen/login_screen.dart';
import 'package:skill_inventor_community/utils/colors.dart';
import 'package:skill_inventor_community/utils/utils.dart';
import 'package:skill_inventor_community/widgets/text_field_input.dart';

import '../responsive/responsive.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  bool isObsecre = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery, context);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });
    // print(res);

    if (res == "success") {
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
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
                  //Flexible(child: Container()),
                  // logo
                  const SizedBox(height: 30),
                  Image.asset(
                    "assets/images/sk_logo.png",
                  ),
                  // SizedBox(height: 50),
                  // Container(
                  //   width: double.infinity,
                  //   alignment: Alignment.center,
                  //   child: const Text(
                  //     "Skill Inventor Community",
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  //   ),
                  // ),
                  const SizedBox(height: 20),

                  //Circular image
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 55,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : const CircleAvatar(
                              radius: 55,
                              backgroundImage: NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
                              ),
                            ),
                      Positioned(
                        right: -15,
                        bottom: -15,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),

                  //user name
                  SizedBox(
                    width: Responsive.isMobile(context)
                        ? double.infinity
                        : Responsive.isTablet(context)
                            ? MediaQuery.of(context).size.width * 0.6
                            : MediaQuery.of(context).size.width * 0.5,
                    child: TextFieldInput(
                      textEditingController: _usernameController,
                      hintText: "Enter Your username",
                      textInputType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(height: 20),

                  //text field for email

                  SizedBox(
                    width: Responsive.isMobile(context)
                        ? double.infinity
                        : Responsive.isTablet(context)
                            ? MediaQuery.of(context).size.width * 0.6
                            : MediaQuery.of(context).size.width * 0.5,
                    child: TextFieldInput(
                      textEditingController: _emailController,
                      hintText: "Enter Your email",
                      textInputType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 20),

                  //text field for pass

                  // TextFieldInput(
                  //   textEditingController: _passwordController,
                  //   hintText: "Enter Your Password",
                  //   textInputType: TextInputType.emailAddress,
                  //   isPass: true,
                  // ),

                  SizedBox(
                    width: Responsive.isMobile(context)
                        ? double.infinity
                        : Responsive.isTablet(context)
                            ? MediaQuery.of(context).size.width * 0.6
                            : MediaQuery.of(context).size.width * 0.5,
                    child: TextField(
                      controller: _passwordController,
                      keyboardType: TextInputType.emailAddress,
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
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  //bio
                  SizedBox(
                    width: Responsive.isMobile(context)
                        ? double.infinity
                        : Responsive.isTablet(context)
                            ? MediaQuery.of(context).size.width * 0.6
                            : MediaQuery.of(context).size.width * 0.5,
                    child: TextFieldInput(
                      textEditingController: _bioController,
                      hintText: "Enter Your bio",
                      textInputType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(height: 20),

                  //login button
                  InkWell(
                    onTap: signUpUser,
                    child: Container(
                      width: Responsive.isMobile(context)
                          ? double.infinity
                          : Responsive.isTablet(context)
                              ? MediaQuery.of(context).size.width * 0.6
                              : MediaQuery.of(context).size.width * 0.5,
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
                                color: Colors.white,
                              ),
                            )
                          : const Text("Sign Up"),
                    ),
                  ),
                  const SizedBox(height: 12),

                  //transitioning to signing up

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: const Text("Already have an account"),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: const Text(
                            "LogIn",
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
