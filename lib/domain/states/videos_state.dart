import 'package:flutter/foundation.dart';

import '../../core/utils/errors/app_exception.dart';
import '../models/videos/videos.dart';

@immutable
sealed class VideosState {
  const VideosState();
}

final class VideosStateInitial extends VideosState {
  const VideosStateInitial();
}

final class VideosStateLoading extends VideosState {
  const VideosStateLoading();
}

final class VideosStateLoaded extends VideosState {
  const VideosStateLoaded({required this.videos});
  final List<Videos> videos;

  @override
  String toString() => 'VideosStateLoaded(videos: $videos)';
}

final class VideosStateError extends VideosState {
  const VideosStateError(this.ex);
  final AppException ex;

  @override
  String toString() => 'VideosStateError(ex: $ex)';
}
