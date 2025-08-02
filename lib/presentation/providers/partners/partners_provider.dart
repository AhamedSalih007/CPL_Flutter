import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/result/data_state.dart';
import '../../../domain/models/partners/partners.dart';
import '../../../domain/states/partners_state.dart';
import '../../../domain/usecases/sponsorship/sponsorship_usecases.dart';

part 'partners_provider.g.dart';

@Riverpod(keepAlive: true)
class PartnersNotifier extends _$PartnersNotifier {
  late final GetPartners _getPartners = ref.watch(getPartnersUseCaseProvider);

  @override
  PartnersState build() {
    return const PartnersStateInitial();
  }

  Future<void> getPartners() async {
    state = const PartnersStateLoading();
    var respo = await _getPartners();
    switch (respo) {
      case DataStateSuccess<List<PartnersData>>(
          data: List<PartnersData> partnersData
        ):
        List<PartnersData> cplPartners = [];
        List<PartnersData> wcplPartners = [];
        for (var partner in partnersData) {
          if (partner.slug != null &&
              partner.slug!.toLowerCase().contains("women")) {
            wcplPartners.add(partner);
          } else {
            cplPartners.add(partner);
          }
        }
        state = PartnersStateLoaded(
            cplPartners: cplPartners, wcplPartners: wcplPartners);
      case DataStateError<List<PartnersData>>(ex: var ex):
        state = PartnersStateError(ex: ex);
    }
  }
}
