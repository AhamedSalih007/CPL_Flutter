import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../domain/models/news/search_news/search_news.dart';
import '../../../../../../domain/states/search_news_state.dart';
import '../../../../../providers/news/search_news_provider.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/error_cards/something_went_wrong_card.dart';
import '../../../../widgets/shimmer/news_shimmer.dart';
import 'widgets/news_container.dart';

@RoutePage()
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late TextEditingController searchWord;
  @override
  void initState() {
    searchWord = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchList = ref.watch(searchNewsNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.primary,
        leading: Padding(
          padding: UIDimensions.onlyPaddingInsets(left: 16),
          child: InkWell(
            onTap: () async => await context.maybePop(),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 16,
            ),
          ),
        ),
        leadingWidth: 30,
        title: Container(
          constraints: BoxConstraints(
            minHeight: 40,
            maxHeight: 50,
            minWidth: 200,
            maxWidth: context.screenWidth * 0.9,
          ),
          decoration: BoxDecoration(
            color: context.customColors.black40Color,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: TextField(
            controller: searchWord,
            autofocus: true,
            cursorHeight: 20,
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
            ),
            onSubmitted: (value) => ref
                .read(searchNewsNotifierProvider.notifier)
                .getNewsBySearch(keyword: value),
          ),
        ),
      ),
      backgroundColor: context.colorScheme.primary,
      body: switch (searchList) {
        SearchNewsStateInitial() =>
          const Center(child: Text('No news available')),
        SearchNewsStateLoading() => const NewsShimmer(),
        SearchNewsStateLoaded(news: List<SearchNewsData>? news) => news
                .isNotEmpty
            ? ListView(
                shrinkWrap: true,
                children: [
                  UIDimensions.verticalSpaceMedium,
                  Padding(
                    padding:
                        UIDimensions.symmetricPaddingInsets(horizontal: 24),
                    child: CustomText.displaySmall(
                      "Search results",
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  UIDimensions.verticalSpaceMedium,
                  ...List.generate(
                    news.length,
                    (index) => Padding(
                      padding: UIDimensions.onlyPaddingInsets(bottom: 16),
                      child: NewsContainer(
                        isImageVisible: false,
                        title: news[index].title,
                        featureImage: news[index]
                            .eEmbedded
                            ?.self
                            ?.first
                            .acf
                            ?.featuredImage,
                        newsImageUrl: news[index].url,
                        description:
                            news[index].eEmbedded?.self?.first.acf?.description,
                        shortDescription: news[index]
                            .eEmbedded
                            ?.self
                            ?.first
                            .acf
                            ?.shortDescription,
                        publishedOn: news[index].eEmbedded?.self?.first.date,
                      ),
                    ),
                  )
                ],
              )
            : const Center(
                child: Text('No news available'),
              ),
        SearchNewsStateError() => SomethingWentWrongCard(
            onPressed: () => ref
                .read(searchNewsNotifierProvider.notifier)
                .getNewsBySearch(keyword: searchWord.text),
          )
      },
    );
  }
}
