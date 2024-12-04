import 'package:finkart/features/shared/colors/colors.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.marginTop = 0.0,
    this.marginBottom = 0.0,
    this.marginLeft = 0.0,
    this.marginRight = 0.0,
    this.size = 30.0,
    this.color = textColor,
    this.onPressed,
    required this.icon,
    this.width,
    this.height,
    this.highlightColor,
  });
  final IconData icon;
  final Color color;
  final Color? highlightColor;

  final double size;
  final VoidCallback? onPressed;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        margin: EdgeInsets.only(
            top: marginTop,
            left: marginLeft,
            right: marginRight,
            bottom: marginBottom),
        child: IconButton(
            highlightColor: highlightColor,
            onPressed: onPressed,
            icon: Icon(
              size: size,
              icon,
              color: color,
            )));
  }
}
