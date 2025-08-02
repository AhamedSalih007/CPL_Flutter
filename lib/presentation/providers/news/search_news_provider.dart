import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/result/data_state.dart';
import '../../../domain/models/news/search_news/search_news.dart';
import '../../../domain/states/search_news_state.dart';
import '../../../domain/usecases/news/news_usecases.dart';

part 'search_news_provider.g.dart';

@riverpod
class SearchNewsNotifier extends _$SearchNewsNotifier {
  late final SearchNews _getSearchNews = ref.watch(searchNewsUseCaseProvider);
  @override
  SearchNewsState build() {
    return const SearchNewsStateInitial();
  }

  Future<void> getNewsBySearch({String? keyword}) async {
    state = const SearchNewsStateLoading();
    var dataState = await _getSearchNews(keyword);
    switch (dataState) {
      case DataStateSuccess<List<SearchNewsData>>(data: var matchesData):
        state = SearchNewsStateLoaded(news: matchesData);
      case DataStateError<List<SearchNewsData>>(ex: var ex):
        state = SearchNewsStateError(ex: ex);
    }
  }
}
