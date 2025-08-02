import '../../../core/utils/api/api_manager/api_manager.dart';
import '../../../core/utils/api/request_type.dart';
import '../../../core/utils/api/response/api_response.dart';
import '../../enums/endpoints.dart';
import '../../models/api/media/media_api_dto.dart';
import '../../models/api/news/news_api_dto.dart';
import '../../models/api/news/search_news/search_news_api_dto.dart';

class NewsRemoteDataSource {
  final ApiManager _apiManager;
  NewsRemoteDataSource(this._apiManager);

  Future<ApiResponse<List<NewsDataApiDto>>> news(int perPage, int page) async {
    return _apiManager.requestListAsync<NewsDataApiDto>(
        requestType: RequestType.get,
        endpoint: EndPoints.news.val(),
        queryParams: {
          "per_page": perPage,
          "page": page,
        });
  }

  Future<ApiResponse<List<SearchNewsDataApiDto>>> searchNews(
      String? keyword) async {
    return _apiManager.requestListAsync<SearchNewsDataApiDto>(
      requestType: RequestType.get,
      endpoint: EndPoints.searchNews.val(data: keyword),
    );
  }

  Future<ApiResponse<MediaApiDto>> media(int mediaId) async {
    return _apiManager.requestAsync<MediaApiDto>(
      requestType: RequestType.get,
      endpoint: EndPoints.media.val(data: mediaId),
    );
  }
}
