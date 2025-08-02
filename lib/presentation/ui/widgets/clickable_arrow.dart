import 'package:flutter/material.dart';

import '../../../core/utils/assets_gen/assets.gen.dart';

class ClickableArrow extends StatelessWidget {
  final Color color;
  final int? itemCount;
  final void Function()? onTap;
  const ClickableArrow(
      {super.key, required this.color, this.itemCount, this.onTap});

  @override
  Widget build(BuildContext context) {
    List<double> opacity = [0.05, 0.1, 0.2, 0.3, 1];
    return InkWell(
      onTap: onTap,
      child: SizedBox(
          //HEIGHT
          height: 70,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: itemCount ?? 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: index == 4 ? 0 : 12),
                child: Opacity(
                  opacity: opacity[index],
                  child: Assets.icons.arrow.svg(
                      height: 25,
                      width: 30,
                      colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
                ),
              );
            },
          )),
    );
  }
}
