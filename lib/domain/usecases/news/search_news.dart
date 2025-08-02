part of 'news_usecases.dart';

@Riverpod(keepAlive: true)
SearchNews searchNewsUseCase(SearchNewsUseCaseRef ref) {
  return SearchNews(ref.watch(newsRepositoryProvider));
}

class SearchNews extends UseCase<DataState<List<SearchNewsData>>, String?> {
  final NewsRepository _newsRepository;
  SearchNews(this._newsRepository);

  @override
  Future<DataState<List<SearchNewsData>>> call(String? keyword) async {
    return await _newsRepository.searchNews(keyword);
  }
}
