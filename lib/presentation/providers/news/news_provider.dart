import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/app_constants.dart';
import '../../../data/models/result/data_state.dart';
import '../../../domain/models/news/news.dart';
import '../../../domain/states/news_state.dart';
import '../../../domain/usecases/news/news_usecases.dart';

part 'news_provider.g.dart';

@Riverpod(keepAlive: true)
class NewsNotifier extends _$NewsNotifier {
  late final GetNews _getNews = ref.watch(getNewsUseCaseProvider);

  final List<NewsData> _news = [];
  //bool isDataAvailable = true;

  @override
  NewsState build() {
    return const NewsStateInitial();
  }

  Future<void> getHomeNews() async {
    state = const NewsStateLoading();
    var respo = await _getNews(
        NewsParams(perPage: AppConstants.perPage, page: AppConstants.page));
    switch (respo) {
      case DataStateSuccess<List<NewsData>>(data: List<NewsData> data):
        state = NewsStateLoaded(news: data);
      case DataStateError<List<NewsData>>(ex: var ex):
        state = NewsStateError(ex: ex);
    }
  }

  Future<void> getNews({
    required int perPage,
    required int page,
    bool fetchMore = false,
  }) async {
    state = fetchMore
        ? NewsStateLoaded(news: _news, isFetching: true)
        : const NewsStateLoading();

    var respo = await _getNews(NewsParams(perPage: perPage, page: page));
    switch (respo) {
      case DataStateSuccess<List<NewsData>>(data: List<NewsData> data):
        if (!fetchMore) {
          _news.clear();
        }
        if (data.isEmpty) {
          // isDataAvailable = false;
          state = NewsStateLoaded(news: _news, isFetching: false);
          return;
        }
        _news.addAll(data);
        state = NewsStateLoaded(news: _news, isFetching: false);
        break;
      case DataStateError<List<NewsData>>(ex: var ex):
        state = NewsStateError(ex: ex);
    }
  }
}

@Riverpod(keepAlive: true)
class TopNewsNotifier extends _$TopNewsNotifier {
  late final GetNews _getNews = ref.watch(getNewsUseCaseProvider);

  @override
  NewsState build() {
    return const NewsStateInitial();
  }

  Future<void> getTopNews() async {
    state = const NewsStateLoading();
    var respo = await _getNews(
        NewsParams(perPage: AppConstants.perPage, page: AppConstants.page));
    switch (respo) {
      case DataStateSuccess<List<NewsData>>(data: List<NewsData> data):
        state = NewsStateLoaded(
            news: data.length > 4 ? data.getRange(0, 4).toList() : data);
      case DataStateError<List<NewsData>>(ex: var ex):
        state = NewsStateError(ex: ex);
    }
  }
}
