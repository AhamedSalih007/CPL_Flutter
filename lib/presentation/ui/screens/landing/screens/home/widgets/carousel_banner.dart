import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../../core/utils/assets_gen/fonts.gen.dart';
import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../../domain/enums/tab_type.dart';
import '../../../../../../../domain/models/marketing_banner/marketing_banner.dart';
import '../../../../../../providers/landing_provider.dart';
import '../../../../../modals/snack_bar/snack_bar_factory.dart';
import '../../../../../widgets/custom_text.dart';
import 'carousel_heading.dart';

class CarouselBanner extends ConsumerWidget {
  final Color titleColor;
  final Color subTitleColor;
  final Color arrowColor;
  final MarketingBanner banner;
  final int bannersLength;
  const CarouselBanner({
    super.key,
    required this.titleColor,
    required this.subTitleColor,
    required this.arrowColor,
    required this.banner,
    required this.bannersLength,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          height: context.screenHeight * 0.5,
          width: context.screenWidth - UIDimensions.width(32),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    banner.bannerImage ?? "",
                  ),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: arrowColor)),
        ),
        Container(
          height: context.screenHeight * 0.5,
          width: context.screenWidth - UIDimensions.width(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: arrowColor),
            gradient: context.customColors.primaryBoxGradient,
          ),
        ),
        Positioned(
            left: 16,
            right: 16,
            top: ((banner.bannerTitle1?.isNotEmpty ?? false) &&
                    (banner.bannerTitle2?.isNotEmpty ?? false) &&
                    (banner.bannerDescription?.isNotEmpty ?? false))
                ? context.screenHeight * 0.2
                : context.screenHeight * 0.25,
            child: CarouselHeading(
              title: banner.bannerTitle1 ?? "",
              subTitle: banner.bannerTitle2 ?? "",
              quote: banner.bannerDescription ?? "",
              titleColor: titleColor,
              subTitleColor: subTitleColor,
            )),
        Positioned(
          left: 16,
          bottom: 20,
          child: indicators(
              bannersLength: bannersLength,
              currentIndex:
                  ref.watch(carousalIndexNotifierProvider(TabType.homeTab))),
        ),
        Positioned(
            right: 16,
            bottom: 20,
            child: InkWell(
              onTap: () async {
                if (banner.buttonUrl != null) {
                  final Uri url = Uri.parse(banner.buttonUrl ?? "");
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    if (context.mounted) {
                      SnackbarFactory.showError("Can not launch URL");
                    }
                  }
                }
              },
              child: Row(
                children: [
                  Padding(
                    padding: UIDimensions.onlyPaddingInsets(top: 2),
                    child: CustomText.titleSmall(
                      banner.buttonText ?? "".toUpperCase(),
                      color: arrowColor,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.cplt20,
                    ),
                  ),
                  UIDimensions.horizontalSpaceSmall,
                  Assets.icons.arrow.svg(
                      colorFilter:
                          ColorFilter.mode(arrowColor, BlendMode.srcIn))
                ],
              ),
            )),
        clippedImage(ref, context),
      ],
    );
  }
}

Widget indicators({required int bannersLength, required int currentIndex}) {
  return SizedBox(
    child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(bannersLength, (index) {
          return Padding(
            padding: UIDimensions.symmetricPaddingInsets(horizontal: 4),
            child: Container(
              width: currentIndex == index ? 6 : 4,
              height: currentIndex == index ? 6 : 4,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          );
        })),
  );
}

Widget clippedImage(WidgetRef ref, BuildContext context) {
  int fixedBannerLength = 3;
  int currentIndex = ref.watch(carousalIndexNotifierProvider(TabType.homeTab)) %
      fixedBannerLength;
  switch (currentIndex) {
    case 0:
      return Positioned(
        top: 0,
        left: 0,
        child:
            Assets.images.bottomRight.image(height: context.screenHeight * 0.2),
      );
    case 1:
      return Positioned(
        top: 0,
        right: 0,
        child: ClipRRect(
            borderRadius: const BorderRadius.only(topRight: Radius.circular(8)),
            child: Assets.images.bottomLeft
                .image(height: context.screenHeight * 0.2)),
      );
    case 2:
      return Positioned(
        top: 0,
        right: 0,
        child: ClipRRect(
            borderRadius: const BorderRadius.only(topRight: Radius.circular(8)),
            child: Assets.images.topLeft
                .image(height: context.screenHeight * 0.2)),
      );
    default:
      return Positioned(
        top: 0,
        left: 0,
        child:
            Assets.images.bottomRight.image(height: context.screenHeight * 0.2),
      );
  }
}
