import 'package:flutter/foundation.dart';

import '../../core/utils/errors/app_exception.dart';
import '../models/yt_video/yt_video.dart';

@immutable
sealed class YtVideoState {
  const YtVideoState();
}

final class YtVideoStateInitial extends YtVideoState {
  const YtVideoStateInitial();
}

final class YtVideoStateLoading extends YtVideoState {
  const YtVideoStateLoading();
}

final class YtVideoStateLoaded extends YtVideoState {
  const YtVideoStateLoaded({
    required this.videos,
    this.isFetching = false,
  });
  final YtVideoData videos;
  final bool isFetching;

  @override
  String toString() => 'YtVideoStateLoaded(videos: $videos)';
}

final class YtVideoStateError extends YtVideoState {
  const YtVideoStateError(this.ex);
  final AppException ex;

  @override
  String toString() => 'YtVideoStateError(ex: $ex)';
}
