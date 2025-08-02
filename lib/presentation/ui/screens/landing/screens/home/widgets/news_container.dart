import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../core/router/app_router.dart';
import '../../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/extensions/date_time_extension.dart';
import '../../../../../../../core/utils/extensions/string_extensions.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/shimmer/image_place_holder.dart';

class NewsContainer extends ConsumerStatefulWidget {
  //final NewsData newsData;
  final String? newsImageUrl;
  final String? shortDescription;
  final String? description;
  final String? publishedOn;
  final String? bannerImage;
  final String? title;
  final bool isImageVisible;
  final int? featureImage;
  const NewsContainer({
    super.key,
    this.newsImageUrl,
    this.description,
    this.publishedOn,
    this.shortDescription,
    this.bannerImage,
    this.title,
    this.isImageVisible = true,
    this.featureImage,
  });

  @override
  ConsumerState<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends ConsumerState<NewsContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIDimensions.symmetricPaddingInsets(horizontal: 16),
      child: Card(
        margin: EdgeInsets.zero,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            context.pushRoute(NewsDetailRoute(
              title: widget.title,
              bannerImage: widget.bannerImage,
              description: widget.description,
              publishedOn: widget.publishedOn,
              featureImage: widget.featureImage,
            ));
          },
          child: IntrinsicHeight(
            child: Container(
              decoration: BoxDecoration(
                  color: context.customColors.black10Color,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: context.customColors.secondaryOrange ??
                          Colors.white)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntrinsicHeight(
                      child: Visibility(
                    visible: widget.isImageVisible,
                    child: SizedBox(
                      width: context.screenWidth * 0.33,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            topLeft: Radius.circular(12)),
                        child: CachedNetworkImage(
                          imageUrl: widget.newsImageUrl ?? "",
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return Assets.images.errorImage.image(
                              fit: BoxFit.cover,
                              width: context.screenWidth * 0.33,
                            );
                          },
                          placeholder: (context, url) {
                            return const ImagePlaceholder(
                              height: 100,
                            );
                          },
                        ),
                      ),
                    ),
                  )),
                  UIDimensions.horizontalSpaceSmall,
                  Expanded(
                    child: Padding(
                      padding: UIDimensions.onlyPaddingInsets(right: 8),
                      child: Column(
                        children: [
                          UIDimensions.verticalSpaceMedium,
                          CustomText.bodyMedium(
                            widget.title ?? "",
                            maxLines: 3,
                          ),
                          UIDimensions.verticalSpace(16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText.bodyMedium(
                                  widget.publishedOn?.yyyyMMDD.yMMMMd ?? ""),
                              CustomText.bodyMedium(
                                "Read More",
                                color: context.colorScheme.primaryContainer,
                              )
                            ],
                          ),
                          UIDimensions.verticalSpaceMedium,
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
