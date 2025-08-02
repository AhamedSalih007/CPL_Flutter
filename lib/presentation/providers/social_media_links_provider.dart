import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/result/data_state.dart';
import '../../domain/models/social_media/social_media.dart';
import '../../domain/states/social_media_state.dart';
import '../../domain/usecases/social_media/social_media_usecases.dart';

part 'social_media_links_provider.g.dart';

@Riverpod(keepAlive: true)
class SocialMediaLinksNotifier extends _$SocialMediaLinksNotifier {
  late final GetSocialMediaLinks _getSocialMediaLinks =
      ref.watch(getSocialMediaLinksUseCaseProvider);

  @override
  SocialMediaState build() {
    return const SocialMediaStateInitial();
  }

  Future<void> getSocialMediaLinks() async {
    state = const SocialMediaStateLoading();
    var respo = await _getSocialMediaLinks();
    switch (respo) {
      case DataStateSuccess<List<SocialMediaData>?>(
          data: List<SocialMediaData>? data
        ):
        state = SocialMediaStateLoaded(
            socialMedia: (data != null && data.isNotEmpty)
                ? data.first.acf?.socialMedia ?? []
                : []);
      case DataStateError<List<SocialMediaData>>(ex: var ex):
        state = SocialMediaStateError(ex: ex);
    }
  }
}
