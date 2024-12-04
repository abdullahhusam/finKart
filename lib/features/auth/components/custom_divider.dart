import 'package:flutter/material.dart';

import '../../shared/colors/colors.dart';
import '../../shared/components/custom_text.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.marginTop = 0,
    this.marginBottom = 0,
    this.marginLeft = 0,
    this.marginRight = 0,
  });
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
      child: Row(children: <Widget>[
        Expanded(
          child: Container(
              margin: const EdgeInsets.only(left: 10.0, right: 7.0),
              child: const Divider(
                color: dividerColor,
                height: 20,
              )),
        ),
        const CustomText(
          text: "or",
          color: blackColor,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        Expanded(
          child: Container(
              margin: const EdgeInsets.only(left: 7.0, right: 10.0),
              child: const Divider(
                color: dividerColor,
                height: 20,
              )),
        ),
      ]),
    );
  }
}
