import 'package:flutter/foundation.dart';

import '../../core/utils/errors/app_exception.dart';
import '../models/news/search_news/search_news.dart';

@immutable
sealed class SearchNewsState {
  const SearchNewsState();
}

final class SearchNewsStateInitial extends SearchNewsState {
  const SearchNewsStateInitial();
}

final class SearchNewsStateLoading extends SearchNewsState {
  const SearchNewsStateLoading();
}

final class SearchNewsStateLoaded extends SearchNewsState {
  const SearchNewsStateLoaded({
    required this.news,
  });

  final List<SearchNewsData> news;
}

final class SearchNewsStateError extends SearchNewsState {
  const SearchNewsStateError({required this.ex});
  final AppException ex;
}

extension SearchNewsStateExtention on SearchNewsState {
  List<SearchNewsData>? get news => switch (this) {
        SearchNewsStateInitial() => null,
        SearchNewsStateLoading() => null,
        SearchNewsStateLoaded(news: List<SearchNewsData> news) => news,
        SearchNewsStateError() => null,
      };
}
