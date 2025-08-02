import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/extensions/context_extension.dart';
import '../../../../core/utils/styles/dimensions/ui_dimensions.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({
    this.height = 48,
    this.width = 48,
    this.cornerRadius,
    super.key,
  });

  final double height;
  final double width;
  final double? cornerRadius;

  @override
  Widget build(BuildContext context) {
    return UIDimensions.sizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: context.colorScheme.primary,
        highlightColor: context.colorScheme.primaryContainer,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              UIDimensions.radius(cornerRadius ?? 16),
            ),
            color: context.colorScheme.background,
          ),
        ),
      ),
    );
  }
}
