import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/configs/app_configuration.dart';
import '../../../data/models/result/data_state.dart';
import '../../../domain/enums/category.dart';
import '../../../domain/models/videos/videos.dart';
import '../../../domain/models/yt_video/yt_video.dart';
import '../../../domain/states/videos_state.dart';
import '../../../domain/states/yt_video_state.dart';
import '../../../domain/usecases/videos/videos_usecases.dart';
import '../home/home_provider.dart';

part 'video_provider.g.dart';

@riverpod
class VideoNotifier extends _$VideoNotifier {
  late final GetVideos _getVideos = ref.watch(getVideosUseCaseProvider);
  @override
  VideosState build() {
    return const VideosStateInitial();
  }

  Future<void> getVideos() async {
    state = const VideosStateLoading();
    var dataState = await _getVideos(
        ref.watch(selectedCategoryNotifierProvider) == CategoryType.cpl
            ? AppConfiguration.clientKey
            : AppConfiguration.wcplClientKey);
    switch (dataState) {
      case DataStateSuccess<List<Videos>>(data: var videos):
        state = VideosStateLoaded(videos: videos);
      case DataStateError<List<Videos>>(ex: var ex):
        state = VideosStateError(ex);
    }
  }
}

@riverpod
class HomeVideoNotifier extends _$HomeVideoNotifier {
  late final GetYtVideos _getYtVideos = ref.watch(getYtVideosUseCaseProvider);
  @override
  YtVideoState build() {
    return const YtVideoStateInitial();
  }

  Future<void> getHomeVideos() async {
    state = const YtVideoStateLoading();
    var dataState = await _getYtVideos("");
    switch (dataState) {
      case DataStateSuccess<YtVideoData>(data: var videos):
        state = YtVideoStateLoaded(videos: videos);
      case DataStateError<YtVideoData>(ex: var ex):
        state = YtVideoStateError(ex);
    }
  }
}

@riverpod
class YtVideoNotifier extends _$YtVideoNotifier {
  late final GetYtVideos _getYtVideos = ref.watch(getYtVideosUseCaseProvider);

  YtVideoData? _ytVideoData = const YtVideoData();
  String _nextPageToken = "";
  final List<YtItems> _ytItems = [];
  @override
  YtVideoState build() {
    return const YtVideoStateInitial();
  }

  Future<void> getVideos({
    String? pageToken,
    bool fetchMore = false,
    bool onRefresh = false,
  }) async {
    if (onRefresh) {
      _nextPageToken = "";
    }
    state = fetchMore
        ? YtVideoStateLoaded(
            videos: _ytVideoData?.copyWith(
                  items: _ytItems,
                  nextPageToken: _nextPageToken,
                ) ??
                const YtVideoData(),
            isFetching: true)
        : const YtVideoStateLoading();
    var dataState = await _getYtVideos(_nextPageToken);
    switch (dataState) {
      case DataStateSuccess<YtVideoData>(data: var videos):
        _ytVideoData = videos;
        _nextPageToken = videos.nextPageToken ?? "";
        if (!fetchMore) {
          _ytItems.clear();
        }
        if (videos.items != null && videos.items!.isEmpty) {
          state = YtVideoStateLoaded(videos: videos, isFetching: false);
          return;
        }
        _ytItems.addAll(videos.items?.toList() ?? []);
        state = YtVideoStateLoaded(
            videos:
                videos.copyWith(items: _ytItems, nextPageToken: _nextPageToken),
            isFetching: false);
        break;
      case DataStateError<YtVideoData>(ex: var ex):
        state = YtVideoStateError(ex);
    }
  }
}
