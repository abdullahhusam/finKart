import 'package:finkart/features/shared/colors/colors.dart';
import 'package:finkart/utils/constants.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    this.marginTop = 10.0,
    this.marginBottom = 0.0,
    this.marginLeft = 0.0,
    this.marginRight = 0.0,
    this.text = "",
    this.fontWeight = FontWeight.w700,
    this.fontSize = 14.0,
    this.fontColor = blackColor,
    this.backgroundColor = whiteColor,
    this.disabledBackgroundColor = disabledPrimaryColor,
    this.onPressed,
  });
  final String text;
  final Color fontColor;
  final Color backgroundColor;
  final Color disabledBackgroundColor;
  final double fontSize;
  final VoidCallback? onPressed;
  final FontWeight fontWeight;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: marginTop,
          left: marginLeft,
          right: marginRight,
          bottom: marginBottom),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.only(left: 15, right: 15),
          side: const BorderSide(color: authBorderColor),
          disabledBackgroundColor: disabledBackgroundColor,
          backgroundColor: backgroundColor,
          minimumSize: const Size(double.infinity, authContainerHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: fontSize, color: fontColor, fontWeight: fontWeight),
        ),
      ),
    );
  }
}
