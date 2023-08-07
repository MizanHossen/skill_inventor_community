import 'package:flutter/material.dart';
import 'package:skill_inventor_community/utils/colors.dart';
import 'package:skill_inventor_community/widgets/custom_container.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final FocusNode? focusNode;
  const TextFieldInput({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final InputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(5));
    return CustomContainer(
      child: TextField(
        cursorColor: Colors.black,
        style: const TextStyle(color: Colors.black),
        controller: textEditingController,
        keyboardType: textInputType,
        obscureText: isPass,
        focusNode: focusNode,
        decoration: InputDecoration(
          fillColor: primaryColor,
          contentPadding: const EdgeInsets.only(left: 20),
          hintText: hintText,
          border: InputBorder,
          focusedBorder: InputBorder,
          enabledBorder: InputBorder,
          filled: true,
          hintStyle: const TextStyle(color: hintTextColor),

          //contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
