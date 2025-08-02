import 'package:flutter/material.dart';

import '../../../../core/utils/extensions/context_extension.dart';
import '../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import 'common_shimmer.dart';

class TeamsShimmer extends StatelessWidget {
  const TeamsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: UIDimensions.allPaddingInsets(20),
      crossAxisSpacing: 16,
      mainAxisSpacing: 20,
      crossAxisCount: 2,
      childAspectRatio: 0.9,
      children: <Widget>[
        ...List.generate(
            4,
            (index) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: context.customColors.grey3Color ??
                              context.colorScheme.surface)),
                  child: CommonShimmer(
                    height: 150,
                    width: context.screenWidth * 0.45,
                    color: context.customColors.white10Color,
                  ),
                )),
      ],
    );
  }
}
