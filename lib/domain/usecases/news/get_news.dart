part of 'news_usecases.dart';

@Riverpod(keepAlive: true)
GetNews getNewsUseCase(GetNewsUseCaseRef ref) {
  return GetNews(ref.watch(newsRepositoryProvider));
}

class GetNews extends UseCase<DataState<List<NewsData>>, NewsParams> {
  final NewsRepository _newsRepository;
  GetNews(this._newsRepository);

  @override
  Future<DataState<List<NewsData>>> call(NewsParams params) async {
    return await _newsRepository.news(params.perPage, params.page);
  }
}

class NewsParams {
  int perPage;
  int page;
  NewsParams({required this.perPage, required this.page});
}
