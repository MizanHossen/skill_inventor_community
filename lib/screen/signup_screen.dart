import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skill_inventor_community/resources/auth_methods.dart';
import 'package:skill_inventor_community/screen/login_screen.dart';
import 'package:skill_inventor_community/utils/colors.dart';
import 'package:skill_inventor_community/utils/utils.dart';
import 'package:skill_inventor_community/widgets/custom_container.dart';
import 'package:skill_inventor_community/widgets/drop_container.dart';
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

  // @override
  // void dispose() {
  //   super.dispose();
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   _bioController.dispose();
  //   _bioController.dispose();
  // }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery, context);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    if (_image == null) {
      showSnackBar("Please select an image :-(", context);
    } else {
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

    // print(res);
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
            child: Column(
              children: [
                const SizedBox(height: 50),
                DropContainer(
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Skill Inventor",
                        style: kHeadingTextStyle.copyWith(color: boldTextColor),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Flexible(child: Container()),
                      // logo
                      // const SizedBox(height: 30),
                      // Image.asset(
                      //   "assets/images/sk_logo.png",
                      // ),

                      const SizedBox(height: 20),

                      //Circular image
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: const Color(0xffECF0F3),
                            // color: Colors.blue,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: const [
                              //bottom right shadow is darker shadow
                              BoxShadow(
                                  //color: Colors.red,
                                  color: Color(0xffDBE2E9),
                                  offset: Offset(8, 8),
                                  blurRadius: 10,
                                  spreadRadius: 1),

                              //top left shaow lighter
                              BoxShadow(
                                //blurStyle: BlurStyle.outer,
                                color: Color(0xffF4F7F8),
                                offset: Offset(-10, -10),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ]),
                        child: Stack(
                          children: [
                            _image != null
                                ? CircleAvatar(
                                    radius: 55,
                                    backgroundImage: MemoryImage(_image!),
                                  )
                                : Container(
                                    padding: const EdgeInsets.all(2),
                                    child: const CircleAvatar(
                                      radius: 55,
                                      backgroundColor: primaryColor,
                                      child: Center(
                                        child: Icon(
                                          Icons.person,
                                          color: hintTextColor,
                                          size: 50,
                                        ),
                                      ),
                                      // backgroundImage: NetworkImage(
                                      //   'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
                                      // ),
                                    ),
                                  ),
                            Positioned(
                              right: -15,
                              bottom: -15,
                              child: IconButton(
                                onPressed: selectImage,
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  color: hintTextColor,
                                ),
                              ),
                            )
                          ],
                        ),
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

                      SizedBox(
                        width: Responsive.isMobile(context)
                            ? double.infinity
                            : Responsive.isTablet(context)
                                ? MediaQuery.of(context).size.width * 0.6
                                : MediaQuery.of(context).size.width * 0.5,
                        child: CustomContainer(
                          child: TextField(
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            controller: _passwordController,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: isObsecre,
                            decoration: InputDecoration(
                              fillColor: primaryColor,
                              contentPadding: const EdgeInsets.only(left: 20),
                              hintText: "Enter Your Password",
                              border: InputBorder,
                              focusedBorder: InputBorder,
                              enabledBorder: InputBorder,
                              hintStyle: const TextStyle(color: hintTextColor),
                              filled: true,
                              suffixIcon: IconButton(
                                  color: hintTextColor,
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
                      const SizedBox(height: 40),

                      //login button
                      InkWell(
                        onTap: signUpUser,
                        child: DropContainer(
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
                                  Radius.circular(10),
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
                                : Text(
                                    "Sign Up",
                                    style: kTitleTextstyle.copyWith(
                                        color: boldTextColor),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      //transitioning to signing up

                      DropContainer(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: const Text(
                                "Already have an account",
                                style: kSubTextStyle,
                              ),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "LogIn",
                                  style: kSubTextStyle.copyWith(
                                      color: boldTextColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
