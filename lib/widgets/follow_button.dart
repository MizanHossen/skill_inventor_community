import 'package:flutter/material.dart';
import 'package:skill_inventor_community/utils/colors.dart';
import 'package:skill_inventor_community/widgets/drop_container.dart';
import '../responsive/responsive.dart';

class FollowButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  final String text;

  const FollowButton(
      {super.key,
      this.function,
      required this.backgroundColor,
      required this.borderColor,
      required this.text,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return DropContainer(
      child: TextButton(
        onPressed: function,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.56,
          height: Responsive.isMobile(context) ? 30 : 35,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style:
                // ignore: prefer_const_constructors
                TextStyle(color: hintTextColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
