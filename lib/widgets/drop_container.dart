import 'package:flutter/material.dart';

class DropContainer extends StatelessWidget {
  final Widget child;
  const DropContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffECF0F3),
          // color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
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
      child: child,
    );
  }
}
