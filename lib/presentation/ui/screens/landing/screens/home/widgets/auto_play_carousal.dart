import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../domain/enums/tab_type.dart';
import '../../../../../../../domain/models/marketing_banner/marketing_banner.dart';
import '../../../../../../../domain/states/marketing_banners_state.dart';
import '../../../../../../providers/banners/banner_provider.dart';
import '../../../../../../providers/landing_provider.dart';
import '../../../../../widgets/error_cards/something_went_wrong_card.dart';
import '../shimmers/banner_shimmer.dart';
import 'carousel_banner.dart';

class AutoPlayCarousal extends ConsumerStatefulWidget {
  const AutoPlayCarousal({super.key});

  @override
  ConsumerState<AutoPlayCarousal> createState() => _AutoPlayCarousalState();
}

class _AutoPlayCarousalState extends ConsumerState<AutoPlayCarousal> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(marketingBannerNotifierProvider.notifier).getMarketingBanners();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bannersState = ref.watch(marketingBannerNotifierProvider);
    List<Color> titleColors = [
      context.colorScheme.secondary,
      context.colorScheme.onSurface,
      context.colorScheme.tertiary
    ];

    List<Color> subTitleColors = [
      context.colorScheme.onSurface,
      context.customColors.secondaryYellow ?? Colors.white,
      context.colorScheme.onSurface
    ];

    List<Color> arrowColor = [
      context.colorScheme.secondary,
      context.customColors.secondaryYellow ?? Colors.white,
      context.colorScheme.tertiary
    ];
    return switch (bannersState) {
      MarketingBannerStateInitial() => const BannerShimmer(),
      MarketingBannerStateLoading() => const BannerShimmer(),
      MarketingBannerStateLoaded(banners: var banners) => banners.isNotEmpty
          ? CarouselSlider(
              items: banners.map((e) {
                return CarouselBanner(
                  titleColor: titleColors[getIndex(e, titleColors)],
                  subTitleColor: subTitleColors[getIndex(e, subTitleColors)],
                  arrowColor: arrowColor[getIndex(e, arrowColor)],
                  banner: e,
                  bannersLength: banners.length,
                );
              }).toList(),
              options: CarouselOptions(
                height: context.screenHeight * 0.4,
                autoPlay: true,
                viewportFraction: 0.95,
                onPageChanged: (index, reason) {
                  ref
                      .read(carousalIndexNotifierProvider(TabType.homeTab)
                          .notifier)
                      .updateTo(index);
                },
              ),
            )
          : const Center(
              child: Text("No Marketing Banners Available"),
            ),
      MarketingBannerStateError(ex: _) => SomethingWentWrongCard(
          onPressed: () {
            ref
                .read(marketingBannerNotifierProvider.notifier)
                .getMarketingBanners();
          },
        )
    };
  }
}

int getIndex(MarketingBanner e, List<Color> colorsList) {
  return int.tryParse(((int.tryParse(
                      e.bannerOrder != null && e.bannerOrder!.isNotEmpty
                          ? e.bannerOrder.toString()
                          : "0") ??
                  0) %
              colorsList.length)
          .toInt()
          .toString()) ??
      0;
}
