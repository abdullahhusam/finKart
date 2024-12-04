import 'package:finkart/features/shared/colors/colors.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final double marginAll;
  const CustomContainer({
    super.key,
    required this.child,
    this.height,
    this.marginTop = 0,
    this.marginBottom = 0,
    this.marginLeft = 0,
    this.marginRight = 0,
    this.marginAll = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: marginAll > 0
          ? EdgeInsets.all(marginAll)
          : EdgeInsets.only(
              top: marginTop,
              left: marginLeft,
              right: marginRight,
              bottom: marginBottom),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: lightGreyColor),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          // BoxShadow(
          //   spreadRadius: 8,
          //   color: Colors.black12,
          //   blurRadius: 20,
          //   offset: Offset(0, 25),
          // ),
        ],
      ),
      child: child,
    );
  }
}
