import '../../data/models/result/data_state.dart';
import '../models/media/media.dart';
import '../models/news/news.dart';
import '../models/news/search_news/search_news.dart';

abstract interface class NewsRepository {
  Future<DataState<List<NewsData>>> news(int perPage, int page);
  Future<DataState<List<SearchNewsData>>> searchNews(String? keyword);
  Future<DataState<Media>> media(int mediaId);
}
