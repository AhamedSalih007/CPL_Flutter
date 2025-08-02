import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/utils/extensions/context_extension.dart';
import '../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import 'common_shimmer.dart';

class PartnersShimmer extends StatelessWidget {
  const PartnersShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...List.generate(
          3,
          (index) => Column(
            children: [
              CommonShimmer(height: 30, width: context.screenWidth * 0.5),
              UIDimensions.verticalSpaceSmall,
              Wrap(
                alignment: WrapAlignment.center,
                spacing: UIDimensions.width(60),
                runSpacing: UIDimensions.height(20),
                children: [
                  ...List.generate(
                    2,
                    (index) => const CommonShimmer(height: 50, width: 100),
                  )
                ],
              ),
              UIDimensions.verticalSpaceLarge,
            ],
          ),
        )
      ],
    );
  }
}
