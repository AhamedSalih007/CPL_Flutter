import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/utils/extensions/context_extension.dart';
import '../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import 'common_shimmer.dart';

class MatchDetailsShimmer extends StatelessWidget {
  const MatchDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CommonShimmer(
          height: context.screenHeight * 0.3,
          width: context.screenWidth,
          cornerRadius: 0,
        ),
        UIDimensions.verticalSpaceMedium,
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CommonShimmer(height: 30, width: 50),
            CommonShimmer(height: 30, width: 80),
            CommonShimmer(height: 30, width: 80),
            CommonShimmer(height: 30, width: 50),
          ],
        ),
        UIDimensions.verticalSpaceMedium,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CommonShimmer(
            height: context.screenHeight * 0.5,
            width: context.screenWidth,
          ),
        ),
      ],
    );
  }
}
