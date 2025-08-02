import 'package:flutter/material.dart';

import '../../../core/utils/extensions/context_extension.dart';

class CircularIcon extends StatelessWidget {
  final Widget icon;
  final Color? bgColor;
  final Color? borderColor;
  final double height;
  final double width;
  const CircularIcon(
      {super.key,
      required this.icon,
      this.bgColor,
      this.borderColor,
      this.height = 60,
      this.width = 60});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border:
              Border.all(color: (borderColor ?? bgColor) ?? Colors.transparent),
          color: bgColor ?? context.customColors.grey2Color,
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: icon,
        )));
  }
}
