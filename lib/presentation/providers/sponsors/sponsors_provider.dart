import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/result/data_state.dart';
import '../../../domain/models/sponsors/sponsors.dart';
import '../../../domain/states/sponsors_state.dart';
import '../../../domain/usecases/sponsorship/sponsorship_usecases.dart';

part 'sponsors_provider.g.dart';

@Riverpod(keepAlive: true)
class SponsorsNotifier extends _$SponsorsNotifier {
  late final GetSponsors _sponsors = ref.watch(getSponsorsUseCaseProvider);

  @override
  SponsorsState build() {
    return const SponsorsStateInitial();
  }

  Future<void> getSponsors() async {
    state = const SponsorsStateLoading();
    var respo = await _sponsors();
    switch (respo) {
      case DataStateSuccess<List<SponsorsData>>(
          data: List<SponsorsData> sponsorData
        ):
        List<SponsorsData> cplSponsors = [];
        List<SponsorsData> wcplSponsors = [];
        for (var sponser in sponsorData) {
          if (sponser.slug != null &&
              sponser.slug!.toLowerCase().contains("women")) {
            wcplSponsors.add(sponser);
          } else {
            cplSponsors.add(sponser);
          }
        }
        state = SponsorsStateLoaded(
            cplSponsors: cplSponsors, wcplSponsors: wcplSponsors);
      case DataStateError<List<SponsorsData>>(ex: var ex):
        state = SponsorsStateError(ex: ex);
    }
  }
}
