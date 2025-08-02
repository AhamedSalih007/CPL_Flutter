import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/result/data_state.dart';
import '../../../domain/models/media/media.dart';
import '../../../domain/states/media_state.dart';
import '../../../domain/usecases/news/news_usecases.dart';

part 'media_provider.g.dart';

@riverpod
class MediaNotifier extends _$MediaNotifier {
  late final GetMedia _getMedia = ref.watch(getMediaUseCaseProvider);

  @override
  MediaState build() {
    return const MediaStateInitial();
  }

  Future<void> getMedia({required int? mediaId}) async {
    if (mediaId != null) {
      state = const MediaStateLoading();
      var dataState = await _getMedia(mediaId);
      switch (dataState) {
        case DataStateSuccess<Media>(data: Media media):
          state = MediaStateLoaded(media: media.mediaDetails);
        case DataStateError<Media>(ex: var ex):
          state = MediaStateError(ex: ex);
      }
    }
  }
}
