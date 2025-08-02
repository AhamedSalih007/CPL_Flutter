import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../core/utils/assets_gen/fonts.gen.dart';
import '../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../core/utils/extensions/date_time_extension.dart';
import '../../../../../../core/utils/extensions/string_extensions.dart';
import '../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../domain/models/media/media.dart';
import '../../../../../../domain/states/media_state.dart';
import '../../../../../providers/media/media_provider.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/error_cards/something_went_wrong_card.dart';
import '../../../../widgets/shimmer/common_shimmer.dart';
import '../../../../widgets/text_html.dart';

@RoutePage()
class NewsDetailScreen extends ConsumerStatefulWidget {
  //final NewsData news;
  final String? bannerImage;
  final String? title;
  final String? publishedOn;
  final String? description;
  final int? featureImage;
  const NewsDetailScreen(
      {super.key,
      required this.bannerImage,
      this.title,
      this.description,
      this.publishedOn,
      this.featureImage});

  @override
  ConsumerState<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends ConsumerState<NewsDetailScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(mediaNotifierProvider.notifier)
          .getMedia(mediaId: widget.featureImage);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaState = ref.watch(mediaNotifierProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            context.maybePop();
          },
          child: const Icon(
            Icons.keyboard_arrow_left,
            size: 24,
          ),
        ),
        elevation: 0,
        toolbarHeight: kToolbarHeight + 24,
        backgroundColor: Colors.transparent,
        flexibleSpace: Align(
          alignment: Alignment.topRight,
          child: Assets.images.bottomCorner.image(height: 140),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          if (widget.featureImage != null)
            switch (mediaState) {
              MediaStateInitial() => CommonShimmer(
                  height: context.screenHeight * 0.3,
                  width: context.screenWidth,
                  cornerRadius: 0,
                ),
              MediaStateLoading() => CommonShimmer(
                  height: context.screenHeight * 0.3,
                  width: context.screenWidth,
                  cornerRadius: 0,
                ),
              MediaStateLoaded(media: MediaDetails? media) => SizedBox(
                  height: context.screenHeight * 0.3,
                  width: context.screenWidth,
                  child: CachedNetworkImage(
                    placeholder: (context, url) {
                      return CommonShimmer(
                        height: context.screenHeight * 0.3,
                        width: context.screenWidth,
                        cornerRadius: 0,
                      );
                    },
                    fit: BoxFit.fill,
                    imageUrl: media?.sizes?.mediumLarge?.sourceUrl ?? "",
                    errorWidget: (context, url, error) {
                      return Assets.images.errorImage.image(
                        height: context.screenHeight * 0.3,
                        width: context.screenWidth,
                      );
                    },
                  ),
                ),
              MediaStateError() => SomethingWentWrongCard(
                  onPressed: () => ref
                      .read(mediaNotifierProvider.notifier)
                      .getMedia(mediaId: widget.featureImage),
                ),
            }
          else
            SizedBox(
              // height: context.screenHeight * 0.2,
              width: context.screenWidth,
              child: CachedNetworkImage(
                  placeholder: (context, url) {
                    return Padding(
                      padding:
                          UIDimensions.symmetricPaddingInsets(horizontal: 16),
                      child: CommonShimmer(
                          height: 100, width: context.screenWidth),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Assets.images.errorImage.image(
                      height: 100,
                      width: context.screenWidth,
                    );
                  },
                  fit: BoxFit.cover,
                  imageUrl: widget.bannerImage ?? ""),
            ),
          Padding(
            padding: UIDimensions.allPaddingInsets(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: context.screenWidth,
                  child: CustomText.headlineSmall(
                    widget.title?.toString() ?? "",
                    fontFamily: FontFamily.cplt20,
                    color: context.colorScheme.tertiary,
                    maxLines: 4,
                  ),
                ),
                UIDimensions.verticalSpaceMedium,
                CustomText.titleMedium(
                    widget.publishedOn?.yyyyMMDD.yMMMMd ?? ""),
                UIDimensions.verticalSpaceMedium,
                SizedBox(
                  width: context.screenWidth,
                  child: TextHtml(
                    text: widget.description ?? "",
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
