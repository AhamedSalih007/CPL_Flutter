import 'package:flutter/material.dart';

import '../../../../core/utils/extensions/context_extension.dart';
import 'common_shimmer.dart';

class CommentaryShimmer extends StatelessWidget {
  const CommentaryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: CommonShimmer(
        height: context.screenHeight * 0.5,
        width: context.screenWidth,
      ),
    );
  }
}
