import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../core/router/app_router.dart';
import '../../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/extensions/date_time_extension.dart';
import '../../../../../../../core/utils/extensions/string_extensions.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../providers/core/router_provider.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/shimmer/common_shimmer.dart';

class NewsCarouselBanner extends ConsumerWidget {
  final String? bannerImage;
  final String? title;
  final String? publishedOn;
  final String? description;
  final int? featureImage;
  const NewsCarouselBanner(
      {super.key,
      required this.bannerImage,
      this.title,
      this.description,
      this.publishedOn,
      this.featureImage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: UIDimensions.onlyPaddingInsets(right: 16),
      child: InkWell(
        onTap: () => ref.read(appRouterProvider).push(NewsDetailRoute(
              bannerImage: bannerImage,
              description: description,
              featureImage: featureImage,
              publishedOn: publishedOn,
              title: title,
            )),
        child: IntrinsicHeight(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color:
                        context.customColors.secondaryOrange ?? Colors.orange),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    child: SizedBox(
                      height: context.screenHeight * 0.2,
                      width: context.screenWidth,
                      child: CachedNetworkImage(
                          placeholder: (context, url) {
                            return Padding(
                              padding: UIDimensions.symmetricPaddingInsets(
                                  horizontal: 16),
                              child: CommonShimmer(
                                  height: 100, width: context.screenWidth),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Assets.images.errorImage.image(
                                height: context.screenHeight * 0.2,
                                width: context.screenWidth);
                          },
                          fit: BoxFit.cover,
                          imageUrl: bannerImage ?? ""),
                    )),
                UIDimensions.verticalSpaceSmall,
                Padding(
                  padding: UIDimensions.onlyPaddingInsets(
                      top: 12, left: 12, right: 12, bottom: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: context.screenWidth,
                        child: CustomText.headlineSmall(
                          title ?? "",
                          maxLines: 2,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      UIDimensions.verticalSpaceMedium,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText.titleMedium(
                              publishedOn?.yyyyMMDD.yMMMMd ?? ""),
                          CustomText.titleMedium(
                            "Read more",
                            color: context.colorScheme.primaryContainer,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
