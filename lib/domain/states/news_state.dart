import 'package:flutter/foundation.dart';

import '../../core/utils/errors/app_exception.dart';
import '../models/news/news.dart';

@immutable
sealed class NewsState {
  const NewsState();
}

final class NewsStateInitial extends NewsState {
  const NewsStateInitial();
}

final class NewsStateLoading extends NewsState {
  const NewsStateLoading();
}

final class NewsStateLoaded extends NewsState {
  const NewsStateLoaded(
      {required this.news,
      this.isFetching = false,
      this.isDataAvailable = false});
  final bool isFetching;
  final bool isDataAvailable;
  final List<NewsData> news;
}

final class NewsStateError extends NewsState {
  const NewsStateError({required this.ex});
  final AppException ex;
}

extension NewsStateExtention on NewsState {
  int? get newsLength => switch (this) {
        NewsStateInitial() => null,
        NewsStateLoading() => null,
        NewsStateLoaded(news: var news) => news.length,
        NewsStateError() => null,
      };
}
