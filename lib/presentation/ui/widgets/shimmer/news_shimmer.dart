import 'package:flutter/material.dart';

import '../../../../core/utils/extensions/context_extension.dart';
import '../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import 'common_shimmer.dart';

class NewsShimmer extends StatelessWidget {
  const NewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding:
              UIDimensions.onlyPaddingInsets(bottom: 8, left: 16, right: 16),
          child: CommonShimmer(height: 100, width: context.screenWidth),
        );
      },
    );
  }
}
