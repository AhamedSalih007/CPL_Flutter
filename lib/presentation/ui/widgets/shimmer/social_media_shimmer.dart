import 'package:flutter/material.dart';

import '../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import 'common_shimmer.dart';

class SocialMediaShimmer extends StatelessWidget {
  const SocialMediaShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
            4,
            (index) => Row(
                  children: [
                    CommonShimmer(
                      height: 40,
                      width: 40,
                      cornerRadius: UIDimensions.radius(999),
                    ),
                    UIDimensions.horizontalSpaceMedium,
                  ],
                ))
      ],
    );
  }
}
