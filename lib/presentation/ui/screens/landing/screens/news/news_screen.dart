import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/utils/app_constants.dart';
import '../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../core/utils/assets_gen/fonts.gen.dart';
import '../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../domain/enums/banner_category.dart';
import '../../../../../../domain/enums/tab_type.dart';
import '../../../../../../domain/models/banner/banner.dart';
import '../../../../../../domain/models/news/news.dart';
import '../../../../../../domain/states/news_state.dart';
import '../../../../../../domain/states/banner_state.dart';
import '../../../../../providers/banners/banner_provider.dart';
import '../../../../../providers/landing_provider.dart';
import '../../../../../providers/news/news_provider.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/error_cards/something_went_wrong_card.dart';
import '../../../../widgets/shimmer/common_shimmer.dart';
import '../../../../widgets/shimmer/news_shimmer.dart';
import '../home/shimmers/banner_shimmer.dart';
import '../home/widgets/carousel_banner.dart';
import '../home/widgets/news_container.dart';
import 'widgets/news_carousel_banner.dart';

@RoutePage()
class NewsScreen extends ConsumerStatefulWidget {
  final bool isFromPushNotification;
  const NewsScreen({super.key, this.isFromPushNotification = false});

  @override
  ConsumerState<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends ConsumerState<NewsScreen> {
  late int perPage;
  late int page;
  late ScrollController _scrollController;
  @override
  void initState() {
    perPage = AppConstants.perPage;
    page = AppConstants.page;
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.hasClients &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        if ((ref.read(newsNotifierProvider) is NewsStateLoaded) &&
            ((ref.read(newsNotifierProvider) as NewsStateLoaded).isFetching)) {
          return;
        }
        perPage = AppConstants.perPage;
        page += AppConstants.page;
        ref
            .read(newsNotifierProvider.notifier)
            .getNews(page: page, perPage: perPage, fetchMore: true);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        if (widget.isFromPushNotification) {
          ref.read(topNewsNotifierProvider.notifier).getTopNews();
        }
        ref
            .read(newsNotifierProvider.notifier)
            .getNews(perPage: perPage, page: page);
        ref
            .read(bannerNotifierProvider(CategoryBanner.news.val).notifier)
            .getBanner();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.white,
      onRefresh: () async {
        //setting to all intial values on refresh
        page = AppConstants.page;
        perPage = AppConstants.perPage;
        ref.read(topNewsNotifierProvider.notifier).getTopNews();
        ref
            .read(newsNotifierProvider.notifier)
            .getNews(page: page, perPage: perPage);
        ref
            .read(bannerNotifierProvider(CategoryBanner.news.val).notifier)
            .getBanner();
      },
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            scrolledUnderElevation: 0.0,
            expandedHeight: kToolbarHeight + 100,
            toolbarHeight: kToolbarHeight + 90,
            automaticallyImplyLeading: false,
            flexibleSpace: Stack(
              children: [
                newsBanner(ref, context),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: CustomText.displayLarge(
                    "NEWS",
                    fontSize: 35,
                    fontFamily: FontFamily.cplt20,
                    color: context.customColors.secondaryOrange,
                  ),
                ),
                Positioned(
                    top: 10, right: 0, child: Assets.images.topClip.image()),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: UIDimensions.verticalSpaceMedium,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: UIDimensions.onlyPaddingInsets(left: 16, bottom: 8),
              child: const CustomText.displaySmall("Top Stories"),
            ),
          ),
          SliverToBoxAdapter(
            child: newsCarousal(ref, context),
          ),
          const SliverToBoxAdapter(
            child: UIDimensions.verticalSpaceLarge,
          ),
          SliverToBoxAdapter(
            child: news(ref, context),
          )
        ],
      ),
    );
  }

  Widget newsCarousal(WidgetRef ref, BuildContext context) {
    final newsState = ref.watch(topNewsNotifierProvider);
    return switch (newsState) {
      NewsStateInitial() => const SizedBox(),
      NewsStateLoading() => const BannerShimmer(),
      NewsStateLoaded(news: List<NewsData> news) => news.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: news
                      .map((e) => NewsCarouselBanner(
                            title: e.title?.rendered,
                            publishedOn: e.date,
                            description: e.acf?.description,
                            bannerImage:
                                e.acf?.featuredImage?.sizes?.s2048x2048,
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: context.screenHeight * 0.35,
                    autoPlay: true,
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) {
                      ref
                          .read(carousalIndexNotifierProvider(TabType.news)
                              .notifier)
                          .updateTo(index);
                    },
                  ),
                ),
                UIDimensions.verticalSpaceMedium,
                Padding(
                  padding: UIDimensions.onlyPaddingInsets(left: 16),
                  child: indicators(
                      bannersLength: 4,
                      currentIndex: ref
                          .watch(carousalIndexNotifierProvider(TabType.news))),
                ),
              ],
            )
          : const Center(
              child: CustomText.headlineMedium("No News Available "),
            ),
      NewsStateError() => SomethingWentWrongCard(onPressed: () {
          ref
              .read(newsNotifierProvider.notifier)
              .getNews(page: page, perPage: perPage);
        })
    };
  }

  Widget news(WidgetRef ref, BuildContext context) {
    final newsState = ref.watch(newsNotifierProvider);
    return switch (newsState) {
      NewsStateInitial() => const NewsShimmer(),
      NewsStateLoading() => const NewsShimmer(),
      NewsStateLoaded(news: List<NewsData> news, isFetching: bool isFetching) =>
        news.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: UIDimensions.onlyPaddingInsets(
                        left: 16, bottom: 8, right: 16),
                    child: const CustomText.displaySmall("Latest News"),
                  ),
                  ...List.generate(
                    news.length,
                    (index) => Padding(
                      padding: UIDimensions.onlyPaddingInsets(bottom: 16),
                      child: NewsContainer(
                        title: news[index].title?.rendered,
                        publishedOn: news[index].date,
                        description: news[index].acf?.description,
                        shortDescription: news[index].acf?.shortDescription,
                        newsImageUrl: news[index].acf?.featuredImage?.url,
                        bannerImage:
                            news[index].acf?.featuredImage?.sizes?.s2048x2048,
                      ),
                    ),
                  ),
                  if (isFetching)
                    ...List.generate(
                      3,
                      (index) => Padding(
                        padding: UIDimensions.onlyPaddingInsets(
                            left: 16.0, right: 16, bottom: 16),
                        child: CommonShimmer(
                            height: 120, width: context.screenWidth),
                      ),
                    )
                ],
              )
            : const Center(
                child: CustomText.headlineMedium("No News Available "),
              ),
      NewsStateError() => SomethingWentWrongCard(onPressed: () {
          ref
              .read(newsNotifierProvider.notifier)
              .getNews(page: page, perPage: perPage);
        })
    };
  }
}

Widget newsBanner(WidgetRef ref, BuildContext context) {
  final newsBannerState =
      ref.watch(bannerNotifierProvider(CategoryBanner.news.val));
  switch (newsBannerState) {
    case BannerStateInitial():
      return SizedBox(
        child: CommonShimmer(
          height: 200,
          width: context.screenWidth,
          cornerRadius: 0,
        ),
      );
    case BannerStateLoading():
      return CommonShimmer(
          height: 200, width: context.screenWidth, cornerRadius: 0);
    case BannerStateLoaded(teamsBanner: BannerAcf? bannerData):
      return SizedBox(
        width: context.screenWidth,
        child: CachedNetworkImage(
          imageUrl: bannerData?.newsBannerImage?.sizes?.large ?? "",
          fit: BoxFit.fitWidth,
          placeholder: (context, url) {
            return CommonShimmer(
                height: 200, width: context.screenWidth, cornerRadius: 0);
          },
          errorWidget: (context, url, error) {
            return Assets.images.errorImage.image(
              height: 200,
              width: context.screenWidth,
              fit: BoxFit.fitWidth,
            );
          },
        ),
      );
    case BannerStateError():
      return const SizedBox();
  }
}
