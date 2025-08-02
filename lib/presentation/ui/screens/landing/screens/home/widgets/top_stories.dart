import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../../domain/enums/tab_type.dart';
import '../../../../../../../domain/models/news/news.dart';
import '../../../../../../../domain/states/news_state.dart';
import '../../../../../../providers/landing_provider.dart';
import '../../../../../../providers/news/news_provider.dart';
import '../../../../../widgets/error_cards/something_went_wrong_card.dart';
import '../../../../../widgets/header.dart';
import '../../../../../widgets/shimmer/news_shimmer.dart';
import 'news_container.dart';

class TopStoriesWidget extends ConsumerStatefulWidget {
  final Widget? header;
  const TopStoriesWidget({super.key, this.header});

  @override
  ConsumerState<TopStoriesWidget> createState() => _TopStoriesWidgetState();
}

class _TopStoriesWidgetState extends ConsumerState<TopStoriesWidget> {
  @override
  Widget build(BuildContext context) {
    final newsState = ref.watch(topNewsNotifierProvider);
    return switch (newsState) {
      NewsStateInitial() => const SizedBox(),
      NewsStateLoading() => const NewsShimmer(),
      NewsStateLoaded(news: List<NewsData> news, isFetching: bool _) => news
              .isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIDimensions.verticalSpace(12),
                widget.header ??
                    Header(
                      title: "Top",
                      subTitle: "Stories",
                      titleColor:
                          context.customColors.secondaryOrange ?? Colors.white,
                      subTitleColor: context.colorScheme.onSurface,
                      arrowColor:
                          context.customColors.secondaryOrange ?? Colors.white,
                      onTap: () {
                        AutoTabsRouter.of(context)
                            .setActiveIndex(TabType.news.index);
                        ref
                            .read(tabIndexNotifierProvider.notifier)
                            .updateTo(TabType.values.firstWhere(
                              (element) => element.val == TabType.news.index,
                              orElse: () => TabType.homeTab,
                            ));
                      },
                    ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...List.generate(
                      news.length > 4 ? 4 : news.length,
                      (index) => Padding(
                        padding: UIDimensions.onlyPaddingInsets(
                            bottom: index == (news.length > 4 ? 4 : news.length)
                                ? 0
                                : 16),
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
                  ],
                ),
              ],
            )
          : const SizedBox.shrink(),
      NewsStateError() => SomethingWentWrongCard(onPressed: () {
          ref
              .read(newsNotifierProvider.notifier)
              .getNews(page: 1, perPage: 4, fetchMore: true);
        })
    };
  }
}
