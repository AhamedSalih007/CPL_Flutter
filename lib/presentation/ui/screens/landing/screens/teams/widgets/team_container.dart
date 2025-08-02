import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../widgets/shimmer/common_shimmer.dart';
import '../../../../../widgets/text_html.dart';

class TeamContainer extends ConsumerWidget {
  final String imageUrl;
  final String title;
  const TeamContainer({super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: UIDimensions.allPaddingInsets(16),
      decoration: BoxDecoration(
        color: context.customColors.purpleVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.secondary,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            height: 80,
            width: 80,
            fit: BoxFit.contain,
            placeholder: (context, url) {
              return const CommonShimmer(
                height: 65,
                width: 65,
                cornerRadius: 8,
              );
            },
            errorWidget: (context, url, error) {
              return Assets.images.errorImage.image(
                height: 65,
                width: 65,
              );
            },
          ),
          //UIDimensions.verticalSpaceMedium,
          Center(
            child: SizedBox(
                width: context.screenWidth * 0.4,
                child: TextHtml(
                  text: "<p>$title</p>",
                  style: {
                    "p": Style(
                      color: context.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    )
                  },
                )),
          )
        ],
      ),
    );
  }
}
