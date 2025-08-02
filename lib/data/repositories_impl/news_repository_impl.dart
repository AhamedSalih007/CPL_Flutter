import '../../core/utils/api/response/api_response.dart';
import '../../domain/models/media/media.dart';
import '../../domain/models/news/news.dart';
import '../../domain/models/news/search_news/search_news.dart';
import '../../domain/repositories/news_repository.dart';
import '../data_source/remote/news_remote_data_source.dart';
import '../models/api/media/media_api_dto.dart';
import '../models/api/news/news_api_dto.dart';
import '../models/api/news/search_news/search_news_api_dto.dart';
import '../models/result/data_state.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource _newsRemoteDataSource;
  NewsRepositoryImpl(this._newsRemoteDataSource);

  @override
  Future<DataState<List<NewsData>>> news(int perPage, int page) async {
    final newsResponse = await _newsRemoteDataSource.news(perPage, page);
    switch (newsResponse) {
      case ApiResponseSuccess<List<NewsDataApiDto>>(
          data: List<NewsDataApiDto> res
        ):
        return DataStateSuccess(res.map((e) => e.toModel()).toList());
      case ApiResponseError<List<NewsDataApiDto>>(ex: var ex):
        return DataStateError(ex);
    }
  }

  @override
  Future<DataState<List<SearchNewsData>>> searchNews(String? keyword) async {
    final newsResponse = await _newsRemoteDataSource.searchNews(keyword);
    switch (newsResponse) {
      case ApiResponseSuccess<List<SearchNewsDataApiDto>>(
          data: List<SearchNewsDataApiDto> res
        ):
        return DataStateSuccess(res.map((e) => e.toModel()).toList());
      case ApiResponseError<List<SearchNewsDataApiDto>>(ex: var ex):
        return DataStateError(ex);
    }
  }

  @override
  Future<DataState<Media>> media(int mediaId) async {
    final newsResponse = await _newsRemoteDataSource.media(mediaId);
    switch (newsResponse) {
      case ApiResponseSuccess<MediaApiDto>(data: MediaApiDto res):
        return DataStateSuccess(res.toModel());
      case ApiResponseError<MediaApiDto>(ex: var ex):
        return DataStateError(ex);
    }
  }
}
