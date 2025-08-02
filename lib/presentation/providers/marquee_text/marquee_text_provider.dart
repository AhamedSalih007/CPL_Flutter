import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/result/data_state.dart';
import '../../../domain/models/marquee_text/marquee_text.dart';
import '../../../domain/states/marquee_text_state.dart';
import '../../../domain/usecases/banners/banners_usecases.dart';

part 'marquee_text_provider.g.dart';

@riverpod
class MarqueeNotifier extends _$MarqueeNotifier {
  late final GetMarqueeText _getMarqueeText =
      ref.watch(getMarqueeTextUseCaseProvider);
  @override
  MarqueeTextState build() {
    return const MarqueeTextStateInitial();
  }

  Future<void> getMarqueeText() async {
    state = const MarqueeTextStateLoading();
    var dataState = await _getMarqueeText();
    switch (dataState) {
      case DataStateSuccess<List<MarqueeTextData>>(data: var marqueeTextData):
        if (marqueeTextData.isNotEmpty &&
            marqueeTextData[0].acf != null &&
            marqueeTextData[0].acf?.marqueeText != null &&
            (marqueeTextData[0].acf?.marqueeText?.isNotEmpty ?? false)) {
          state = MarqueeTextStateLoaded(
              marqueeText: marqueeTextData[0].acf?.marqueeText! ?? []);
        }
      case DataStateError<List<MarqueeTextData>>(ex: var ex):
        state = MarqueeTextStateError(ex);
    }
  }
}
