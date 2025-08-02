part of 'news_usecases.dart';

@Riverpod(keepAlive: true)
GetMedia getMediaUseCase(GetMediaUseCaseRef ref) {
  return GetMedia(ref.watch(newsRepositoryProvider));
}

class GetMedia extends UseCase<DataState<Media>, int> {
  final NewsRepository _newsRepository;
  GetMedia(this._newsRepository);

  @override
  Future<DataState<Media>> call(int mediaId) async {
    return await _newsRepository.media(mediaId);
  }
}
