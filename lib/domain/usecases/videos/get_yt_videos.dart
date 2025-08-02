part of 'videos_usecases.dart';

@Riverpod(keepAlive: true)
GetYtVideos getYtVideosUseCase(GetYtVideosUseCaseRef ref) {
  return GetYtVideos(ref.watch(videoRepositoryProvider));
}

class GetYtVideos extends UseCase<DataState<YtVideoData>, String> {
  final VideoRepository _videoRepo;
  GetYtVideos(this._videoRepo);

  @override
  Future<DataState<YtVideoData>> call(String? pageToken) async {
    return _videoRepo.getYtVideos(
        pageToken: pageToken, cancelToken: CancelToken());
  }
}
