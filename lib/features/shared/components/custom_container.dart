import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final double marginAll;
  final double? circularBorder;
  final double topLeftBorder;
  final double topRightBorder;
  final double bottomLeftBorder;
  final double bottomRightBorder;
  final Color? color;

  const CustomContainer(
      {super.key,
      required this.child,
      this.height,
      this.marginTop = 0,
      this.marginBottom = 0,
      this.marginLeft = 0,
      this.marginRight = 0,
      this.marginAll = 0,
      this.width,
      this.borderRadius,
      this.circularBorder,
      this.topLeftBorder = 0,
      this.topRightBorder = 0,
      this.bottomLeftBorder = 0,
      this.bottomRightBorder = 0,
      this.color});

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
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius ??
            (circularBorder != null
                ? BorderRadius.circular(circularBorder!)
                : BorderRadius.only(
                    topLeft: Radius.circular(topLeftBorder),
                    topRight: Radius.circular(topRightBorder),
                    bottomRight: Radius.circular(bottomRightBorder),
                    bottomLeft: Radius.circular(bottomLeftBorder),
                  )),
        boxShadow: const [
          BoxShadow(
            spreadRadius: 8,
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, 25),
          ),
        ],
      ),
      child: child,
    );
  }
}
