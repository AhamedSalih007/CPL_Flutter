part of 'videos_usecases.dart';

@Riverpod(keepAlive: true)
GetVideos getVideosUseCase(GetVideosUseCaseRef ref) {
  return GetVideos(ref.watch(videoRepositoryProvider));
}

class GetVideos extends UseCase<DataState<List<Videos>>, String> {
  final VideoRepository _videoRepo;
  GetVideos(this._videoRepo);

  @override
  Future<DataState<List<Videos>>> call(String clientKey) async {
    return _videoRepo.getVideos(
        clientKey: clientKey, cancelToken: CancelToken());
  }
}
