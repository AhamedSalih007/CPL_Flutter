import 'package:flutter/foundation.dart';

import '../../core/utils/errors/app_exception.dart';
import '../models/media/media.dart';

@immutable
sealed class MediaState {
  const MediaState();
}

final class MediaStateInitial extends MediaState {
  const MediaStateInitial();
}

final class MediaStateLoading extends MediaState {
  const MediaStateLoading();
}

final class MediaStateLoaded extends MediaState {
  const MediaStateLoaded({
    required this.media,
  });

  final MediaDetails? media;
}

final class MediaStateError extends MediaState {
  const MediaStateError({required this.ex});
  final AppException ex;
}

extension MediaStateExtention on MediaState {}
