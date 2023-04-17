import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  const CustomContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color(0xffECF0F3),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            //bottom right shadow is darker shadow
            BoxShadow(
              blurStyle: BlurStyle.inner,
              color: Color(0xffF3F5F7),
              offset: Offset(5, 5),
              blurRadius: 10,
              //spreadRadius: 1,
            ),

            //top left shaow lighter
            BoxShadow(
              blurStyle: BlurStyle.inner,
              //color: Color(0xFFbebebe),
              color: Color(0xFFE4E8ED),
              offset: Offset(-5, -5),
              blurRadius: 5,
              // spreadRadius: 1,
            ),
          ]),
      child: child,
    );
  }
}
