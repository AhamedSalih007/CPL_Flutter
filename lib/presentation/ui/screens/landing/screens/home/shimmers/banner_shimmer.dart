import 'package:flutter/material.dart';

import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../widgets/shimmer/common_shimmer.dart';

class BannerShimmer extends StatelessWidget {
  const BannerShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: UIDimensions.symmetricPaddingInsets(horizontal: 12),
      height: context.screenHeight * 0.4,
      width: context.screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.customColors.black40Color,
          border: Border.all(color: context.colorScheme.tertiary)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CommonShimmer(
            height: context.screenHeight * 0.14,
            width: context.screenWidth,
            cornerRadius: 8,
          ),
          const Spacer(),
          Padding(
            padding: UIDimensions.allPaddingInsets(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonShimmer(
                  height: 24,
                  width: context.screenWidth * 0.32,
                ),
                UIDimensions.verticalSpaceSmall,
                CommonShimmer(height: 24, width: context.screenWidth * 0.3),
                UIDimensions.verticalSpaceLarge,
                CommonShimmer(height: 12, width: context.screenWidth * 0.6),
                UIDimensions.verticalSpaceSmall,
                CommonShimmer(height: 12, width: context.screenWidth * 0.52),
                UIDimensions.verticalSpace(context.screenHeight * 0.04),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonShimmer(height: 8, width: 40),
                    CommonShimmer(height: 12, width: 80)
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
